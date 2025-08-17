import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data.dart';                 // stations, lines, transferStations, stationCoords
import '../TripCostAndTime.dart';      // allLines, findPath(...)
import '../RouteCalculation.dart';     // calculateTripTime, calculateTicketPrice

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // State Variables
  String? _from;
  String? _to;
  Map<String, dynamic>? _result; // Holds the findPath result
  int? _time;                    // Minutes
  int? _price;                   // EGP
  Position? _currentPosition;    // User's current position

  // Unique, sorted station list across all lines
  late final List<String> _allStations = (() {
    final s = allLines.values.expand((e) => e).toSet().toList();
    s.sort();
    return s;
  })();

  // Set From to Nearest Station
  Future<void> _setFromToNearest() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled. Please enable them.')),
      );
      return;
    }

    // Check and request location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied, please enable them in settings.')),
      );
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _currentPosition = position;

    // Find nearest station
    double minDistance = double.infinity;
    String? nearest;
    for (var station in _allStations) {
      var coords = stationCoords[station];
      if (coords != null) {
        double dist = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          coords[0],
          coords[1],
        );
        if (dist < minDistance) {
          minDistance = dist;
          nearest = station;
        }
      }
    }

    if (nearest != null) {
      setState(() {
        _from = nearest;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('From set to nearest station: $nearest')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No station coordinates available.')),
      );
    }
  }

  // Navigate to Nearest Station
  Future<void> _navigateToFromStation() async {
    if (_from == null || _currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No from station or current location available.')),
      );
      return;
    }

    var coords = stationCoords[_from];
    if (coords == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No coordinates for the from station.')),
      );
      return;
    }

    final String origin = '${_currentPosition!.latitude},${_currentPosition!.longitude}';
    final String destination = '${coords[0]},${coords[1]}';
    final Uri url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&travelmode=walking',
    ); // Change to 'driving' if preferred

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch maps.')),
      );
    }
  }

  // Compute Route
  void _computeRoute() {
    if (_from == null || _to == null) return;

    if (_from == _to) {
      setState(() {
        _result = {'error': 'Source and destination are the same station.'};
        _time = null;
        _price = null;
      });
      return;
    }

    final r = findPath(_from!, _to!);

    if (r.containsKey('error')) {
      setState(() {
        _result = r;
        _time = null;
        _price = null;
      });
      return;
    }

    final totalStations = r['totalStations'] as int;
    final linesUsed = (r['linesUsed'] as List);
    final transfers = linesUsed.length - 1;

    setState(() {
      _result = r;
      _time = calculateTripTime(totalStations, transfers);
      _price = calculateTicketPrice(totalStations);
    });
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cairo Metro — Shortest Path')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Button to set From to nearest station
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _setFromToNearest,
                  icon: const Icon(Icons.location_searching),
                  label: const Text('Set From to Nearest Station'),
                ),
              ),
              const SizedBox(height: 12),

              // FROM Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'From station',
                  border: OutlineInputBorder(),
                ),
                value: _from,
                items: _allStations.map((st) {
                  return DropdownMenuItem(value: st, child: Text(st));
                }).toList(),
                onChanged: (v) => setState(() => _from = v),
              ),
              const SizedBox(height: 12),

              // TO Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'To station',
                  border: OutlineInputBorder(),
                ),
                value: _to,
                items: _allStations.map((st) {
                  return DropdownMenuItem(value: st, child: Text(st));
                }).toList(),
                onChanged: (v) => setState(() => _to = v),
              ),
              const SizedBox(height: 16),

              // Find Route Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: (_from != null && _to != null) ? _computeRoute : null,
                  icon: const Icon(Icons.route),
                  label: const Text('Find route'),
                ),
              ),

              const SizedBox(height: 20),

              // Navigate to Nearest Station Button
              if (_currentPosition != null && _from != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _navigateToFromStation,
                    icon: const Icon(Icons.map),
                    label: const Text('Navigate to Nearest Station on Maps'),
                  ),
                ),

              const SizedBox(height: 20),

              // Results
              if (_result != null)
                _ResultSection(
                  result: _result!,
                  time: _time,
                  price: _price,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultSection extends StatelessWidget {
  final Map<String, dynamic> result;
  final int? time;
  final int? price;

  const _ResultSection({
    required this.result,
    required this.time,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    if (result.containsKey('error')) {
      return _ErrorCard(message: result['error'].toString());
    }

    final path = (result['path'] as List).cast<String>();
    final totalStations = result['totalStations'] as int;
    final linesUsed = (result['linesUsed'] as List).join(', ');
    final transfer = result['transferStation'] ?? 'No transfer';

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RowLine(icon: Icons.directions_subway, label: 'Path', value: path.join(' → ')),
            const SizedBox(height: 8),
            _RowLine(icon: Icons.stop, label: 'Total stations', value: '$totalStations'),
            _RowLine(icon: Icons.swap_calls, label: 'Transfer', value: '$transfer'),
            _RowLine(icon: Icons.layers, label: 'Lines used', value: linesUsed),
            const Divider(height: 24),
            if (time != null) _RowLine(icon: Icons.schedule, label: 'Trip time', value: '$time min'),
            if (price != null) _RowLine(icon: Icons.payments, label: 'Ticket price', value: '$price EGP'),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  const _ErrorCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.withOpacity(0.08),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(child: Text(message, style: const TextStyle(color: Colors.red))),
          ],
        ),
      ),
    );
  }
}

class _RowLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _RowLine({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}