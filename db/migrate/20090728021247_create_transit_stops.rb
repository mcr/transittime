class CreateTransitStops < ActiveRecord::Migration
  def self.up
    create_table :transit_stops do |t|
      t.string :name
      t.integer :place_id
      t.string :sign_no

      t.timestamps
    end
  end

  def self.down
    drop_table :transit_stops
  end
end
