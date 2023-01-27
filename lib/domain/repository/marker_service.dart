import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:report_it/domain/entity/entity_GG/place_entity.dart';

class MarkerService {
  Set<Marker> getMarkers(List<Place> places) {
    var markers = Set<Marker>();

    places.forEach((place) {
      Marker marker = Marker(
          markerId: MarkerId(place.id),
          draggable: false,
          icon: place.icon as BitmapDescriptor,
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.vicinity,
          ),
          position: LatLng(place.location.lat, place.location.lng));

      markers.add(marker);
    });

    return markers;
  }
}
