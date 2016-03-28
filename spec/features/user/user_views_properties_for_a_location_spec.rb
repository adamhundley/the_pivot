require "rails_helper"

RSpec.feature "UserViewsPropertyIndex", type: :feature do
  scenario "user views property index" do
    user = create(:user)
    type = create(:property_type)
    image = create(:image)
    property = create(:property)
    property.property_type = type
    property.images << image
    user.properties << property
    amenity = create(:amenity)
    property.amenities << amenity

    visit "/properties"

    expect(page).to have_content(property.title)
    expect(page).to have_content(property.price)
    expect(page).to have_content(property.bedrooms)
    expect(page).to have_content(property.bathrooms)
    expect(page).to have_content(property.sleeps)
  end
end
