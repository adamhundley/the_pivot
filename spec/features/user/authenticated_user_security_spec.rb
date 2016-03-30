require 'rails_helper'

RSpec.feature "AuthenticatedUserSecurity", type: :feature do
  scenario "An authenticated user cannot view another users data" do
    user1 = User.create(first_name: "John", last_name: "Adams", fullname: "John Adams", email: "email@example.com", password: "password")
    user2 = User.create(first_name: "Adams", last_name: "Poop", fullname: "Adams Poop", email: "snail@example.com", password: "password")

    visit "/"

    click_on "login"

    fill_in "email", with: user1.email
    fill_in "password", with: user1.password

    within "div#login-form" do
      click_on "login"
    end


    expect(page).to have_content(user1.fullname.downcase)
    expect(page).to_not have_content(user2.fullname.downcase)
  end
end
