class RenameBoardtimeAndVehiclecode < ActiveRecord::Migration
  def self.up
    rename_column :boarding_times, :boardtime,   :boarding_time
    rename_column :boarding_times, :vehiclecode, :vehicle_code
  end

  def self.down
    rename_column :boarding_times, :boarding_time, :boardtime
    rename_column :boarding_times, :vehicle_code, :vehiclecode
  end
end
