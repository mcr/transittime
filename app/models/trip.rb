class Trip < ActiveRecord::Base
  belongs_to :starting_place, :class_name => "Place", :foreign_key => :starting_place_id
  belongs_to :ending_place,   :class_name => "Place", :foreign_key => :ending_place_id

  has_many :boarding_times

  def self.starting_from(x)
    self.new(:starting_place => x,
	     :trip_start     => Time.now)
  end

end
