# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090815224957) do

  create_table "boarding_times", :force => true do |t|
    t.integer  "transit_stop_id"
    t.string   "vehiclecode"
    t.datetime "boardtime"
    t.integer  "transit_route_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", :force => true do |t|
    t.date     "starting_day"
    t.date     "ending_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "googlemapurl"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "route_transits", :force => true do |t|
    t.integer  "route_id"
    t.integer  "transit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "routes", :force => true do |t|
    t.string   "name"
    t.integer  "starting_place_id"
    t.integer  "ending_place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_transit_cnt",   :default => 9
  end

  create_table "schedules", :force => true do |t|
    t.integer  "transit_id"
    t.integer  "stop_id"
    t.time     "departure_time"
    t.string   "validdays"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transit_routes", :force => true do |t|
    t.string   "direction1_name"
    t.string   "direction2_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transit_stops", :force => true do |t|
    t.string   "name"
    t.integer  "place_id"
    t.string   "sign_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transits", :force => true do |t|
    t.string   "name"
    t.integer  "starting_place_id"
    t.integer  "ending_place_id"
    t.string   "type"
    t.string   "route_num"
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
