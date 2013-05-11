# Global data

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
        p = Photo.find_by_name(photo)
    end

    def set_banner_photo(photo, logo_pct)
        @banner_photo = photo
        p = Photo.find_by_name(photo)
    end
end

$banner = BannerImages.new
