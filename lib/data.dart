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


  // Helper Function: isTransferStation
  bool isTransferStation(String stationName) {
    return transferStations.containsKey(stationName);
  }
