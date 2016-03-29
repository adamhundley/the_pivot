require "rails_helper"

RSpec.feature "UserViewsAProperty", type: :feature do
  scenario "user views a property and see's all information" do
    user = create(:user)
    type = create(:property_type)
    image = create(:image)
    property = create(:property)
    type.properties << property
    user.properties << property
    amenity = create(:amenity)
    property.amenities << amenity
    property.images << image

    visit "/#{user.slug}/properties/#{property.id}"

    expect(page).to have_content(property.title)
    expect(page).to have_content(property.description)
    expect(page).to have_content("$#{property.price}")
    expect(page).to have_content(property.street)
    expect(page).to have_content(property.city)
    expect(page).to have_content(property.state)
    expect(page).to have_content(property.zip)
    expect(page).to have_content(property.property_type.name)
    expect(page).to have_content(property.bedrooms)
    expect(page).to have_content(property.bathrooms)
    expect(page).to have_content(property.sleeps)
  end
end
