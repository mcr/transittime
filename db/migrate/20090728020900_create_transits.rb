class CreateTransits < ActiveRecord::Migration
  def self.up
    create_table :transits do |t|
      t.string :name
      t.integer :starting_place_id
      t.integer :ending_place_id
      t.string :type
      t.string :route_num
      t.integer :booking_id

      t.timestamps
    end
  end

  def self.down
    drop_table :transits
  end
end
