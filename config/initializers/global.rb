# Global data

require 'RMagick'
include Magick

class BannerImages
    attr_reader :logo_image, :banner_image
    attr_writer :logo_image, :banner_image

    def initialize
        @logo_image = nil   #scaled image
        @banner_image = nil #scaled image
        @logo_photo = nil   #raw input - photo name
        @banner_photo = nil #raw input - photo name
        @ht = 220
        @wd = 860
    end

    def logo_image
        @logo_image || 'default_logo.jpg'
    end
    def banner_image
        @banner_image || 'default_bannerpic.jpg'
    end

    def set_logo_photo(photo, logo_pct)
        @logo_photo = photo
        if photo.blank?
            @logo_image = nil
            return
        end
        @logo_image = scaled_image(photo, logo_pct)
    end

    def set_banner_photo(photo, logo_pct)
        @banner_photo = photo
        if photo.blank?
            @banner_image = nil
            return
        end
        @banner_image = scaled_image(photo, 100 - logo_pct)
    end

    private
        def scaled_image(photo, pct_wd)
            debugger
            p_obj = Photo.find_by_name(photo)
            p = p_obj.image_url
            w = @wd * pct_wd / 100
            base_image = Magick::Image.read(p)
            img = base_image[0].resize_to_fit(w, @ht)
        end
end

$banner = BannerImages.new
