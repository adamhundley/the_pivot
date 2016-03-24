require "rails_helper"

RSpec.feature "Non logged-in users need to login before listing property" do
  scenario "they need to login before listing feature" do
    user = User.create(fullname: "Alex Navarrete",
                          email: "email@email.com",
                       password: "password"
                      )

    visit root_path

    within("nav") do
      expect(page).to have_content("List my Pad")
    end

    click_link "List my Pad"
    expect(current_path).to eq("/login")

    find("input[placeholder='email']").set user.email
    find("input[placeholder='password']").set user.password

    click_button "login"
    expect(current_path).to eq("/#{user.slug}/dashboard")
    expect(page).to have_content("Hey #{user.first_name}, welcome to C.A.M.P")
  end
end
