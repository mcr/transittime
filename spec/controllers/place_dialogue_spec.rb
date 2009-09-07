require File.dirname(__FILE__)+'/../spec_helper'

describe PlaceDialogue, "with fixtures loaded" do
  fixtures :all
  
  it "route to parliament pub starts with 3 choices" do
    pd = PlaceDialogue.new
    pd.current_place = places(:home)
    pd.destination_place = places(:parliamentpub)

    assert pd.next_ride_button.size == 3
  end

  it "should record a new place when button is pushed" do
    pd = PlaceDialogue.new
    pd.current_place = places(:home)
    pd.destination_place = places(:parliamentpub)

    pd.select_direction(transits(:walktokirkwood))
    
    assert pd.trip, "Trip should be non-nil"
  end

end
