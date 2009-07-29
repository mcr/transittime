class RouteTransit < ActiveRecord::Base

  has_one :starting_place, :class => :places
  has_one :ending_place,   :class => :places
end
