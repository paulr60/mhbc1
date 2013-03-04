module PhotosHelper

    def photo_object(name)
    	if name.class == Photo 		# Arg is Photo obj, not name of photo
    		p = name
    	else
	    	p = Photo.find_by_name(name)
	    end
        return p
    end

	def photo_version(name, version)
    	p = photo_object(name)
    	p ? p.image_url(version) : nil
    end

    def photo_tag_to_original(name, version)
    	return "" if name.blank?

        p = photo_object(name)
    	return "" if !p

    	link_to(image_tag(p.image_url(version)), p.image_url)
    end

    def photos_matching_regexp(pattern)
    	pattern.gsub!('*', '%')
    	return Photo.where("name LIKE ?", pattern)
    end
end
