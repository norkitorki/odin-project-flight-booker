const departureAirportSelect = document.getElementById('departure_airport');
const arrivalAirportSelect   = document.getElementById('arrival_airport');
const departureDayField      = document.getElementById('departure_day');

const calendar = new Kalendae.Input(departureDayField, { format: 'DD/MM/YYYY', direction: 'today-future' });

const departures = gon.departures;

let updateArrivalAirports = function(object, destinations) {
  options = "";
  destinations.forEach(airport => {
    options += `<option value="${airport.id}">${airport.city} (${airport.name})</option>`;
  });
  return object.innerHTML = options;
};

let blackoutDepartureDates = function(calendarObject, departureDates) {
  calendarObject.blackout = function (date) {
    function departureDate(day) {
      return date._d.toDateString() === new Date(day).toDateString();
    }
    return !departureDates.some(departureDate);
  }
};

updateArrivalAirports(arrivalAirportSelect, departures[0].destinations);
blackoutDepartureDates(calendar, departures[0].destinations[0].departure_dates);

[departureAirportSelect, arrivalAirportSelect].forEach(airportSelect => {
  airportSelect.addEventListener('change', () => {
    departureDayField.value = "";

    const selectedDepartureAirport = departures[departureAirportSelect.options.selectedIndex];
    if (airportSelect === departureAirportSelect) {
      updateArrivalAirports(arrivalAirportSelect, selectedDepartureAirport.destinations);
    }
    
    const selectedArrivalAirport = selectedDepartureAirport.destinations[arrivalAirportSelect.options.selectedIndex];
    blackoutDepartureDates(calendar, selectedArrivalAirport.departure_dates);
  })
});
