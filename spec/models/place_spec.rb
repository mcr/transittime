require File.dirname(__FILE__)+'/../spec_helper'
require 'ruby-debug'

describe Place, "with fixtures loaded" do
  fixtures :all
  
  # get list of transits 
  it "should find routes from Michael's house" do
    home = places(:home)
    
    assert home.starting_transits.count == 3, "there should be three ways to leave Michael's House"
  end

  it "should suggest walking to bus 16" do
    home  = places(:home)
    walkto16 = transits(:walktokirkwood)

    assert home.starting_transits.include?(walkto16), "walk to #16 bus should be suggested"
  end

  it "should find a transit to destination" do
    home = places(:home)
    dest = places(:parliamentpub)

    routes = home.starting_routes
    assert routes.find_by_ending_place_id(dest.id), "should find a route to parliament pub"
  end

end
