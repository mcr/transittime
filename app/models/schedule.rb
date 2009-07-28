class Schedule < ActiveRecord::Base

  belongs_to :transit
  belongs_to :transit_stop
end
