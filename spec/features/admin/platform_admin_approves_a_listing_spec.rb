require "rails_helper"

RSpec.feature "platform admin approves a property listing" do
  scenario "approves property listing" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    user     = create(:user)
    property = create(:property, status: "pending")

    property.update(user_id: user.id)

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

    within "##{property.id}-property" do
      expect(page).to have_content(property.id)
      expect(page).to have_button("update property")
      select "active", from: "property_status"
    end

    expect(property.status).to eq("pending")

    click_on "update property"
    property.reload

    within(:css, "h1.active.admin-property-index-header") do
      expect(page).to have_content("active properties")
    end

    expect(page).to have_content("Property ID: #{property.id} from Owner #{property.owner} has been updated.")

    expect(property.status).to eq("active")
  end
end
