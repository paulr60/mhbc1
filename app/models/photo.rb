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

	mount_uploader :image, ImageUploader
end
