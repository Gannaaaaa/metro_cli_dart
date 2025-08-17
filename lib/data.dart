  // Line 1 Stations
  List<String> line1Stations = [
    "New Marg",
    "El Marg",
    "Ezbet El-Nakhl",
    "Ain Shams",
    "El Matareyya",
    "Helmeyet El Zaitoun",
    "Hadayeq El Zaitoun",
    "Saray El Qobba",
    "Hammamat El Qobba",
    "Kobri El Qobba",
    "Manshiet El Sadr",
    "El Demerdash",
    "Ghamra",
    "Al Shohadaa",
    "Orabi",
    "Nasser",
    "Sadat",
    "Saad Zaghloul",
    "Al Sayeda Zeinab",
    "El Malek El Saleh",
    "Mar Girgis",
    "El-Zahraa",
    "Dar El Salam",
    "Hadayek El Maadi",
    "Maadi",
    "Sakanat El Maadi",
    "Tora El Balad",
    "Kozzika",
    "Tora El Esmant",
    "Elmasraa",
    "Hadayek Helwan",
    "Wadi Hof",
    "Helwan University",
    "Ain Helwan",
    "Helwan"
  ];

  // Line 2 Stations
  List<String> line2Stations = [
    "Shubra Al Khaimah",
    "Koliet El Zeraa",
    "Mezallat",
    "Khalafawy",
    "St. Teresa",
    "Rod El Farag",
    "Masarra",
    "Al Shohadaa",
    "Attaba",
    "Mohamed Naguib",
    "Sadat",
    "Opera",
    "Dokki",
    "El Bohoth",
    "Cairo University",
    "Faisal",
    "Giza",
    "Omm El Masryeen",
    "Sakiat Mekky",
    "El Monib"
  ];

  // Line 3 Stations (Main line)
  List<String> line3Stations = [
    "Adly Mansour",
    "Haykestep",
    "Omar Ibn El Khattab",
    "Qubaa",
    "Hesham Barakat",
    "El Nozha",
    "El Shams Club",
    "Alf Masken",
    "Heliopolis",
    "Haroun",
    "Al Ahram",
    "Koleyet El Banat",
    "Cairo Stadium",
    "El Maard",
    "Abbassiya",
    "Abdou Pasha",
    "El Geish",
    "Bab El Shaariya",
    "Attaba",
    "Nasser",
    "Maspero",
    "Safaa Hegazy",
    "Kit Kat"
  ];

  // Line 3 - Subline 1 (from Kit Kat)
  List<String> line3Subline1 = [
    "Kit Kat",
    "Sudan",
    "Imbaba",
    "El Bohy",
    "El Qawmia",
    "Ring Road",
    "Rod El Farag Corridor"
  ];

  // Line 3 - Subline 2 (from Kit Kat)
  List<String> line3Subline2 = [
    "Kit Kat",
    "Tawfikia",
    "Wadi El Nile",
    "Gamet El Dowal",
    "Boulak El Dakrour",
    "Cairo University"
  ];

  // intersections
  Map<String, List<String>> transferStations = {
    "Al Shohadaa": ["1", "2"],
    "Sadat": ["1", "2"],
    "Attaba": ["2", "3"],
    "Nasser": ["1", "3"],
    "Kit Kat": ["3", "3-1", "3-2"], // Main line and both sublines
    "Cairo University": ["2", "3-2"] // Appears in Line 2 and Subline 2
  };

  Map<String, double> lineLengthsKm = {
    "1": 44.0,
    "2": 21.6,
    "3": 41.2
  };


// Cairo Metro Stations with GPS Coordinates
Map<String, Map<String, List<double>>> metroStations = {
  "1": {
    "New Marg": [30.163530, 31.338294],
    "Marg": [30.163613, 31.338360],
    "Ezbet El-Nakhl": [30.139305, 31.324337],
    "Ain Shams": [30.131062, 31.319063],
    "El Matareyya": [30.121250, 31.313750],
    "Helmeyet El Zaitoun": [30.114937, 31.315438],
    "Hadayeq El Zaitoun": [30.105938, 31.310437],
    "Saray El Qobba": [30.097687, 31.304563],
    "Hammamat El Qobba": [30.091188, 31.298938],
    "Kobri El Qobba": [30.087187, 31.294063],
    "Manshiet El Sadr": [30.081938, 31.287562],
    "El Demerdash": [30.077312, 31.277813],
    "Ghamra": [30.069063, 31.264563],
    "Al Shohadaa": [30.061563, 31.246688],
    "Orabi": [30.056688, 31.242063],
    "Nasser": [30.052563, 31.240812],
    "Sadat": [30.043563, 31.235813],
    "Saad Zaghloul": [30.037062, 31.238437],
    "Al Sayeda Zeinab": [30.029313, 31.235437],
    "El Malek El Saleh": [30.017688, 31.231063],
    "Mar Girgis": [30.006062, 31.229687],
    "El-Zahraa": [29.995438, 31.231187],
    "Dar El Salam": [29.982062, 31.242188],
    "Hadayek El Maadi": [29.970188, 31.250563],
    "Maadi": [29.960313, 31.257688],
    "Sakanat El Maadi": [29.952937, 31.263438],
    "Tora El Balad": [29.946813, 31.272937],
    "Kozzika": [29.936312, 31.281813],
    "Tora El Esmant": [29.925937, 31.287562],
    "Elmasraa": [29.906062, 31.299563],
    "Hadayek Helwan": [29.897188, 31.303937],
    "Wadi Hof": [29.879062, 31.313562],
    "Helwan University": [29.869438, 31.320062],
    "Ain Helwan": [29.862563, 31.324937],
    "Helwan": [29.848937, 31.334187],
  },

  "2": {
    "Shubra Al Khaimah": [30.124187, 31.243313],
    "Koliet El Zeraa": [30.113687, 31.248688],
    "Mezallat": [30.104188, 31.245688],
    "Khalafawy": [30.097187, 31.245438],
    "St. Teresa": [30.087938, 31.245438],
    "Rod El Farag": [30.080562, 31.245438],
    "Masarra": [30.070937, 31.245063],
    "Al Shohadaa": [30.061563, 31.246688],
    "Attaba": [30.052312, 31.246812],
    "Mohamed Naguib": [30.045313, 31.244188],
    "Sadat": [30.043563, 31.235813],
    "Opera": [30.041938, 31.224938],
    "Dokki": [30.038438, 31.212187],
    "El Bohoth": [30.035812, 31.200187],
    "Cairo University": [30.026063, 31.201188],
    "Faisal": [30.017313, 31.203938],
    "Giza": [30.010688, 31.207062],
    "Omm El Masryeen": [30.005688, 31.208062],
    "Sakiat Mekky": [29.995438, 31.208687],
    "El Monib": [29.981063, 31.212313],
  },

  "3": {
    "Adly Mansour": [30.147062, 31.421188],
    "Haykestep": [30.143813, 31.404688],
    "Omar Ibn El Khattab": [30.140437, 31.394312],
    "Qubaa": [30.134813, 31.383688],
    "Hesham Barakat": [30.130812, 31.372937],
    "El Nozha": [30.127938, 31.360188],
    "El Shams Club": [30.125437, 31.348937],
    "Alf Masken": [30.119062, 31.340187],
    "Heliopolis": [30.108438, 31.338313],
    "Haroun": [30.101312, 31.332937],
    "Al Ahram": [30.091687, 31.326313],
    "Koleyet El Banat": [30.084063, 31.329062],
    "Cairo Stadium": [30.072938, 31.317062],
    "El Maard": [30.073313, 31.300937],
    "Abbassiya": [30.071937, 31.283437],
    "Abdou Pasha": [30.064813, 31.274813],
    "El Geish": [30.061813, 31.266937],
    "Bab El Shaariya": [30.054187, 31.255938],
    "Attaba": [30.052312, 31.246812],
    "Nasser": [30.052563, 31.240812],
    "Maspero": [30.055687, 31.232062],
    "Safaa Hegazy": [30.062312, 31.223312],
    "Kit Kat": [30.066562, 31.213062],
  },

  "3.1": {
    "Kit Kat": [30.066562, 31.213062],
    "Sudan": [30.070062, 31.204687],
    "Imbaba": [30.075812, 31.207437],
    "El Bohy": [30.084313, 31.211312],
    "El Qawmia": [30.093063, 31.209187],
    "Ring Road": [30.096438, 31.199562],
    "Rod El Farag Corridor": [30.101937, 31.184438],
  },

  "3.2": {
    "Kit Kat": [30.066562, 31.213062],
    "Tawfikia": [30.065062, 31.202438],
    "Wadi El Nile": [30.057063, 31.201188],
    "Gamet El Dowal": [30.050187, 31.198937],
    "Boulak El Dakrour": [30.037562, 31.195563],
    "Cairo University": [30.025312, 31.201813],
  }
};



  // Helper Function: isTransferStation
  bool isTransferStation(String stationName) {
    return transferStations.containsKey(stationName);
  }
