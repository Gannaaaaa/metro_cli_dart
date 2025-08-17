import 'package:flutter/material.dart';

// ✅ adjust these imports to match your files
import '../data.dart';                 // stations/lines/transferStations
import '../TripCostAndTime.dart';          // allLines, findPath(...)
import '../RouteCalculation.dart';    // calculateTripTime, calculateTicketPrice

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _from;
  String? _to;

  Map<String, dynamic>? _result; // holds the findPath result
  int? _time;                     // minutes
  int? _price;                    // EGP

  // Unique, sorted station list across all lines
  late final List<String> _allStations = (() {
    final s = allLines.values.expand((e) => e).toSet().toList();
    s.sort();
    return s;
  })();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cairo Metro — Shortest Path')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // FROM
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

              // TO
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

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: (_from != null && _to != null) ? _computeRoute : null,
                  icon: const Icon(Icons.route),
                  label: const Text('Find route'),
                ),
              ),

              const SizedBox(height: 20),

              // Results
              if (_result != null) _ResultSection(
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