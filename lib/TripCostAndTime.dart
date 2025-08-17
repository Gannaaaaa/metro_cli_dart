// Functions to calculate trip time and ticket price

// Trip time: 2 min per station + 5 min per transfer
int calculateTripTime(int totalStations, int transfers) {
  return (totalStations * 2) + (transfers * 5);
}

// Ticket price: 5/7/10 EGP based on number of stations
int calculateTicketPrice(int totalStations) {
  if (totalStations <= 9) {
    return 5;
  } else if (totalStations <= 16) {
    return 7;
  } else {
    return 10;
  }
}