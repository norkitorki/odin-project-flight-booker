class FlightsController < ApplicationController
  def index
    @departure_airports = departure_airports
    gon.departures = collect_departures
    @flights = flights_query(params) if params[:commit]
  end

  private

  def departure_airports
    Flight.includes(:departure_airport).map(&:departure_airport).uniq.map { |a| ["#{a.city} (#{a.name})", a.id] }
  end

  def collect_departures
    Airport.includes(:departures, :arrivals).select { |a| a.departures.any? }.map do |a|
      destinations = a.departures.pluck(:arrival_airport_id).uniq.map do |id|
        destination = Airport.find(id)
        { id: destination.id,
          city: destination.city,
          name: destination.name,
          departure_dates: destination.arrivals.where(departure_airport_id: a.id).pluck(:departure_time)
        }
      end

      { id: a.id, city: a.city, destinations: destinations }
    end
  end

  def flights_query(flight_params)
    d = flight_params[:departure_airport]
    a = flight_params[:arrival_airport]
    t = Time.parse(flight_params[:departure_day].split('/').reverse.join('-'))

    query = 'departure_time BETWEEN ? AND ? AND departure_airport_id = ? AND arrival_airport_id = ?'
    Flight.includes(:airline).where(query, t.midnight, t.end_of_day, d, a)
  end
end
