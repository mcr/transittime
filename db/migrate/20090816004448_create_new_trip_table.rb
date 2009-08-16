class CreateNewTripTable < ActiveRecord::Migration
  def self.up
    create_table :trip do |t|
      t.date    :trip_start
      t.date    :trip_end
      t.integer :starting_place_id
      t.integer :ending_place_id
      t.string  :trip_name
    end
  end

  def self.down
    drop_table :trip
  end
end
