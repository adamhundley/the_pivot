require "rails_helper"

driver = Selenium::WebDriver.for :chrome

RSpec.feature "UserSearchesProperties", type: :feature do
  scenario "user views all properties filtered by homepage search bar", js: true do
    property1 = create(:property, title: "Beautiful home")
    property2 = create(:property, title: "Turing dungeon", street: "1510 Blake Street")

    visit "/"

    fill_in "location", with: "Denver, CO"
    page.execute_script("$('#checkin').val('04/16/2016')")
    page.execute_script("$('#checkout').val('04/17/2016')")
    select "2 Guests", from: "guests"

    click_on "Search"

    expect(current_path).to eq("/properties")
    expect(page).to have_content("DENVER, CO")
    expect(page).to have_content("Filter by price interval")
    expect(page).to have_content("Beautiful home")
    expect(page).to have_content("Turing dungeon")
  end
end

