class FlightsController < ApplicationController
  def index
    @departures = Airport.collect_departures
    @departure_airports = @departures.map(&AIRPORT_OPTIONS)
    @arrival_airports   = @departures.map { |a| a[:destinations] }.flatten.map(&AIRPORT_OPTIONS)
    gon.departures      = @departures
    @flights = flights_query(flight_query_params) if params[:commit]
  end

  private

  AIRPORT_OPTIONS = Proc.new { |airport| ["#{airport[:city]} (#{airport[:name]})", airport[:id]] }

  def flight_query_params
    params.permit(:departure_airport, :arrival_airport, :departure_date, :passenger_count, :commit)
  end

  def flights_query(params)
    d = params[:departure_airport]
    a = params[:arrival_airport]
    t = Time.parse(params[:departure_date].split('/').join('-'))

    query = 'departure_time BETWEEN ? AND ? AND departure_airport_id = ? AND arrival_airport_id = ?'
    Flight.includes(:airline, :departure_airport, :arrival_airport).where(query, t.midnight, t.end_of_day, d, a)
  end
end
