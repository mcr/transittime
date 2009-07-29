require File.dirname(__FILE__)+'/../spec_helper'

describe Booking, "with fixtures loaded" do
  fixtures :all

  before(:each) do
    # something
  end

  it "should have one booking for summer 2009" do
    Booking.find_by_date(Time.gm(2009,7,23)).should_not be_nil
  end
end
