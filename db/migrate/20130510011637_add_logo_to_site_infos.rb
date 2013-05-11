class AddLogoToSiteInfos < ActiveRecord::Migration
  def change
    add_column :site_infos, :logo, :string
    add_column :site_infos, :bannerpic, :string
    add_column :site_infos, :logowidth, :integer
    add_column :site_infos, :calendarheight, :integer
  end
end
