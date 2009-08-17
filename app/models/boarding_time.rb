class BoardingTime < ActiveRecord::Base

  belongs_to :transit_route
  belongs_to :transit_stop
  belongs_to :transit_stage, :class_name => 'Transit', :foreign_key => :transit_stage_id
end
