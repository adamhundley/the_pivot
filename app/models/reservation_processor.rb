class ReservationProcessor
  attr_reader :property, :reservation

  def initialize(current_user, reservation_params)
    @property = find_property(reservation_params)
    @reservation = make_reservation(process_reservation_params(current_user, reservation_params))
    make_reservation_nights(reservation)
  end

  def make_reservation(params)
    property.reservations.create(params)
  end

  def make_reservation_nights(reservation)
    ReservationNight.book_nights(reservation)
  end

  def find_property(params)
    Property.find(params["property_id"])
  end

  def process_reservation_params(current_user, params)
    {
      email: params[:stripeEmail],
      fullname: params[:stripeShippingName],
      street: params[:stripeShippingAddressLine1],
      city: params[:stripeShippingAddressCity],
      state: params[:stripeShippingAddressState],
      zip: params[:stripeShippingAddressZip],
      card_token: params[:stripeToken],
      checkin: params[:checkin],
      checkout: params[:checkout],
      user_id: current_user.id,
      order_total: params[:reservation_total].to_i}
  end
end
