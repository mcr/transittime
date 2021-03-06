class Place < ActiveRecord::Base

  has_many :transit_stops
  has_many :starting_transits, :class_name => "Transit", :foreign_key => :starting_place_id
  has_many :ending_transits,   :class_name => "Transit", :foreign_key => :ending_place_id

  has_many :starting_routes, :class_name => "Route", :foreign_key => :starting_place_id
  has_many :ending_routes,   :class_name => "Route", :foreign_key => :ending_place_id
  
  has_many :starting_trips, :class_name => "Trip", :foreign_key => :starting_place_id
  has_many :ending_trips,   :class_name => "Trip", :foreign_key => :ending_place_id
  
end
