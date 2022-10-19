class PassengerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.passenger_mailer.booking_confirmation.subject
  #
  def booking_confirmation
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
