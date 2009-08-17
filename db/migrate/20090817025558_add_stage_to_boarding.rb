class AddStageToBoarding < ActiveRecord::Migration
  def self.up
    add_column :boarding_times, :transit_stage_id, :integer
  end

  def self.down
    remove_column :boarding_times, :transit_stage_id
  end
end
