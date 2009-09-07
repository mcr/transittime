require File.dirname(__FILE__)+'/../spec_helper'

describe PlaceDialogue, "with fixtures loaded" do
  fixtures :all
  
  it "route to parliament pub starts with 3 choices" do
    pd = PlaceDialogue.new
    pd.current_place = places(:home)
    pd.destination_place = places(:parliamentpub)

    assert pd.next_ride_button.size == 3
  end

  it "should record a new boarding time when button is pushed" do
    pd = PlaceDialogue.new
    pd.current_place = places(:home)
    pd.destination_place = places(:parliamentpub)

    assert pd.trip, "Trip should be non-nil"
    tripcount = pd.trip.boarding_times.count

    pd.select_direction(transits(:walktokirkwood))

    tripcount2 = pd.trip.boarding_times.count
    assert tripcount2-tripcount == 1, "Should have added one boarding time"

    assert pd.onboard  == transits(:walktokirkwood)
    assert pd.onwayto == places(:number16downtown)
  end
end
