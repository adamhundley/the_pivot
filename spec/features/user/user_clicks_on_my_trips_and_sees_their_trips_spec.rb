require "rails_helper"

RSpec.feature "UserVieswTheirTrips", type: :feature do
  scenario "user views a trip in their dashboard" do
    user = create(:user)
    type = create(:property_type)
    reservation = create(:reservation)
    amenity = create(:amenity)
    property = create(:property)
    user.reservations << reservation
    type.properties << property
    amenity.properties << property
    property.reservations << reservation

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/#{user.slug}/dashboard"

    click_link "My Trips"

    expect(current_path).to eq("/#{user.slug}/reservations")

    
  end
end
