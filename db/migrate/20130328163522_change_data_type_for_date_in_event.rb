class ChangeDataTypeForDateInEvent < ActiveRecord::Migration
    def up
        change_table :events do |t|
            t.change :date, :string
            t.change :start_time, :string
            t.change :start_date, :string
            t.change :end_date, :string
        end
    end

    def down
        change_table :events do |t|
            t.change :date, :date
            t.change :start_time, :time
            t.change :start_date, :date
            t.change :end_date, :date
        end
    end
end
