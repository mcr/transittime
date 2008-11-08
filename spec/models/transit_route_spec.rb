require File.dirname(__FILE__)+'/../spec_helper'

describe TransitRoute, "with fixtures loaded" do
  fixtures :transit_routes

  before(:each) do
    # fixtures?
  end

  it "should have a route 151 leaving from stop 4899" do
    TransitRoute.find_by_route("151W").should_not be_nil
  end
end
