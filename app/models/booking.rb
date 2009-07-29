class Booking < ActiveRecord::Base

  named_scope :after,  lambda { |t| { :conditions => [ "starting_day < ?", t ] } }
  named_scope :before, lambda { |t| { :conditions => [ "ending_day   > ?", t ] } }

  def self.find_by_date(n = Time.now.utc)
    self.after(n).before(n).find(:first)
  end
end
