class ChangeDataTypeForArticlesImage < ActiveRecord::Migration
  def up
  	change_table :articles do |t|
  		t.change :image, :string
  	end
  end

  def down
  	change_table :articles do |t|
  		t.change :image, :text
  	end
  end
end
