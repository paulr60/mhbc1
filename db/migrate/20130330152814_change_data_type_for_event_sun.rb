class ChangeDataTypeForEventSun < ActiveRecord::Migration
    def up
        change_table :events do |e|
            e.change :sun, :boolean, :default => false
            e.change :mon, :boolean, :default => false
            e.change :tue, :boolean, :default => false
            e.change :wed, :boolean, :default => false
            e.change :thu, :boolean, :default => false
            e.change :fri, :boolean, :default => false
            e.change :sat, :boolean, :default => false
        end
    end

    def down
        change_table :events do |e|
            e.change :sun, :boolean, :default => true
            e.change :mon, :boolean, :default => true
            e.change :tue, :boolean, :default => true
            e.change :wed, :boolean, :default => true
            e.change :thu, :boolean, :default => true
            e.change :fri, :boolean, :default => true
            e.change :sat, :boolean, :default => true
        end
    end
end
