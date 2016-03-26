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

    find_field('Title').value.should eq "New title" 
    find_field('Description').value.should eq "New description"
    find_field('rental price per day').value.should eq "123"
    find_field('Street').value.should eq "123 New St."
    find_field('City').value.should eq "New City"
    find_field('property[state]').value.should eq "WV"
    find_field('Zip').value.should eq "26003"
    find_field('property[bedrooms]').value.should eq "8"
    find_field('property[bathrooms]').value.should eq "8"
    find_field('property[sleeps]').value.should eq "8"

    expect(Property.first.title).to eq("New title")
    expect(Property.first.description).to eq("New Description")
    expect(Property.first.price).to eq(123)
    expect(Property.first.street).to eq("123 New St.")
    expect(Property.first.city).to eq("New City")
    expect(Property.first.state).to eq("West Virigina")
    expect(Property.first.bedrooms).to eq(8)
    expect(Property.first.bathrooms).to eq(8)
    expect(Property.first.sleeps).to eq(8)
    expect(Property.first.amenities).to eq([])
  end
end
