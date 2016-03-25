require "rails_helper"

RSpec.feature "UserClicksOnMyListing", type: :feature do
  scenario "user has no listings and attempts to view listings" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/#{user.slug}/dashboard"

    click_link "My Listings"

    expect(current_path).to eq("/#{user.slug}/properties")
    expect(page).to have_content("Make money by renting out your extra space on
    CAMP. You’ll also get to meet interesting travelers from around the world!")
    expect(page).to have_link("Post a new Listing")
  end
end
