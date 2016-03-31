require 'rails_helper'

RSpec.describe ReservationProcessor, type: :model do
  it "should make reservations from the params " do
    property = create(:property)
    current_user = create(:user)
    params = {
               :checkin =>"2016-04-07",
               :checkout =>"2016-04-09",
               :reservation_total =>"2919",
               :stripeToken=>"tok_17v7KzHlkaHZyfqVbMS8agcQ",
               :stripeEmail=>"adamhundey@gmail.com",
               :stripeShippingName =>"Adam Hundley",
               :stripeShippingAddressLine1 =>"123 St.",
               :stripeShippingAddressZip =>"80279",
               :stripeShippingAddressState =>"CO",
               :stripeShippingAddressCity =>"Denver",
               :user_id => current_user.id,
               "property_id" => property.id
             }

    ReservationProcessor.new(current_user, params)

    expect(property.reservations.count).to eq 1
    expect(current_user.reservations.first.checkin).to eq params[:checkin].to_date
    expect(current_user.reservations.first.checkout).to eq params[:checkout].to_date
    expect(current_user.reservations.first.email).to eq params[:stripeEmail]
    expect(current_user.reservations.first.user_id).to eq current_user.id
    expect(current_user.reservations.first.property_id).to eq property.id
    expect(current_user.reservations.first.order_total).to eq params[:reservation_total].to_i
    expect(current_user.reservations.first.fullname).to eq params[:stripeShippingName]
    expect(current_user.reservations.first.street).to eq params[:stripeShippingAddressLine1]
    expect(current_user.reservations.first.city).to eq params[:stripeShippingAddressCity]
    expect(current_user.reservations.first.state).to eq params[:stripeShippingAddressState]
    expect(current_user.reservations.first.zip).to eq params[:stripeShippingAddressZip]
  end
end
