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

	validates :name, presence: true
    validates :image, presence: true

	mount_uploader :image, ImageUploader

    
	def image_size(version)
    	self.image_url(version)
    end

    def Photo.photo_tag_to_original(name, version)
    	return "" if name.blank?

        p = photo_object(name)
    	return "" if !p

    	link_to(image_tag(p.image_url(version)), p.image_url)
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
