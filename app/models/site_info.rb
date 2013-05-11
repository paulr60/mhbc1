# == Schema Information
#
# Table name: site_infos
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  phone          :string(255)
#  email          :string(255)
#  address        :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  weekly         :string(255)
#  menubar        :string(255)
#  logo           :string(255)
#  bannerpic      :string(255)
#  logowidth      :integer
#  calendarheight :integer
#

require 'RMagick'
include Magick

class SiteInfo < ActiveRecord::Base
 	attr_accessible :address, :email, :phone, :title, :weekly, :menubar,
                    :logo, :bannerpic, :logowidth

    attr_accessor :logo_image, :banner_image

    before_validation :strip_whitespace
    before_save :create_banner_images

 	validates :address, presence: true
 	validates :title, presence: true
	validates :phone, presence: true, length: { minimum: 12 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

    validate :valid_menubar, :valid_logo, :valid_bannerpic, :valid_logowidth

    def strip_whitespace
        self.title.strip!
        self.phone.strip!
        self.email.strip!
        self.address.strip!
        self.logo.strip!
        self.bannerpic.strip!
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

    def valid_logowidth
        return if logowidth.blank? || (logowidth >= 0 && logowidth <= 100)
        errors.add :logowidth, "Must be >= 0 and <= 100"
    end
    
    def valid_logo
        return if logo.blank?
        p = Photo.find_by_name(logo)
        errors.add :logo, "Photo (#{logo}) not found" if p == nil
    end

    def valid_bannerpic
        return if bannerpic.blank?
        p = Photo.find_by_name(bannerpic)
        errors.add :bannerpic, "Photo (#{bannerpic}) not found" if p == nil
    end

    def create_banner_images
        base_logo_pic = logo.blank? ? ActionController::Base.helpers.asset_path('default_logo.jpg') :
                                        Photo.find_by_name(logo).image_url
        base_bannerpic = bannerpic.blank? ? ActionController::Base.helpers.asset_path('default_bannerpic.jpg') :
                                        Photo.find_by_name(bannerpic).image_url
        debugger

        lw_pct = logowidth || 30
        lw = 860 * lw_pct / 100
        bw = 860 * (100 - lw_pct) / 100
        ht = 220

        # li = Magick::Image.read(base_logo_pic)
        # bi = Magick::Image.read(base_bannerpic)

        # $global.logo_image = li
        # $global.banner_image = bi
    end
end
