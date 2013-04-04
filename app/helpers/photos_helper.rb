module PhotosHelper

    def photo_tag_to_original(name, version)
    	return "" if name.blank?

        p = Photo.photo_object(name)
    	return "" if !p

    	link_to(image_tag(p.image_url(version)), p.image_url)
    end
    
end
