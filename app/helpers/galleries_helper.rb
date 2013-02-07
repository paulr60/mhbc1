module GalleriesHelper

	def photo_list_validate(id_string)
		photo_list_helper(id_string, true)
	end
	def photo_list(id_string)
		photo_list_helper(id_string, false)
	end
	def cover_photo(id_string)
		photos = photo_list(id_string)
		photos ? photos[0] : nil
	end
	def photo_list_helper(id_string, validate)
		errors = []
		ids = []
		tokens = id_string.split

		tokens.each do |tok|
			val = eval(tok)
			if val.kind_of?(Range)
				val.each { |n| ids << n }
			elsif val.kind_of?(Integer)
				ids << val
			else
				errors << "Unrecognized value: #{tok}"
			end
		end
				
		photos = []
		ids.each do |id|
	        begin
	            photo = Photo.find(id)
	            photos << photo
	        rescue
	            errors << "Photo #{id} doesn't exist"
	        end
	    end

        if (validate)
        	return errors
        else
			return photos
		end
	end
end
