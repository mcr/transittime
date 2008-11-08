class CreateBoardingTimes < ActiveRecord::Migration
  def self.up
    create_table :boarding_times do |t|
      t.string :stopcode
      t.string :vehiclecode
      t.datetime :boardtime
      t.string :routenumber

      t.timestamps
    end
  end

  def self.down
    drop_table :boarding_times
  end
end
