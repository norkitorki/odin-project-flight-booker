class PassengerMailer < ApplicationMailer
  default from: email_address_with_name('noreply@flight-booker.example', 'noreply')

  def booking_confirmation(booking, passenger)
    @booking   = booking
    @passenger = passenger

    mail(
      to: email_address_with_name(passenger.email, passenger.name),
      subject: 'Booking confirmation from FlightBooker'
    )
  end
end
