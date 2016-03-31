require "rails_helper"

RSpec.feature "platform admin can view individual properties" do
  scenario "views individual pending property" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    user     = create(:user)
    property = create(:property, status: "pending")
    type     = create(:property_type)
    image    = create(:image)
    amenity  = create(:amenity)

    type.properties << property
    user.properties << property
    property.amenities << amenity
    property.images << image

    property.update(user_id: user.id)
    property.update(property_type_id: type.id)

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit admin_dashboard_path

    click_on "pending properties"

    within(:css, "h1.pending.admin-property-index-header") do
      expect(page).to have_content("pending properties")
    end

    within "##{property.id}-property" do
      expect(page).to have_content(property.id)
      click_on property.id
    end

    expect(page).to have_content("ADMIN DISPLAY MODE")
    expect(current_path).to eq(admin_property_path(property.id))
  end

  scenario "views individual active property" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    user     = create(:user)
    property = create(:property)
    type     = create(:property_type)
    image    = create(:image)
    amenity  = create(:amenity)

    type.properties << property
    user.properties << property
    property.amenities << amenity
    property.images << image

    property.update(user_id: user.id)
    property.update(property_type_id: type.id)
    property.update(status: "active")

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit admin_dashboard_path

    click_on "active properties"

    within(:css, "h1.active.admin-property-index-header") do
      expect(page).to have_content("active properties")
    end

    within "##{property.id}-property" do
      expect(page).to have_content(property.id)
      click_on property.id
    end

    expect(page).to have_content("ADMIN DISPLAY MODE")
    expect(current_path).to eq(admin_property_path(property.id))
  end

  scenario "views individual inactive property" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    user     = create(:user)
    property = create(:property)
    type     = create(:property_type)
    image    = create(:image)
    amenity  = create(:amenity)

    type.properties << property
    user.properties << property
    property.amenities << amenity
    property.images << image

    property.update(user_id: user.id)
    property.update(property_type_id: type.id)
    property.update(status: "inactive")

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit admin_dashboard_path

    click_on "inactive properties"

    within(:css, "h1.inactive.admin-property-index-header") do
      expect(page).to have_content("inactive properties")
    end

    within "##{property.id}-property" do
      expect(page).to have_content(property.id)
      click_on property.id
    end

    expect(page).to have_content("ADMIN DISPLAY MODE")
    expect(current_path).to eq(admin_property_path(property.id))
  end
end
