require "rails_helper"

RSpec.feature "Platform Admin uses searchbar", type: :feature do
  scenario "searches property owner's name" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    user_one = create(:user)
    user_two = create(:user, email: "g@gmail.com")

    property_one = create(:property, user_id: user_one.id)
    property_two = create(:property, user_id: user_two.id)

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit admin_dashboard_path

    click_on "pending properties"

   fill_in "search", with: "#{user_one.fullname}"
   click_on "search by name"
  #  save_and_open_page
  end

  scenario "searches non-existing property owner's name" do
  end
end
