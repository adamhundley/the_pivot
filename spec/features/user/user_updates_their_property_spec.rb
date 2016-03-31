  require "rails_helper"

RSpec.feature "UserEditsTheirProperty", type: :feature do
  scenario "user views an approved propertyand updates it" do
    user = create(:user)
    type = create(:property_type)
    amenity = create(:amenity)
    property = create(:property, user_id: user.id)
    type.properties << property
    amenity.properties << property

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/#{user.slug}/dashboard"

    click_link "My Listings"

    expect(current_path).to eq("/#{user.slug}/properties")

    page.driver.put "/#{user.slug}/properties/#{property.id}",
      {property: {title: "New title", description: "New description", price: 123, street: "123 New St.", city: "New City", state: "WV", zip: 26003, amenity_ids: []}}

     expect(Property.first.title).to eq "New title"
     expect(Property.first.description).to eq "New description"
     expect(Property.first.price).to eq 123
     expect(Property.first.street).to eq "123 New St."
     expect(Property.first.city).to eq "New City"
     expect(Property.first.state).to eq "WV"
     expect(Property.first.zip).to eq "26003"
     expect(Property.first.amenity_ids).to eq []
  end
end
