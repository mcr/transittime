class AddTripToBoardingTime < ActiveRecord::Migration
  def self.up
    add_column :boarding_times, :trip_id, :integer
  end

  def self.down
    remove_column :boarding_times, :trip_id
  end
end
