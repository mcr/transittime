class Transit < ActiveRecord::Base
  has_many :schedule
  has_many :transit_stops, :through => :schedule

  belongs_to :starting_place, :class_name => "Place"
  belongs_to :ending_place,   :class_name => "Place"

  belongs_to :booking

end
