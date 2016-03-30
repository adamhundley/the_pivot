require "rails_helper"

Selenium::WebDriver.for :chrome

RSpec.feature "UserSearchesProperties", type: :feature do
  scenario "user views all properties filtered by homepage search bar", js: true do
    user = create(:user)
    property1 = create(:property, title: "Beautiful home")
    property2 = create(:property, title: "Turing dungeon", street: "1510 Blake Street")
    user.properties << [property1, property2]
    image1 = "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1457429804461041.jpg"
    image2 = "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1458645252559534.jpg"
    property1.images.create!(image: image1)
    property2.images.create(image: image2)

    visit "/"

    fill_in "location", with: "Denver, CO"
    page.execute_script("$('#checkin').val('20160416')")
    page.execute_script("$('#checkout').val('20160417')")
    select "2 Guests", from: "guests"

     click_on "Search"

     expect(page).to have_content("BEAUTIFUL HOME")
     expect(page).to have_content("TURING DUNGEON")
  end
end
