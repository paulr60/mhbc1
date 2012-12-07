class AddMenubarToSiteInfos < ActiveRecord::Migration
  def change
    add_column :site_infos, :menubar, :string
  end
end
