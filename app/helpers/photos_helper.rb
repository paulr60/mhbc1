module PhotosHelper

	def photo_version(name, version)
    	p = Photo.find_by_name(name)
    	p ? p.image_url(version) : nil
    end

    def photo_tag_to_original(name, version)
    	debugger
    	return "" if name.blank?

    	if name.class == Photo 		# Arg is Photo obj, not name of photo
    		p = name
    	else
	    	p = Photo.find_by_name(name)
	    end
    	return "" if !p

    	link_to(image_tag(p.image_url(version)), p.image_url)
    end

    def photos_matching_regexp(pattern)
    	pattern.gsub!('*', '%')
    	return Photo.where("name LIKE ?", pattern)
    end
end
