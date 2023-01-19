class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

//   factory Location.fromJson(Map<dynamic, dynamic> parsedJson) {
//     return Location(lat: parsedJson['lat'], lng: parsedJson['lng']);
//   }

  @override
  String toString() {
    String s = 'Location: $lat, $lng |';
    return s;
  }
}
