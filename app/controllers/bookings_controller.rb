class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:flight_id])
    @booking = @flight.bookings.new
    params[:passenger_count].to_i.times { @booking.passengers.new }
  end
end
