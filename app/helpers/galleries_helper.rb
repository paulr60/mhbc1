module GalleriesHelper

	def photo_list(name_list)
		photo_list_helper(name_list, false)
	end
	def photo_list_validate(name_list)
		photo_list_helper(names_list true)
	end
	def photo_list_helper(name_list, validate)
		errors = []
		photos = []
		tokens = name_list.split(',')
		debugger

		tokens.each do |tok|
			tok.strip!
			if tok.index('*') == nil
		        begin
		            photo = Photo.where("name = ?", tok)
		            photos << photo[0]
		        rescue
		            errors << "Photo #{tok} doesn't exist"
		        end
		    else
		    	tok.gsub!('*', '%')
		        begin
		            photo = Photo.where("name LIKE ?", tok)
		            photo.each { |p| photos << p }
		        rescue
		            errors << "Photo #{tok} doesn't exist"
		        end
		    end
		end

		if validate
			return errors
		else
			return photos
		end
	end

	def cover_photo(id_string)
		photos = photo_list(id_string)
		photos ? photos[0] : nil
	end

	def photo_list_by_id(id_string)
		photo_list_by_id_helper(id_string, false)
	end
	def photo_list_by_id_validate(id_string)
		photo_list_by_id_helper(id_string, true)
	end
	def photo_list_by_id_helper(id_string, validate)
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
