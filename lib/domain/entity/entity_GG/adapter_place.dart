import 'package:report_it/domain/entity/adapter.dart';
import 'package:report_it/domain/entity/entity_GG/adapter_geometry.dart';
import 'package:report_it/domain/entity/entity_GG/place_entity.dart';

class AdapterPlace implements Adapter {
  @override
  fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['place_id'],
      name: json['name'],
      geometry: AdapterGeometry().fromJson(json['geometry']),
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
