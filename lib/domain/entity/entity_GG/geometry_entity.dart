import 'location_entity.dart';

class Geometry {
  final Location location;

  Geometry({required this.location});

//   Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
//       : location = Location.fromJson(parsedJson['location']);

  @override
  String toString() {
    String s = 'Geometry: $location |';
    return s;
  }
}
