require "rails_helper"

RSpec.feature "Non logged-in users need to login before listing property" do
  scenario "they need to login before listing feature" do
    user = User.create(fullname: "Alex Navarrete",
                          email: "email@email.com",
                       password: "password"
                      )

    visit root_path

    within("nav") do
      expect(page).to_not have_content("List my Pad")
    end

    visit '/login'

    expect(current_path).to eq login_path

    find("input[placeholder='email']").set user.email
    find("input[placeholder='password']").set user.password

    click_button "login"

    expect(current_path).to eq("/#{user.slug}/dashboard")
    expect(page).to have_content("Hey #{user.fullname}, welcome to C.A.M.P")

    within("nav") do
      expect(page).to have_content("List my Pad")
      click_on "List my Pad"
    end

    expect(current_path).to eq new_property_path
  end

  scenario "regular logins returns them to dashboard" do
    user = User.create(fullname: "Alex Navarrete",
                          email: "email@email.com",
                       password: "password"
                      )

    visit login_path
    expect(current_path).to eq("/login")

    find("input[placeholder='email']").set user.email
    find("input[placeholder='password']").set user.password

    click_button "login"
    expect(current_path).to eq("/#{user.slug}/dashboard")
    expect(page).to have_content("Hey #{user.fullname}, welcome to C.A.M.P")

    click_on "logout"
    expect(current_path).to eq("/")
    expect(page).to have_content("Sad to see you go #{user.fullname}. Come back again soon. 👋")

  end
end
