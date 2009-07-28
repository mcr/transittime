class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.date :starting_day
      t.date :ending_day

      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end
