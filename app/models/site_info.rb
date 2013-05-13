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
#  bannerpic  :string(255)
#

class SiteInfo < ActiveRecord::Base
 	attr_accessible :address, :email, :phone, :title, :weekly, :menubar, :bannerpic

    before_validation :strip_whitespace

 	validates :address, presence: true
 	validates :title, presence: true
	validates :phone, presence: true, length: { minimum: 12 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

    validate :valid_menubar, :valid_bannerpic

    def strip_whitespace
        self.title.strip! if self.title.blank? == false
        self.phone.strip! if self.phone.blank? == false
        self.email.strip! if self.email.blank? == false
        self.address.strip!   if self.address.blank? == false
        self.bannerpic.strip! if self.bannerpic.blank? == false
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

    def default_bannerpics
        ['default_logo.jpg', 'default_bannerpic.jpg']
    end
    
    def custom_bannerpics
        pics = valid_bannerpic
        return pics
    end

    def valid_bannerpic
        return false if bannerpic.blank?
        toks = bannerpic.split(',')
        if toks.length != 2
            errors.add :bannerpic, "List names of logo & banner photos, comma-separated"
            return false
        end
        pics = []
        toks.each do |t|
            t.strip!
            p = Photo.find_by_name(t)
            if p == nil
                errors.add :bannerpic, "Photo #{t} not found"
                return false
            end
            pics << p
        end
        return pics
    end
    
#    def valid_bannerpic
#        return false if bannerpic.blank?
#        debugger
#        target_width = 860
#        target_height = nil
#        total_width = 0
#        toks = bannerpic.split(',')
#        pics = []
#        toks.each do |t|
#            t.strip!
#            p = Photo.find_by_name(t)
#            if p
#                pics << p
#                if p.custom_sized? == false
#                    errors.add :bannerpic, "#{t} does not have custom size set"
#                    return false
#                end
#                target_height ||= p.custom_height
#                if p.custom_height != target_height
#                    errors.add :bannerpic, "Mismatched custom heights"
#                    return false
#                end
#                total_width += p.custom_width
#            else
#                errors.add :bannerpic, "Photo #{t} not found"
#            end
#        end
#        if total_width > target_width
#            errors.add :bannerpic, "Total width (#{total_width}) > max width (#{target_width})"
#            return false
#        end
#        return pics
#    end

end
