class Transit < ActiveRecord::Base
  has_many :schedule
  has_many :transit_stops, :through => :schedule

  has_one :starting_place, :class_name => :place
  has_one :ending_place,   :class_name => :place

  belongs_to :booking

end
