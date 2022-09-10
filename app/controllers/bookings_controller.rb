class BookingsController < ApplicationController
  def index
  end

  def show
    @booking = Booking.find(params[:id])
    @flight = @booking.flight
  end

  def new
    @flight = Flight.find(params[:flight_id])
    @booking = @flight.bookings.new
    params[:passenger_count].to_i.times { @booking.passengers.new }
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to booking_path(@booking), notice: 'Your booking has been successfully created.'
    else
      passenger_count = (params[:booking][:passengers_attributes].keys.last.to_i + 1)
      redirect_to new_booking_path(params: { flight_id: @booking.flight_id, passenger_count: passenger_count }), 
        alert: @booking.errors.full_messages.join(' and ') << '.'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: %i[ name email ])
  end
end
