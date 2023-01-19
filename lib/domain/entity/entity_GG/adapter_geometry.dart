import 'package:report_it/domain/entity/adapter.dart';
import 'package:report_it/domain/entity/entity_GG/adapter_location.dart';
import 'package:report_it/domain/entity/entity_GG/geometry_entity.dart';
import 'package:report_it/domain/entity/entity_GPSP/prenotazione_entity.dart';

class AdapterGeometry implements Adapter {
  @override
  fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: AdapterLocation().fromJson(json['location']),
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
