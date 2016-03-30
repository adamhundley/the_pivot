class Admin::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.reservation_index(params[:status])
  end

  def show
    @reservation = Reservation.find(params[:id])
    # require "pry"; binding.pry
  end
end
