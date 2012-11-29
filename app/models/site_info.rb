# == Schema Information
#
# Table name: site_infos
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  phone      :string(255)
#  email      :string(255)
#  address    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  weekly     :string(255)
#

class SiteInfo < ActiveRecord::Base
 	attr_accessible :address, :email, :phone, :title, :weekly

 	validates :address, presence: true
 	validates :title, presence: true
	validates :phone, presence: true, length: { minimum: 12 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
end
