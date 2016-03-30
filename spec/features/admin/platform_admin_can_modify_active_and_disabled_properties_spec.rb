require "rails_helper"

RSpec.feature "platform admin can modify active and inactive properties" do
  scenario "platform admin modifies property from active to inactive" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    user     = create(:user)
    property = create(:property)

    property.update(user_id: user.id)
    property.update(status: "active")

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit admin_dashboard_path

    click_on "active properties"

    within(:css, "h1.active.admin-property-index-header") do
      expect(page).to have_content("active properties")
    end

    expect(page).to have_content("date")
    expect(page).to have_content("property id")
    expect(page).to have_content("name")
    expect(page).to have_content("price")
    expect(page).to have_content("description")
    expect(page).to have_content("status")

    within "##{property.id}-property" do
      expect(page).to have_content(property.id)
      expect(page).to have_button("update property")
      select "inactive", from: "property_status"
    end

    click_on "update property"

    property.reload
    expect(property.status).to eq("inactive")

    within(:css, "h1.inactive.admin-property-index-header") do
      expect(page).to have_content("inactive properties")
    end
  end

  scenario "platform admin modifies property from inactive to active" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    user     = create(:user)
    property = create(:property)

    property.update(user_id: user.id)
    property.update(status: "inactive")

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit admin_dashboard_path

    click_on "inactive properties"

    within(:css, "h1.inactive.admin-property-index-header") do
      expect(page).to have_content("inactive properties")
    end

    expect(page).to have_content("date")
    expect(page).to have_content("property id")
    expect(page).to have_content("name")
    expect(page).to have_content("price")
    expect(page).to have_content("description")
    expect(page).to have_content("status")

    within "##{property.id}-property" do
      expect(page).to have_content(property.id)
      expect(page).to have_button("update property")
      select "active", from: "property_status"
    end

    click_on "update property"

    property.reload
    expect(property.status).to eq("active")

    within(:css, "h1.active.admin-property-index-header") do
      expect(page).to have_content("active properties")
    end
  end
end
