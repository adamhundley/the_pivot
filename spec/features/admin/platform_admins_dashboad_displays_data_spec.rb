require "rails_helper"

RSpec.feature "platform admin's dashboard displays data" do
  scenario "views total revenue" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    allow(Reservation).to receive(:daily_average_revenue).and_return("$5000")
    allow(Reservation).to receive(:weekly_average_revenue).and_return("$3500")
    allow(Reservation).to receive(:total_revenue).and_return("15578")

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit "/admin/dashboard"

    within(:css, ".col-xs-12.text-center.dashboard-rev-header#total-display-date") do
      expect(page).to have_content("$15,578 total revenue")
    end
  end

  scenario "views daily average and weekly average revenue" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    allow(Reservation).to receive(:daily_average_revenue).and_return("5000")
    allow(Reservation).to receive(:weekly_average_revenue).and_return("3500")
    allow(Reservation).to receive(:total_revenue).and_return("15578")
    allow(Reservation).to receive(:count).and_return("150")
    allow(User).to receive(:count).and_return("60")


    visit "/admin/dashboard"

    within(:css, ".col-xs-12.text-center.dashboard-rev-header#checkin-per-month") do
      expect(page).to have_content("check-in's per month")
    end

    within(:css, "div.row.rev-data-row.text-center#platform-diagnostics") do
      expect(page).to have_content("daily avg")
      expect(page).to have_content("weekly avg")
      expect(page).to have_content("orders")
      expect(page).to have_content("users")
    end

    within(:css, "div#platform-diagnostics") do
      expect(page).to have_content("$5,000")
      expect(page).to have_content("$3,500")
      expect(page).to have_content("150")
      expect(page).to have_content("60")
    end
  end
end
