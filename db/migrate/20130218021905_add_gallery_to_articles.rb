class AddGalleryToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :gallery, :string
  end
end
