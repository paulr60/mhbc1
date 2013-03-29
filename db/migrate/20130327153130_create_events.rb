class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :article
      t.date :date
      t.time :start_time
      t.date :start_date
      t.date :end_date
      t.boolean :sun, :default => true
      t.boolean :mon, :default => true
      t.boolean :tue, :default => true
      t.boolean :wed, :default => true
      t.boolean :thu, :default => true
      t.boolean :fri, :default => true
      t.boolean :sat, :default => true

      t.timestamps
    end
  end
end
