require "rails_helper"

RSpec.feature "UserListsTheirProperty", type: :feature do
  scenario "user lists a property" do
    user = create(:user)
    create(:property_type)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/"

    click_link "List my Pad"

    expect(current_path).to eq("/#{user.slug}/properties/new")

    fill_in "title", with: "Beautiful 2 BR downtown"
    fill_in "description", with: "test description"
    fill_in "price", with: 200
    select "Entire House/Apartment",from: "property-type"
    fill_in "street", with: "123 Test Street"
    fill_in "city", with: "Denver"
    select "Colorado",from: "property_state"
    fill_in "zip", with: "80207"
    select "3",from: "property_bedrooms"
    select "2",from: "property_bathrooms"
    select "5",from: "property_sleeps"

    click_on "List my Pad!"

    expect(current_path).to eq("/#{user.slug}/dashboard")
    expect(page).to have_content("Congrats #{user.fullname}! Your new listing is pending approval.")
  end
end