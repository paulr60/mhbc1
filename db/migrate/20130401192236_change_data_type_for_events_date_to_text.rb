class ChangeDataTypeForEventsDateToText < ActiveRecord::Migration
  def up
      change_column :events, :date, :text
  end

  def down
      change_column :events, :date, :string
  end
end
