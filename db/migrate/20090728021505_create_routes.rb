class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.string :name
      t.integer :starting_place_id
      t.integer :ending_place_id

      t.timestamps
    end
  end

  def self.down
    drop_table :routes
  end
end
