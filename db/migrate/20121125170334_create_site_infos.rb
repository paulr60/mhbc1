class CreateSiteInfos < ActiveRecord::Migration
  def change
    create_table :site_infos do |t|
      t.string :title
      t.string :phone
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
