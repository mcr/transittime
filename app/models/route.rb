class Route < ActiveRecord::Base
  has_one :starting_place, :class_name => "Place", :foreign_key => :starting_place_id
  has_one :ending_place,   :class_name => "Place", :foreign_key => :ending_place_id
end
