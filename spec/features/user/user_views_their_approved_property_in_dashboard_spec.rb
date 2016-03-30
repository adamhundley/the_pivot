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
    expect(find_field('property[title]').value).to  eq property.title
    expect(find_field('property[description]').value).to  eq property.description
    expect(find_field('property[price]').value).to  eq property.price.to_s
    expect(find_field('property[street]').value).to  eq property.street
    expect(find_field('property[city]').value).to  eq property.city
    expect(find_field('property[state]').value).to  eq property.state
    expect(find_field('property[state]').value).to  eq property.state
    expect(find_field('property[zip]').value).to  eq property.zip
    expect(find_field('property[bedrooms]').value).to  eq property.bedrooms.to_s
    expect(find_field('property[bathrooms]').value).to  eq property.bathrooms.to_s
    expect(find_field('property[sleeps]').value).to  eq property.sleeps.to_s

    #expect(current_path).to eq("/#{user.slug}/dashboard")
    #expect(page).to have_content("Congrats #{user.fullname}! Your new listing is pending approval.")

  end
end
