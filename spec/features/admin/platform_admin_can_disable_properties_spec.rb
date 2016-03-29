require "rails_helper"

RSpec.feature "platform admin disables a property listing" do
  scenario "disable property listing" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    user = create(:user)

    property     = create(:property)
    property_two = create(:property)

    property.update(user_id: user.id)
    property.update(title: "THIS PROPERTY WILL BE DELETED!")
    property_two.update(user_id: user.id)

    assert user.properties.count == 2

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit admin_dashboard_path

    click_on "pending properties"

    page.has_content?('PENDING PROPERTIES')
    page.has_content?("THIS PROPERTY WILL BE DISABLED!")

    within(:css, "thead") do
      expect(page).to have_content("date")
      expect(page).to have_content("property id")
      expect(page).to have_content("name")
      expect(page).to have_content("price")
      expect(page).to have_content("description")
      expect(page).to have_content("status")
    end

    within(:css, "#2-property") do
      expect(page).to have_content(property_two.date)
      expect(page).to have_content(property_two.id)
      expect(page).to have_content(property_two.owner)
      expect(page).to have_content(property_two.display_total)
      expect(page).to have_content(property_two.description)
      expect(page).to have_content("pending")
      expect(page).to have_button("update property")
    end

    within(:css, "#1-property") do
      expect(page).to have_content(property.date)
      expect(page).to have_content(property.id)
      expect(page).to have_content(property.owner)
      expect(page).to have_content(property.display_total)
      expect(page).to have_content(property.description)
      expect(page).to have_content("pending")
      expect(page).to have_button("update property")
      select "disable", from: "property_status"
      click_on "update property"
    end

    expect(page).to have_content("Property ID: #{property.id} from Owner #{property.owner} has been updated.")

    expect(current_path).to eq(admin_properties_path)
    page.has_no_content?("THIS PROPERTY WILL BE DISABLED!")

    click_on "disabled properties"
    save_and_open_page

    within(:css, "h1") do 
      page.has_content?("DISABLED PROPERTIES")
    end

    page.has_content?("THIS PROPERTY WILL BE DISABLED!")
  end
end
