require "rails_helper"

RSpec.feature "platform admin approves a property listing" do
  scenario "approves property listing" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    type     = create(:property_type)
    amenity  = create(:amenity)
    property = create(:property)


    platform_admin.properties << property
              type.properties << property
           amenity.properties << property

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit admin_dashboard_path
    expect(current_path).to eq('/admin/dashboard')

    click_on "pending properties"

    within(:css, "h1.pending.admin-property-index-header") do
      expect(page).to have_content("pending properties")
    end

    expect(page).to have_content("date")
    expect(page).to have_content("property id")
    expect(page).to have_content("name")
    expect(page).to have_content("price")
    expect(page).to have_content("description")
    expect(page).to have_content("status")

    expect(page).to have_content("john adams")
    refute property.status?

    within "#1-property" do
      expect(page).to have_content(property.id)
      expect(page).to have_button("update property")
      select "true", from: "property_status"
    end

    click_on "update property"
    expect(page).to have_content("Cheerio! Property 1 has been updated!")
  end
end
