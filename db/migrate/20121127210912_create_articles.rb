class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :label
      t.string :content
      t.string :summary
      t.boolean :publish
      t.boolean :frontpage
      t.string :menu
      t.integer :rank

      t.timestamps
    end
  end
end
