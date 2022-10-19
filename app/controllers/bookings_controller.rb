class BookingsController < ApplicationController
  def index
    if params[:commit]
      @bookings = find_bookings(search_params)
      if @bookings.nil? || @bookings.empty?
        flash.now[:alert] = 'No bookings have been found.'
        render :index, status: :unprocessable_entity
      end
    end
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
      @booking.passengers.each do |passenger|
        PassengerMailer.booking_confirmation(@booking, passenger).deliver_later
      end
      redirect_to booking_path(@booking), notice: 'Your booking has been successfully created.'
    else
      @flight = Flight.find(@booking.flight_id)
      params[:passenger_count].to_i.times { @booking.passengers.new }
      flash.now[:alert] = 'Booking has not been created.'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def search_params
    params.permit(:search)
  end

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: %i[ name email ])
  end

  def find_bookings(params)
    Passenger.where('name = :query OR email = :query', query: params[:search]).first&.bookings
  end
end
