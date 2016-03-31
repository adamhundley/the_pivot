require "rails_helper"

RSpec.feature "UserEditsTheirProperty", type: :feature do
  scenario "user views an approved propertyand updates it" do
    user = create(:user)
    type = create(:property_type)
    amenity = create(:amenity)
    property = create(:property)
    user.properties << property
    type.properties << property
    amenity.properties << property

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/#{user.slug}/dashboard"

    click_link "My Listings"

    expect(current_path).to eq("/#{user.slug}/properties")

    within "div#edit-property-#{property.id}" do
      fill_in "property_title", with: "New title"
      fill_in "Description", with: "New description"
      fill_in "rental price per day", with: 123
      fill_in "Street", with: "123 New St."
      fill_in "City", with: "New City"
      select "West Virginia",from: "property_state"
      fill_in "zip", with: "26003"
      select "8",from: "bedroom-dropdown"
      select "8",from: "property_bathrooms"
      select "8",from: "property_sleeps"
      page.uncheck('property[amenity_ids][]')
    end

    within "div#update-property" do
      click_on "Update my Pad!"
    end

    expect(current_path).to eq("/#{user.slug}/properties")

    expect(find_field('property[title]').value).to  eq "New title"
    expect(find_field('property[description]').value).to  eq "New description"
    expect(find_field('property[price]').value).to  eq "123"
    expect(find_field('property[street]').value).to  eq "123 New St."
    expect(find_field('property[city]').value).to  eq "New City"
    expect(find_field('property[state]').value).to  eq "WV"
    expect(find_field('property[zip]').value).to  eq "26003"
    expect(find_field('property[bedrooms]').value).to eq  "8"
    expect(find_field('property[bathrooms]').value).to  eq "8"
    expect(find_field('property[sleeps]').value).to  eq "8"
  end
end
