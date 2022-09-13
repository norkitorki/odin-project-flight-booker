class Airport < ApplicationRecord
  has_many :departures,
    class_name: 'Flight',
    foreign_key: :departure_airport_id,
    dependent: :destroy

  has_many :arrivals,
    class_name: 'Flight',
    foreign_key: :arrival_airport_id,
    dependent: :destroy

  def self.collect_departures
    includes(:departures, :arrivals).select { |a| a.departures.any? }.map do |a|
      destinations = a.departures.pluck(:arrival_airport_id).uniq.map do |id|
        destination = find(id)
        { id: destination.id,
          city: destination.city,
          name: destination.name,
          departure_dates: destination.arrivals.where(departure_airport_id: a.id).pluck(:departure_time)
        }
      end

      { id: a.id, city: a.city, name: a.name, destinations: destinations }
    end
  end
end
