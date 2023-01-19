import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:report_it/domain/entity/entity_GG/adapter_geometry.dart';
import 'geometry_entity.dart';

class Place {
  late final String id;
  final String name;
  final Geometry geometry;
  final String vicinity;
  BitmapDescriptor? icon = null;

  get getId => this.id;
  get getName => this.name;
  get getGeometry => this.geometry;
  get getVicinity => this.vicinity;
  get getIcon => this.icon;

  Place({
    required this.id,
    required this.name,
    required this.geometry,
    required this.vicinity,
  });

//   Place.fromJson(Map<dynamic, dynamic> parsedJson)
//       : id = parsedJson['place_id'],
//         name = parsedJson['name'],
//         geometry = AdapterGeoemetry().fromJson(parsedJson['geometry']),
//         vicinity = parsedJson['vicinity'];

  @override
  String toString() {
    String s = 'Marker: $name, $geometry, $icon |';
    return s;
  }
}
