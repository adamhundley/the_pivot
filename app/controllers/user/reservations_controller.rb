class User::ReservationsController < ApplicationController
  def create
    res_processor = ReservationProcessor.new(current_user, reservation_params)
    @reservation = res_processor.reservation
    if @reservation.save
      @reservation.process_stripe_payment
      OrderMailer.order_email(@reservation).deliver_now
      flash[:info] = "Thanks for your order! :)"
      session[:cart] = nil
      redirect_to user_dashboard_path(current_user.slug)
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :new
    end
  end

  def index
    @reservations = current_user.reservations
  end

  private

    def reservation_params
      params.permit(:stripeEmail, :stripeToken, :stripeShippingName, :stripeShippingAddressLine1, :stripeShippingAddressCity, :stripeShippingAddressZip, :stripeShippingAddressState, :stripeShippingAddressZip, :property_user_id, :property_id, :checkin, :checkout, :reservation_total)
    end

end
