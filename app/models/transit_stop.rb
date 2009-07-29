class TransitStop < ActiveRecord::Base

  belongs_to :place
  has_many   :schedules, :foreign_key => :stop_id
end
