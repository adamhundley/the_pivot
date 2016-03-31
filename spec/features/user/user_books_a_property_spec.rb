require "rails_helper"

Selenium::WebDriver.for :chrome

RSpec.feature "UserBooksReservation", type: :feature do
  scenario "user makes a reservation", js: true do

    user = create(:user)
    property = create(:property, user_id: user.id)
    amenity = create(:amenity)
    type = create(:property_type)
    image1 = "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1457429804461041.jpg"
    property.update(property_type_id: type.id)
    property.images.create!(image: image1)
    property.amenities << amenity

    visit "/users/new"

    fill_in "name", with: "Nate"
    fill_in "email", with: "nate@email.com"
    fill_in "password", with: "password"

    click_button "signup"

    user = User.find_by(email: "nate@email.com")

    home_path = "Nav logo a5648f7d61d9358b9c6722d9307aeb08ab7e85e355e7817e566a9bc09c1361f3"
    find(:xpath, "//a/img[@alt='#{home_path}']/..").click

    fill_in "location", with: "Denver, CO"
    page.execute_script("$('#checkin').val('20160416')")
    page.execute_script("$('#checkout').val('20160417')")
    select "2 Guests", from: "guests"
    click_on "Search"

    find(:xpath, "//a/img[@alt='1457429804461041']/..").click

    click_on "Book Now!"

    stripe_iframe = all('iframe[name=stripe_checkout_app]').last
    Capybara.within_frame stripe_iframe do
      sleep 2
      page.execute_script(%Q{ $('input#email').val('nate@email.com'); })
      sleep 2
      page.execute_script(%Q{ $('input#shipping-name').val('Nate'); })
      sleep 2
      page.execute_script(%Q{ $('input#shipping-street').val('1510 Blake St'); })
      sleep 2
      page.execute_script(%Q{ $('input#shipping-zip').val('80000'); })
      sleep 2
      page.execute_script(%Q{ $('input#shipping-city').val('Denver'); })
      sleep 10
      click_on "Payment Info"
      page.execute_script(%Q{ $('input#card_number').val('4242 4242 4242 4242'); })
      sleep 1
      page.execute_script(%Q{ $('input#cc-exp').val('11 2020'); })
      sleep 1
      page.execute_script(%Q{ $('input#cc-csc').val('222'); })
      sleep 3
      click_on "Total $2,468.00"
      sleep 10
    end

    expect(current_path).to eq "/nate/dashboard"
    expect(page).to have_content "Thanks for your order! :)"
    expect(user.reservations.count).to eq 1
    expect(user.reservations.first.email).to eq "nate@email.com"
  end
end
