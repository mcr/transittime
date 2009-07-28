class Transit < ActiveRecord::Base
  has_many :schedule
  has_many :transit_stops, :through => :schedule

  belongs_to :booking

end
