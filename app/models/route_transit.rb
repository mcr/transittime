class RouteTransit < ActiveRecord::Base

  belongs_to :route
  belongs_to :transit
end
