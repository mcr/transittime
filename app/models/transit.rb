class Transit < ActiveRecord::Base
  has_many :schedule
  has_many :transit_stops, :through => :schedule

  has_one :starting_place, :class_name => "Place"
  has_one :ending_place,   :class_name => "Place"

  belongs_to :booking

end
