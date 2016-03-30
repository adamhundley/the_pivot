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
    reservation.update(user_id: property_owner.id)
    reservation.update(property_id: property.id)
    reservation.update(fullname: customer.fullname)

    property.update(user_id: property_owner.id)
    property.update(status: "active")
    property.update(property_type_id: type.id)
    image1 = "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1457429804461041.jpg"
    property.images.create!(image: image1)
    property.amenities << amenity

    allow_any_instance_of(ApplicationController).to(
    receive(:current_user).and_return(platform_admin))

    visit admin_dashboard_path
    expect(current_path).to eq('/admin/dashboard')

    click_on "current reservations"
    expect(current_path).to eq('/admin/reservations')

    within(:css, "h1.current.admin-reservations-index-header") do
      expect(page).to have_content("current reservations")
    end

    expect(page).to have_content("reservation date")
    expect(page).to have_content("reservation id")
    expect(page).to have_content("property owner")
    expect(page).to have_content("customer name")
    expect(page).to have_content("total price")

    within(:css, "tr##{reservation.id}-reservation") do
      expect(page).to have_content("Check-in")
      expect(page).to have_content("Checkout")
      expect(page).to have_content(property_owner.fullname)
      expect(page).to have_content(customer.fullname)
      expect(page).to have_content(reservation.formatted_total)
    end

    click_on reservation.id

    expect(current_path).to eq("/admin/reservations/#{reservation.id}")

    expect(page).to have_content("RESERVATION INFO")

    within(:css, "div.reservation-info") do
      expect(page).to have_content("Reservation ID: #{reservation.id}")
      expect(page).to have_content("Property ID: #{property.id}")
      expect(page).to have_content("Property Owner: #{property_owner.fullname}")
      expect(page).to have_content("Customer Name: #{customer.fullname}")
      expect(page).to have_content("Check-in")
      expect(page).to have_content("Checkout")
      expect(page).to have_content("Total Price #{reservation.formatted_total}")
      click_link  reservation.property_id
    end

    expect(current_path).to eq("/admin/properties/#{reservation.property_id}")
  end
end
