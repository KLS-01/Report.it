import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:report_it/domain/entity/entity_GG/place_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyCz1L_f-suII8W3eDL8u4ge1cH7xR_yC08';

  Future<List<Place>>? getPlaces(
      double lat, double lng, List<BitmapDescriptor?> iconList) async {
    var places = <Place>[];
    places.addAll(
        await getPlacesByType(lat, lng, iconList.elementAt(0), 'hospital'));
    places.addAll(
        await getPlacesByType(lat, lng, iconList.elementAt(1), 'police'));

    return places;
  }

  Future<List<Place>> getPlacesByType(
      double lat, double lng, BitmapDescriptor? icon, String type) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat%2C$lng&radius=20000&&type=$type&key=$key';

    try {
      var response = await http.get(Uri.parse(url));
      var json = convert.jsonDecode(response.body);
      var jsonResults = json['results'] as List;
      var result =
          jsonResults.map((place) => Place.fromJson(place, icon!)).toList();

      return result;
    } catch (e) {
      print(
          'ERROR: Connessione non riuscita. Controlla la connessione e riprova.');
      return <Place>[]; //lista vuota perché non sono stati trovati risultati
    }
  }
}
