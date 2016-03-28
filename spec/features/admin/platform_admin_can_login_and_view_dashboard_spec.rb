require "rails_helper"

RSpec.feature "platform admin can view their dashboard" do
  scenario "views dashboard" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit admin_dashboard_path
    expect(current_path).to eq('/admin/dashboard')
  end
end
