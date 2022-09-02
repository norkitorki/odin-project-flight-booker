class BookingsController < ApplicationController
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
      flash.now[:alert] = 'Your booking as not been created.'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: %i[ name email ])
  end
end
