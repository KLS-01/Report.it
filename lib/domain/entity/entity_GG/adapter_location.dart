import 'package:report_it/domain/entity/adapter.dart';
import 'package:report_it/domain/entity/entity_GG/location_entity.dart';

class AdapterLocation implements Adapter {
  @override
  fromJson(Map<String, dynamic> json) {
    json = json['location'];
    return Location(lat: json['lat'], lng: json['lng']);
  }

  @override
  fromMap(map) {
    throw UnimplementedError();
  }

  @override
  toMap(dynamic prenotazione) {
    throw UnimplementedError();
  }
}
