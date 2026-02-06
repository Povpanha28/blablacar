import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  //
  //  filter the rides starting from given departure location
  //
  static List<Ride> _filterByDeparture(List<Ride> rides, Location departure) {
    List<Ride> filtered = rides
        .where((r) => r.departureLocation == departure)
        .toList();

    return filtered;
  }

  //
  //  filter the rides starting for the given requested seat number
  //
  static List<Ride> _filterBySeatRequested(
    List<Ride> rides,
    int requestedSeat,
  ) {
    List<Ride> filtered = rides
        .where((r) => r.availableSeats >= requestedSeat)
        .toList();
    return filtered;
  }

  //
  //  filter the rides   with several optional criteria (flexible filter options)
  //
  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    List<Ride> filtered = [];
    if (departure != null) {
      filtered = _filterByDeparture(availableRides, departure);
    }
    if (seatRequested != null) {
      filtered = _filterBySeatRequested(availableRides, seatRequested);
    }
    return filtered;
  }
}
