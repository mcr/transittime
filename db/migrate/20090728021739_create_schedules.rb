class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.integer :transit_id
      t.integer :stop_id

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
