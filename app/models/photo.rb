# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  image       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  custom_size :string(255)
#

class Photo < ActiveRecord::Base
 	attr_accessible :name, :image, :custom_size

    before_validation :strip_whitespace

	validates :name, presence: true, uniqueness: true
    validate :valid_custom_size

	mount_uploader :image, ImageUploader

    def strip_whitespace
        self.name.strip!    if self.name.blank? == false
        if self.custom_size.blank? == false
            self.custom_size.strip!
            self.custom_size.downcase!
        end
    end

    def custom_sized?
        valid_custom_size
    end

	def image_size(version)
    	self.image_url(version)
    end

    def Photo.photo_object(name)
        p = (name.class == Photo) ? name : Photo.find_by_name(name)
        return p
    end

    def Photo.photos_matching_regexp(pattern)
    	re = pattern.gsub('*', '%')
    	return Photo.where("name LIKE ?", re)
    end

    def custom_width
        return 0 if valid_custom_size == false
        toks = custom_size.split('x')
        toks[0].to_i
    end
    def custom_height
        return 0 if valid_custom_size == false
        toks = custom_size.split('x')
        toks[1].to_i
    end

    private

        def valid_custom_size
            return false if custom_size.blank?
            if /\d+\s*x\s*\d+/.match(custom_size) == false
                errors.add :custom_size, "Should be of form W x H, e.g. 440 x 220"
                return false
            end

            min_size = 1
            max_size = 5000
            toks = custom_size.split('x')
            w = toks[0].to_i
            h = toks[1].to_i

            if (w < min_size) || (w > max_size) || (h < min_size) || (h > max_size)
                errors.add :custom_size, "Min: #{min_size} and Max: #{max_size}"
                return false
            end
            return true
        end

end
