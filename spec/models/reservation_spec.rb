require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { should belong_to :user }
  it { should belong_to :property }
  it { should have_many :reservation_nights }

  it 'checks if nights are reserved' do
    reservation_checkin = "20160310".to_date
    reservation_checkout = "20160312".to_date
    checkin = "20160320".to_date
    checkout = "20160322".to_date
    reservation = create(:reservation, checkin: reservation_checkin, checkout: reservation_checkout)
    ReservationNight.book_nights(reservation)

    expect(Reservation.reserved?(reservation_checkin, reservation_checkout)).to eq true
    expect(Reservation.reserved?(checkin, checkout)).to eq false
  end

  it 'creates a range of dates' do
    checkin = "20160320".to_date
    checkout = "20160322".to_date
    result = Reservation.date_range(checkin, checkout)

    expect(result.count).to eq 3
    expect(result.class).to eq Array
    expect(result.first.class).to eq Date
  end
end
