require 'rails_helper'

RSpec.describe ReservationNight, type: :model do
  it { should belong_to :reservation }

  it "should create reservation for each night" do
    property = create(:property)
    user = create(:user)
    reservation = Reservation.create!(user_id: user.id,
                                      property_id: property.id,
                                      checkin: 20160325,
                                      checkout: 20160328)

    ReservationNight.book_nights(reservation)
    booking = reservation.reservation_nights

    expect(4).to eq booking.count
    expect("2016-03-25").to eq booking.first.night.to_s
    expect("2016-03-26").to eq booking.second.night.to_s
    expect("2016-03-27").to eq booking.third.night.to_s
    expect("2016-03-28").to eq booking.last.night.to_s
  end
end

