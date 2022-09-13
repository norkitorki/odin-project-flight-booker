class Passenger < ApplicationRecord
  validates :name, 
    presence: true

  validates :email,
    presence: true,
    uniqueness: true

  has_and_belongs_to_many :bookings
end
