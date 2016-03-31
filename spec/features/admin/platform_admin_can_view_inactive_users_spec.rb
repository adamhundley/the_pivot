require "rails_helper"

RSpec.feature "platform admin can view inactive users" do
  scenario "views inactive users" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    user_one   = create(:user)
    user_two   = create(:user)

    user_three = create(:user)
    user_three.update(status: "inactive")

    user_four  = create(:user)
    user_four.update(status: "inactive")

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit admin_dashboard_path

    click_on "inactive users"
    expect(current_path).to eq("/admin/users")

    within(:css, "h1.inactive.admin-users-index-header") do
      expect(page).to have_content("inactive users")
    end

    within(:css, "thead") do
      expect(page).to have_content("user id")
      expect(page).to have_content("name")
      expect(page).to have_content("total properties")
      expect(page).to have_content("status")
    end

    within(:css, "##{user_three.id}-user") do
      expect(page).to have_content(user_three.id)
      expect(page).to have_content(user_three.fullname)
      expect(page).to have_content(user_three.properties.count)
      expect(page).to have_button("update user")
      select "active", from: "user_status"
      click_on "update user"
    end

    user_three.reload

    expect(page).to have_content("User ID: #{user_three.id} has been updated.")
    expect(current_path).to eq(admin_users_path)

    within(:css, "h1") do
      page.has_content?("active users")
    end

    expect(user_one.status).to eq("active")
  end
end
