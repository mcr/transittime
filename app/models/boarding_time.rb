class BoardingTime < ActiveRecord::Base

  belongs_to :transit_route
  belongs_to :transit_stop
end
