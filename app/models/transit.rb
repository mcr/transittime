class Transit < ActiveRecord::Base
  has_many :schedule
  has_many :transit_stops, :through => :schedule

  belongs_to :starting_place, :class_name => "Place"
  belongs_to :ending_place,   :class_name => "Place"

  belongs_to :booking

  def board_at(code, n = Time.now)
    boarding = BoardingTime.new(:transit_stage => self,
				:boardtime     => n,
				:vehiclecode   => code)
    boarding.transit_stop = self.starting_place.transit_stops.first
    boarding
  end

end
