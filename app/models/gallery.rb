# == Schema Information
#
# Table name: galleries
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  photos      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class Gallery < ActiveRecord::Base
    attr_accessible :name, :description, :photos

    before_validation :strip_whitespace

    validates :name, presence: true
    validates :photos, presence: true
    validate :validate_photo_list

    def strip_whitespace
        self.name.strip!
        self.photos.strip!
    end

    def validate_photo_list
        errs = self.photo_list_validate()
        if errs && errs.length > 0
            errs.each do |e|
                errors.add(:photos, e)
            end
        end
    end

    def photo_list()
		photo_list_helper(self.photos, false)
	end
	def photo_list_validate()
		photo_list_helper(self.photos, true)
	end
	def photo_list_helper(name_list, validate)
		errors = []
		photos = []
		tokens = name_list.split(',')

		tokens.each do |tok|
			tok.strip!
			if tok.index('*') == nil
				matching = Photo.find_by_name(tok)
				photos << matching if matching
		    else
                matching = Photo.photos_matching_regexp(tok)
		        if matching && matching.length > 0
		            matching.each { |p| photos << p }
                else
                    matching = nil
                end
            end
            if matching == nil
                errors << "#{tok} not found"
		    end
		end

        return validate ? errors : photos
	end

	def cover_photo()
		photos = photo_list()
		photos ? photos[0] : nil
	end
end
