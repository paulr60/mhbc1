# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  image      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Photo < ActiveRecord::Base
 	attr_accessible :name, :image

    before_validation :strip_whitespace

	validates :name, presence: true

	mount_uploader :image, ImageUploader

    def strip_whitespace
        self.name.strip!
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
end
