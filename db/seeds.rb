# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Delete all entries from tables
Airport.destroy_all
Airline.destroy_all
Flight.destroy_all

# Create some airports
Airport.create(
  [
    { name: 'Oslo Gardemoen', city: 'Oslo', country: 'Norway' },
    { name: 'Frankfurt am Main', city: 'Frankfurt', country: 'Germany' },
    { name: 'Heathrow', city: 'London', country: 'United Kingdom' },
    { name: 'Arlanda', city: 'Stockholm', country: 'Sweden' },
    { name: 'Charles de Gaulle', city: 'Paris', country: 'France' },
    { name: 'Leonardo da Vinci–Fiumicino', city: 'Rome', country: 'Italy' }
  ]
)

AIRPORTS = Airport.all

# Create some airlines
Airline.create(
  [
    { name: 'Lufthansa' },
    { name: 'Norwegian' },
    { name: 'Scandinavian Airlines' },
    { name: 'British Airways' },
    { name: 'Air France' }
  ]
)

AIRLINES = Airline.all

# Create some flights

365.times do |i|
  departure_airport = AIRPORTS.sample
  arrival_airport   = (AIRPORTS - [departure_airport]).sample
  3.times do |y|
    departure_time = Time.now.midnight + (i + y).days + rand(9..21).hours + rand(1..59).minutes
    airline        = AIRLINES.sample
    Flight.create(
      departure_time: departure_time, 
      airline_id: airline.id, 
      departure_airport_id: departure_airport.id, 
      arrival_airport_id: arrival_airport.id, 
      arrival_time: departure_time + 2.hours + rand(0..59).minutes)
  end
end