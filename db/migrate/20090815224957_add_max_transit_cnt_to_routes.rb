class AddMaxTransitCntToRoutes < ActiveRecord::Migration
  def self.up
    add_column :routes, :max_transit_cnt, :integer, :default => 9
  end

  def self.down
    remove_column :routes, :max_transit_cnt
  end
end
