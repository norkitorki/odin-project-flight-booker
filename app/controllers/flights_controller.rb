class FlightsController < ApplicationController
  def index
    @departure_airports = Flight.departure_airports.map(&AIRPORT_OPTIONS)
    @arrival_airports = Flight.arrival_airports.map(&AIRPORT_OPTIONS) - [@departure_airports.first]
    gon.departures = collect_departures
    @flights = flights_query(params) if params[:commit]
  end

  private

  AIRPORT_OPTIONS = Proc.new { |airport| ["#{airport.city} (#{airport.name})", airport.id] }

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
    Flight.includes(:airline, :departure_airport, :arrival_airport).where(query, t.midnight, t.end_of_day, d, a)
  end
end
