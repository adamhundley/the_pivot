require 'rails_helper'

RSpec.feature "UserJoinsMailingList", type: :feature do
  scenario "A user signs up for the mailing list and their email is stored" do

    visit "/"

    fill_in "email", with: "test@email.com"

    click_on "sign up"

    expect(page).to have_content "Hey, thx for joining :)"
  end

  scenario "A user doesn't fill out the the form and an error is raised" do

    visit "/"

    click_on "sign up"

    expect(page).to have_content "Sorry, friend. Something went wrong :(... Please try again."
  end
end
