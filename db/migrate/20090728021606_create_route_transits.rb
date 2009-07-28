class CreateRouteTransits < ActiveRecord::Migration
  def self.up
    create_table :route_transits do |t|
      t.integer :route_id
      t.integer :transit_id

      t.timestamps
    end
  end

  def self.down
    drop_table :route_transits
  end
end
