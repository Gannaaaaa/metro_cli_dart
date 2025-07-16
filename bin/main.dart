import 'dart:io';
import './data.dart';
import './RouteCalculation.dart';
import './TripCostAndTime.dart';

void main() {
  print('=== Cairo Metro Route Finder ===');

  stdout.write('Enter starting station: ');
  String source = stdin.readLineSync()!.trim();

  stdout.write('Enter destination station: ');
  String destination = stdin.readLineSync()!.trim();

  print('\n--- Calculating route from $source → $destination ---\n');

  var result = findPath(source, destination);
  printResult(result);
}

void printResult(Map<String, dynamic> result) {
  if (result.containsKey('error')) {
    print('❌ Error: ${result['error']}');
  } else {
    print('📍 Route: ${result['path'].join(" → ")}');
    print('🚏 Total Stations: ${result['totalStations']}');
    print('🚇 Lines Used: ${result['linesUsed'].join(", ")}');
    print('🔁 Transfer Station: ${result['transferStation'] ?? "No Transfer"}');

    int totalStations = result['totalStations'];
    int transfers = (result['linesUsed'] as List).length - 1;
    int time = calculateTripTime(totalStations, transfers);
    int price = calculateTicketPrice(totalStations);
    print('⏱ Trip Time: $time min');
    print('💵 Ticket Price: $price EGP');
  }
}
