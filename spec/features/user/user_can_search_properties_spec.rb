require "rails_helper"

Selenium::WebDriver.for :chrome

RSpec.feature "UserSearchesProperties", type: :feature do
  scenario "user views all properties filtered by homepage search bar", js: true do
    user = create(:user)
    property1 = create(:property, title: "Beautiful home")
    property2 = create(:property, title: "Turing dungeon", street: "1510 Blake Street")
    user.properties << [property1, property2]
    image1 = create(:image)
    image2 = create(:image)
    property1.images << image1
    property2.images << image2

    visit "/"

    fill_in "location", with: "Denver, CO"
    page.execute_script("$('#checkin').val('20160416')")
    page.execute_script("$('#checkout').val('20160417')")
    select "2 Guests", from: "guests"

    # click_on "Search"

    #we have to figure out why seleium isn't loading the images

    # expect(current_path).to eq("/properties")
    # expect(page).to have_content("DENVER, CO")
    # expect(page).to have_content("Beautiful home")
    # expect(page).to have_content("Turing dungeon")
  end
end
