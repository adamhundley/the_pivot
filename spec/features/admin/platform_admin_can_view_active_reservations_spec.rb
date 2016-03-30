require "rails_helper"

RSpec.feature "Platform Admin can view active reservations", type: :feature do
  scenario "platform admin views an active reservation" do
    platform_admin = User.create(first_name: "john",
                                last_name: "adams",
                                fullname: "john adams",
                                email: "admin@example.com",
                                password: "password",
                                role: 1)

    property_owner = create(:user)
    property       = create(:property)
    type           = create(:property_type)
    amenity        = create(:amenity)

    customer = create(:user)

    reservation = create(:reservation)
    reservation.update(user_id: customer.id)
    reservation.update(property_id: property.id)

    property.update(user_id: property_owner.id)
    property.update(status: "active")
    property.update(property_type_id: type.id)
    image1 = "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1457429804461041.jpg"
    property.images.create!(image: image1)
    property.amenities << amenity

  end
end
# As a platform admin,
# When I visit '/admin/dashboard'
# And I click on "current reservations",
# I expect to see an index view of all active reservations within the website,
# I expect to see columns titled:
# date, reservation id, property owner's name, customer's name, and total price
# And when I click on a reservation id,
# I expect to be redirected to a Reservation show page that displays an invoice of that reservation
