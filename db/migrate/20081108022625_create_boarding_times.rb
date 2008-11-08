class CreateBoardingTimes < ActiveRecord::Migration
  def self.up
    create_table :boarding_times do |t|
      t.integer  :transit_stop_id
      t.string   :vehiclecode
      t.datetime :boardtime
      t.integer  :transit_route_id

      t.timestamps
    end
  end

  def self.down
    drop_table :boarding_times
  end
end
