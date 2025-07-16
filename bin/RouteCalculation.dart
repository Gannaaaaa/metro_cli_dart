import './data.dart';

Map<String, List<String>> allLines = {
  "1": line1Stations,
  "2": line2Stations,
  "3": line3Stations,
  "3-1": line3Subline1,
  "3-2": line3Subline2,
};

//de lya ana mhdsh ystkhdmha
Map<String, dynamic> sameLine(String sourceStation, String destinationStation) {
  String? lineOfSource;
  String? lineOfDestination;

  for (var entry in allLines.entries) {
    if (entry.value.contains(sourceStation)) {
      lineOfSource = entry.key;
    }
    if (entry.value.contains(destinationStation)) {
      lineOfDestination = entry.key;
    }
    if (lineOfSource != null && lineOfDestination != null) {
      break;
    }
  }

  if (lineOfSource == null || lineOfDestination == null) {
    return {
      'same': false,
      'message': 'One or both stations not found.'
    };
  }

  if (lineOfSource == lineOfDestination) {
    return {
      'same': true,
      'line': lineOfSource
    };
  } else {
    return {
      'same': false,
      'sourceLine': lineOfSource,
      'destinationLine': lineOfDestination
    };
  }
}


Map<String, dynamic> findPath(String sourceStation, String destinationStation) {
  final result = sameLine(sourceStation, destinationStation);

  if (result['same']) {
    // ✅ el etneen fe nafs el line
    String line = result['line'];
    List<String> stations = allLines[line]!;

    int startIndex = stations.indexOf(sourceStation);
    int endIndex = stations.indexOf(destinationStation);

    List<String> path = (startIndex < endIndex)
        ? stations.sublist(startIndex, endIndex + 1)
        : stations.sublist(endIndex, startIndex + 1).reversed.toList();

    return {
      'path': path,
      'totalStations': path.length - 1,
      'linesUsed': [line],
      'transferStation': null,
    };
  } else if (result.containsKey('message')) {
    // ❌ station mosh mawgoda f ay line
    return {
      'error': result['message']
    };
  } else {
    //  el etneen fe 2 lines mokhtalfa → ne7tag na3mel transfer
    String lineA = result['sourceLine'];
    String lineB = result['destinationLine'];

    String? interchangeStation;

    //  nshoof law fe station beyshofhom el etneen (transfer station)
    for (var station in transferStations.entries) {
      if (station.value.contains(lineA) && station.value.contains(lineB)) {
        interchangeStation = station.key;
        break;
      }
    }

    if (interchangeStation == null) {
      // ❌ mfish ay station momken ykon transfer mabin el etneen
      return {
        'error': 'No direct interchange between $lineA and $lineB.'
      };
    }

    //  el masar men el source lal interchange
    List<String> stationsA = allLines[lineA]!;
    int startA = stationsA.indexOf(sourceStation);
    int endA = stationsA.indexOf(interchangeStation);
    List<String> pathA = (startA < endA)
        ? stationsA.sublist(startA, endA + 1)
        : stationsA.sublist(endA, startA + 1).reversed.toList();

    //  el masar men el interchange lal destination
    List<String> stationsB = allLines[lineB]!;
    int startB = stationsB.indexOf(interchangeStation);
    int endB = stationsB.indexOf(destinationStation);
    List<String> pathB = (startB < endB)
        ? stationsB.sublist(startB + 1, endB + 1)
        : stationsB.sublist(endB, startB).reversed.toList();

    //  combine el masar el kamel
    List<String> fullPath = [...pathA, ...pathB];

    return {
      'path': fullPath,
      'totalStations': fullPath.length - 1,
      'linesUsed': [lineA, lineB],
      'transferStation': interchangeStation,
    };
  }
}

