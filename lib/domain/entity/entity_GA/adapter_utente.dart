import 'package:report_it/domain/entity/adapter.dart';
import 'package:report_it/domain/entity/entity_GA/utente_entity.dart';

class AdapterUtente implements Adapter {
  @override
  toMap(object) {
    object = object as Utente;
    return {
      "CF": object.cf,
      "id": object.id,
    };
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return Utente(json["CF"], json["id"]);
  }

  @override
  fromMap(map) {
    return Utente(map['CF'], map["id"]);
  }
}
