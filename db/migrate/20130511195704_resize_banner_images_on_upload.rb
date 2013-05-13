class ResizeBannerImagesOnUpload < ActiveRecord::Migration
    def up
        add_column :photos, :custom_size, :string

        remove_column :site_infos, :logo
        remove_column :site_infos, :logowidth
        remove_column :site_infos, :calendarheight
    end

    def down
        remove_column :photos, :custom_size

        add_column :site_infos, :logo, :string
        add_column :site_infos, :logowidth, :integer
        add_column :site_infos, :calendarheight, :integer
    end
end
