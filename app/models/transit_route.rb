class TransitRoute < ActiveRecord::Base
  def self.find_by_route(name)
    find_by_direction1_name(name) || find_by_direction2_name(name)
  end
end
