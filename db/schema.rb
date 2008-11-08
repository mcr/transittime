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

ActiveRecord::Schema.define(:version => 20081108054221) do

  create_table "boarding_times", :force => true do |t|
    t.integer  "transit_stop_id"
    t.string   "vehiclecode"
    t.datetime "boardtime"
    t.integer  "transit_route_id"
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
    t.string   "stopcode"
    t.string   "latlong"
    t.string   "crossstreet1"
    t.string   "crossstreet2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
