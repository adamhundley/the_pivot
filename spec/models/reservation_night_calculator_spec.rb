require 'rails_helper'

RSpec.describe ReservationNightCalculator, type: :model do
  it "It initializes with formatted dates" do
    checkin = 20160304
    checkout = 20160308
    reservation = ReservationNightCalculator.new(checkin, checkout)
    result1 = reservation.checkin.to_s
    result2 = reservation.checkout.to_s

    expect("2016-03-04").to eq result1
    expect("2016-03-08").to eq result2
  end

  it "creates range of days for reservation" do
    checkin = 20160304
    checkout = 20160308
    reservation = ReservationNightCalculator.new(checkin, checkout)
    nights = reservation.add_up_nights

    expect(5).to eq nights.count
    expect(Date).to eq nights.first.class
  end
end
