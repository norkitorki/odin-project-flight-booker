class Booking < ApplicationRecord
  before_validation :validate_passenger_existence
  after_validation  :validate_passenger_list_presence

  belongs_to :flight

  has_and_belongs_to_many :passengers

  validates :passengers,
    presence: true

  accepts_nested_attributes_for :passengers, 
    reject_if: :all_blank

  private

  def validate_passenger_list_presence
    flight_list = flight.passengers
    passengers.each do |passenger|
      if flight_list.any? { |p| p.name == passenger.name && p.email == passenger.email }
        errors.add(:passenger, "#{passenger.name} is already on the flight list")
      end
    end
  end

  def validate_passenger_existence
    self.passengers = passengers.to_a.map do |passenger|
      Passenger.find_by(name: passenger.name, email: passenger.email) || passenger
    end
  end

end
