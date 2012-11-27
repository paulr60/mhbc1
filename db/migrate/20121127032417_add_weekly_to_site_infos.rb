class AddWeeklyToSiteInfos < ActiveRecord::Migration
  def change
    add_column :site_infos, :weekly, :string
  end
end
