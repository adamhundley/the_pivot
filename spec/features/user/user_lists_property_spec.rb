require "rails_helper"

RSpec.feature "UserListsTheirProperty", type: :feature do
  scenario "user lists a property" do
    user = create(:user)
    create(:property_type)
    create(:amenity)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    click_link "List my Pad"

    expect(current_path).to eq("/properties/new")

    fill_in "property title", with: "Beautiful 2 BR downtown"
    fill_in "property description", with: "test description"
    fill_in "rental price per day", with: 200
    select "Entire House/Apartment",from: "property-type"
    fill_in "street", with: "123 Test Street"
    fill_in "city", with: "Denver"
    select "Colorado",from: "property_state"
    fill_in "zip", with: "80207"
    select "3",from: "bedroom-dropdown"
    select "2",from: "property_bathrooms"
    select "5",from: "property_sleeps"
    page.check('wifi')

    within "div#create-property" do
      click_on "List my Pad!"
    end

    expect(current_path).to eq("/#{user.slug}/dashboard")
    expect(page).to have_content("Congrats #{user.fullname}! Your new listing is pending approval.")
  end
end
