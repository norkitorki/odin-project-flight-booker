class AddAirportReferencesToFlights < ActiveRecord::Migration[7.0]
  def change
    add_reference :flights, :departure_airport, null: false
    add_reference :flights, :arrival_airport, null: false
  end
end
