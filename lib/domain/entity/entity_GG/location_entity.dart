class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  @override
  String toString() {
    String s = 'Location: $lat, $lng |';
    return s;
  }
}
