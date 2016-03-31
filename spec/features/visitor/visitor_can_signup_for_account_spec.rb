require "rails_helper"

RSpec.feature "Visitor can sign up for a account" do
  scenario "they visit signup page and create a account and sees user dashboard" do
    visit new_user_path

    find("input[placeholder='name']").set "nate"
    find("input[placeholder='email']").set "nate@example.com"
    find("input[placeholder='password']").set "password"

    click_button "signup"

    expect(current_path).to eq("/")
    expect(page).to have_content "Hey nate, welcome to C.A.M.P."
  end
end
