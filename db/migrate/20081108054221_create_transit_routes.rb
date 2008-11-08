class CreateTransitRoutes < ActiveRecord::Migration
  def self.up
    create_table :transit_routes do |t|
      t.string :direction1_name
      t.string :direction2_name

      t.timestamps
    end
  end

  def self.down
    drop_table :transit_routes
  end
end
