require "rails_helper"

RSpec.feature "UserBooksAPropertyWithoutBeingLoggedIn", type: :feature do
  scenario "user views a property and books but must login first" do
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

    click_on  "Login & Book Now!"

    expect(current_path).to eq(login_path)

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    within "div#login-form" do
      click_on "login"
    end

    expect(current_path).to eq("/#{user.slug}/properties/#{property.id}")
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
