const departureAirportSelect = document.getElementById('departure_airport');
const arrivalAirportSelect   = document.getElementById('arrival_airport');
const departureDateField     = document.getElementById('departure_date');

departureDateField.outerHTML = `<input placeholder="YYYY/MM/DD" required="required" type="text" name="departure_date" id="departure_date">`;

const calendar = new Kalendae.Input('departure_date', { format: 'YYYY/MM/DD', direction: 'today-future' });

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
    const selectedDepartureAirport = departures[departureAirportSelect.options.selectedIndex];
    if (airportSelect === departureAirportSelect) {
      updateArrivalAirports(arrivalAirportSelect, selectedDepartureAirport.destinations);
    }
    
    const selectedArrivalAirport = selectedDepartureAirport.destinations[arrivalAirportSelect.options.selectedIndex];
    blackoutDepartureDates(calendar, selectedArrivalAirport.departure_dates);
  })
});
