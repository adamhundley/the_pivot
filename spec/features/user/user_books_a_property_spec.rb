require "rails_helper"

RSpec.feature "UserBooksReservation", type: :feature do
  scenario "user makes a reservation" do


    property_owner = create(:user)
    user = create(:user, email: "example@example.com")
    property = create(:property, user_id: property_owner.id)
    amenity = create(:amenity)
    type = create(:property_type)
    image1 = "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1457429804461041.jpg"
    image2 = "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1458645252559534.jpg"
    image3 = "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1458477215180193.jpg"
    image4 = "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1458645252559534.jpg"
    property.update(property_type_id: type.id)
    property.images.create!(image: image1)
    property.images.create!(image: image2)
    property.images.create!(image: image3)
    property.images.create!(image: image4)
    property.amenities << amenity

    visit "/#{user.slug}/properties/#{property.id}"
save_and_open_page
    click_on "Book Now!"

 Capybara.within '#stripe-checkout' do
      fill_in 'Email', with: 'example@example.com'
      fill_in 'Name',  with: 'Nick Cox'
      fill_in 'Street', with: '123 Anywhere St.'
      fill_in 'ZIP', with: '98117'
      fill_in 'City', with: 'Seattle'
      click_button 'Payment Info'
      fill_in 'Card number', with: '4242424242424242'
      fill_in 'MM/YY', with: '02/22'
      fill_in 'CVC', with: '222'
      click_button 'Pay'
    end
  end
end
