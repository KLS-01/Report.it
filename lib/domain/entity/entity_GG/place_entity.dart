import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'geometry_entity.dart';

class Place {
  final String id;
  final String name;
  final Geometry geometry;
  final String vicinity;
  final BitmapDescriptor icon;

  get getId => this.id;
  get getName => this.name;
  get getGeometry => this.geometry;
  get getVicinity => this.vicinity;
  get getIcon => this.icon;

  Place(
      {required this.id,
      required this.name,
      required this.geometry,
      required this.vicinity,
      required this.icon});

  Place.fromJson(Map<dynamic, dynamic> parsedJson, BitmapDescriptor icon)
      : id = parsedJson['place_id'],
        name = parsedJson['name'],
        geometry = Geometry.fromJson(parsedJson['geometry']),
        vicinity = parsedJson['vicinity'],
        icon = icon;

  @override
  String toString() {
    String s = 'Marker: $name, $geometry, $icon |';
    return s;
  }
}
