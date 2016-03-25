require "rails_helper"

RSpec.feature "UserVieswTheirProperty", type: :feature do
  scenario "user views a property after it has been approved in their dashboard" do
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
    find_field('Title').value.should eq property.title
    find_field('Description').value.should eq property.description
    find_field('rental price per day').value.should eq property.price.to_s
    find_field('Street').value.should eq property.street
    find_field('City').value.should eq property.city
    find_field('property[state]').value.should eq property.state
    find_field('Zip').value.should eq property.zip
    find_field('property[bedrooms]').value.should eq property.bedrooms.to_s
    find_field('property[bathrooms]').value.should eq property.bathrooms.to_s
    find_field('property[sleeps]').value.should eq property.sleeps.to_s

    # click_on "Update my Pad!"
    #
    # expect(current_path).to eq("/#{user.slug}/dashboard")
    # expect(page).to have_content("Congrats #{user.fullname}! Your new listing is pending approval.")

  end
end
