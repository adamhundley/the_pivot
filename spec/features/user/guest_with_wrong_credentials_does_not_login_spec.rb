require 'rails_helper'

RSpec.feature "Guest logs in with wrong credentials", type: :feature do
  scenario "wrong credentials" do

    visit "/login"

    fill_in "email", with: "test@email.com"
    fill_in "password", with: "this is wrong hahaha"

    within(:css, 'form') do
      click_on "login"
    end

    expect(page).to have_content "Sorry, friend. Something went wrong :(... Please try again."
  end
end
