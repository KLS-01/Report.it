import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_entity.dart';

class Place {
  late final String id;
  final String name;
  final Location location;
  final String vicinity;
  BitmapDescriptor? icon = null;

  get getId => this.id;
  get getName => this.name;
  get getLocation => this.location;
  get getVicinity => this.vicinity;
  get getIcon => this.icon;

  Place({
    required this.id,
    required this.name,
    required this.location,
    required this.vicinity,
  });

  @override
  String toString() {
    String s = 'Marker: $name, $location, $icon |';
    return s;
  }
}
