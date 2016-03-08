require 'rails_helper'

RSpec.feature "AuthenticatedUserSecurity", type: :feature do
  scenario "An authenticated user cannot view another users data" do
    user = User.create(first_name: "John", last_name: "Adams", fullname: "John Adams", email: "email@example.com", password: "password")
    user2 = User.create(first_name: "Adams", last_name: "Poop", fullname: "Adams Poop", email: "snail@example.com", password: "password")

    visit "/"

    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    click_on "login"

    visit "/users/#{user2.id}/orders"

    expect(page).to_not have_content("Adams Poop")
  end

  scenario "An unauthenticated user cannot view another users data" do

    visit "/users/1/orders"

    expect(page).to have_content("Hey person, stop trying to hack our shit.")
  end
end
