class FlightsController < ApplicationController
  def index
    @departure_airports = airports_with_departures
    gon.departures = collect_departures
    @flights = flights_query(params) if params[:commit]
  end

  def search
  end
end
