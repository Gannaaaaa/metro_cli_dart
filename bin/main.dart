import './data.dart'; // بيانات الخطوط
import './RouteCalculation.dart';

void main() {
  // ✅ Test 1: Maadi → Helwan (نفس الخط - Line 1)
  print('--- Test 1: Maadi → Helwan (Same Line) ---');
  var result1 = findPath('Maadi', 'Helwan');
  printResult(result1);

  // 🔁 Test 2: Maadi → Attaba (Line 1 → Line 2 via Sadat)
  print('\n--- Test 2: Maadi → Attaba (Transfer via Sadat) ---');
  var result2 = findPath('Maadi', 'Attaba');
  printResult(result2);

  // 🔁 Test 3: Giza → Kit Kat (Line 2 → Line 3 via Attaba)
  print('\n--- Test 3: Giza → Kit Kat (No direct transfer) ---');
  var result3 = findPath('Giza', 'Kit Kat');
  printResult(result3);

  // ❌ Test 4: محطة مش موجودة
  print('\n--- Test 4: NotRealStation → Maadi (Invalid Station) ---');
  var result4 = findPath('NotRealStation', 'Maadi');
  printResult(result4);

  // 🔁 Test 5: Giza → Cairo University (نفس الخط Line 2)
  print('\n--- Test 5: Giza → Cairo University (Same Line) ---');
  var result5 = findPath('Giza', 'Cairo University');
  printResult(result5);

  // 🔁 Test 6: Cairo University → Boulak El Dakrour (Line 2 → Line 3-2)
  print('\n--- Test 6: Cairo University → Boulak El Dakrour (Transfer between 2 and 3-2) ---');
  var result6 = findPath('Cairo University', 'Boulak El Dakrour');
  printResult(result6);

  // 🔁 Test 7: Alf Masken → Sudan (Line 3 → 3-1) via Kit Kat
  print('\n--- Test 7: Alf Masken → Sudan (3 → 3-1 via Kit Kat) ---');
  var result7 = findPath('Alf Masken', 'Sudan');
  printResult(result7);
}

void printResult(Map<String, dynamic> result) {
  if (result.containsKey('error')) {
    print('❌ Error: ${result['error']}');
  } else {
    print('📍 Route: ${result['path'].join(" → ")}');
    print('🚏 Total Stations: ${result['totalStations']}');
    print('🚇 Lines Used: ${result['linesUsed'].join(", ")}');
    print('🔁 Transfer Station: ${result['transferStation'] ?? "No Transfer"}');
  }
}
