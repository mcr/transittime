require File.dirname(__FILE__)+'/../spec_helper'
require 'ruby-debug'

describe Trip, "with fixtures loaded" do
  fixtures :all
  
  it "should create a new trip with a given starting place" do
    home = places(:home)

    t = Trip.starting_from(home)
    assert_not_nil t.starting_place
    assert_not_nil t.trip_start
  end

end
