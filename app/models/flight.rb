class Flight < ApplicationRecord
  scope :departure_airports, -> { includes(:departure_airport).map(&:departure_airport).uniq! }
  scope :arrival_airports,   -> { includes(:arrival_airport).map(&:arrival_airport).uniq! }
  scope :departure_dates,    -> { map { |flight| flight.departure_time.strftime('%Y/%m/%d') }.uniq! }

  belongs_to :airline

  belongs_to :departure_airport,
    class_name: 'Airport'

  belongs_to :arrival_airport,
    class_name: 'Airport'

  has_many :bookings,
    dependent: :destroy

  has_many :passengers,
    through: :bookings
end
