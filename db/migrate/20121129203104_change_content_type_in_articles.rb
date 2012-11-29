class ChangeContentTypeInArticles < ActiveRecord::Migration
  def up
  	change_column :articles, :content, :text
  	change_column :articles, :summary, :text
  	change_column :articles, :rank, :integer, :default => 5
  end

  def down
  	change_column :articles, :rank, :integer
  	change_column :articles, :summary, :string
  	change_column :articles, :content, :string
  end
end
