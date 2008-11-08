class CreateTransitStops < ActiveRecord::Migration
  def self.up
    create_table :transit_stops do |t|
      t.string :stopcode
      t.string :latlong
      t.string :crossstreet1
      t.string :crossstreet2

      t.timestamps
    end
  end

  def self.down
    drop_table :transit_stops
  end
end
