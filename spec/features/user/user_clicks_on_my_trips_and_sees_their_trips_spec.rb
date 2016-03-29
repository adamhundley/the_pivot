require "rails_helper"

RSpec.feature "UserVieswTheirTrips", type: :feature do
  scenario "user views a trip in their dashboard" do
    user = create(:user)
    type = create(:property_type)
    image = create(:image)
    reservation = create(:reservation)
    amenity = create(:amenity)
    property = create(:property)
    user.reservations << reservation
    user.properties << property
    type.properties << property
    amenity.properties << property
    property.images << image
    property.reservations << reservation

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/#{user.slug}/dashboard"

    click_link "My Trips"

    expect(current_path).to eq("/#{user.slug}/reservations")

    expect(page).to have_content(property.title)
    expect(page).to have_content(property.street)
    expect(page).to have_content(property.city)
    expect(page).to have_content(property.state)
    expect(page).to have_content(property.zip)
    expect(page).to have_content(reservation.order_total)
    expect(page).to have_content(reservation.checkin)
    expect(page).to have_content(reservation.checkout)
    expect(page).to have_content(property.zip)
  end
end
