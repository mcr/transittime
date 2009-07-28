class Place < ActiveRecord::Base

  has_many :transit_stops
  has_many :starting_places, :class_name => :transits, :foreign_key => :starting_place_id
  has_many :ending_places,   :class_name => :transits, :foreign_key => :ending_place_id
  
end
