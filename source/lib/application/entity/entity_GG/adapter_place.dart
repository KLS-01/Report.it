import 'package:report_it/application/entity/adapter.dart';
import 'package:report_it/application/entity/entity_GG/adapter_location.dart';
import 'package:report_it/application/entity/entity_GG/place_entity.dart';

class AdapterPlace implements Adapter {
  @override
  fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['place_id'],
      name: json['name'],
      location: AdapterLocation().fromJson(json['geometry']),
      vicinity: json['vicinity'],
    );
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
