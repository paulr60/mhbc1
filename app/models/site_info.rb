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
#  menubar    :string(255)
#

class SiteInfo < ActiveRecord::Base
 	attr_accessible :address, :email, :phone, :title, :weekly, :menubar

    before_validation :strip_whitespace

 	validates :address, presence: true
 	validates :title, presence: true
	validates :phone, presence: true, length: { minimum: 12 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

    validate :valid_menubar

    def strip_whitespace
        self.title.strip!
        self.phone.strip!
        self.email.strip!
        self.address.strip!
    end

    def facebook
        "http://www.facebook.com/groups/47631568230"
    end

    def valid_menubar
        restricted = ['Home', 'News', 'Account']
        toks = menubar.split
        toks.each do |t|
            if restricted.include?(t)
                errors.add :menubar, "#{t} is not a legal value"
            end
        end
    end
end
