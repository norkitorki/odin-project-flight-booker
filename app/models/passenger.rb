class Passenger < ApplicationRecord
  validates :name, :email, presence: true

  has_and_belongs_to_many :bookings
end
