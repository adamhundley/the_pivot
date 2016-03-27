require "rails_helper"

RSpec.feature "UserSearchesForPropertiesByAvailableDates", type: :feature do
  scenario "user sees only properties available on specified dates", js: true do

    user1 = create(:user)
    require "pry"
    binding.pry

    image = "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1458645252559534.jpg"

    property1 = create(:property, user_id: user.id, title: "BEAUTIFUL HOME")
    property2 = create(:property, user_id: user.id, title: "TURING DUNGEON", street: "1510 Blake Street")
    property3 = create(:property, user_id: user.id, title: "WARM AND COZY", street: "123 WinterPark")
    property4 = create(:property, user_id: user.id, title: "THE GARDENS", street: "100 City park")

    type = create(:property_type)

    property1.property_type = type
    property2.property_type = type
    property3.property_type = type
    property4.property_type = type

    property1.images.create!(image: image)
    property2.images.create!(image: image)
    property3.images.create!(image: image)
    property4.images.create!(image: image)

    reservation1 = property1.reservations.create(user_id: user1.id, checkin: 20160425, checkout: 20160430)

    visit "/"

    fill_in "location", with: "Denver, CO"
    page.execute_script("$('#checkin').val('20160425')")
    page.execute_script("$('#checkout').val('20160430')")
    select "2 Guests", from: "guests"

    click_on "Search"

    expect(current_path).to eq("/properties")
    expect(page).to have_content("DENVER, CO")
    expect(page).to have_content("Filter by price interval")
    expect(page).to have_content("TURING DUNGEON")
    expect(page).to have_content("WARM AND COZY")
    expect(page).to have_content("THE GARDENS")
    expect(page).to_not have_content("BEAUTIFUL HOME")
  end
end
