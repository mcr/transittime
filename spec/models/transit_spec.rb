require File.dirname(__FILE__)+'/../spec_helper'
require 'ruby-debug'

describe Transit, "with fixtures loaded" do
  fixtures :all
  
  it "create a new boarding time for a given transit" do
    tr = transits(:walktokirkwood)

    boarding = tr.board_at("8088", Time.now)

    assert_not_nil boarding.boarding_time
    assert_not_nil boarding.vehicle_code
  end
end
