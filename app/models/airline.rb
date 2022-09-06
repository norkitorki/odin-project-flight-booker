class Airline < ApplicationRecord
  has_many :flights,
    dependent: :destroy

  has_many :departure_airports, 
    through: :flights

  has_many :arrival_airports, 
    through: :flights

  has_many :bookings,
    through: :flights
end
