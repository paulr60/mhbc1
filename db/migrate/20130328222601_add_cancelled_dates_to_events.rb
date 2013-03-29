class AddCancelledDatesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :cancelled_dates, :text
  end
end
