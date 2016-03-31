require "rails_helper"

RSpec.feature "UserClicksOnFeaturedCity", type: :feature do
  scenario "user clicks on city and sees properties from that city and not another" do
    user = create(:user)
    type = create(:property_type)
    image = create(:image)
    property = create(:property, title: "NY House", zip: 10001)
    property2 = create(:property, title: "LA Houser", zip: 90210)
    property.property_type = type
    property.images << image
    user.properties << property
    amenity = create(:amenity)
    property.amenities << amenity

    visit "/"

    click_on "New York"

    expect(page).to have_content(property.title)
    expect(page).to_not have_content(property2.title)
  end
end
