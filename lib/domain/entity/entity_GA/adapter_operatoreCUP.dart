import 'package:report_it/domain/entity/adapter.dart';
import 'package:report_it/domain/entity/entity_GA/operatoreCUP_entity.dart';

class AdapterOperatoreCUP implements Adapter {
  @override
  fromJson(Map<String, dynamic> json) {
    return OperatoreCUP(
      json["ID"],
      json["Password"],
      json["Email"],
      json["ASL"],
      json["CoordASL"],
      json["CapASL"],
      json["CittaASL"],
      json["IndirizzoASL"],
      json["ProvinciaASL"],
      json["Nome"],
      json["Cognome"],
    );
  }

  @override
  fromMap(map) {
    return OperatoreCUP(
      map["ID"],
      map["Password"],
      map["Email"],
      map["ASL"],
      map["CoordASL"],
      map["CapASL"],
      map["CittaASL"],
      map["IndirizzoASL"],
      map["ProvinciaASL"],
      map["Nome"],
      map["Cognome"],
    );
  }

  @override
  toMap(object) {
    object = object as OperatoreCUP;
    return {
      "ID": object.id,
      "Password": object.password,
      "Email": object.email,
      "ASL": object.asl,
      "CoordASL": object.coordASL,
      "ProvinciaASL": object.provinciaASL,
      "CapASL": object.capASL,
      "CittaASL": object.cittaASL,
      "IndirizzoASL": object.indirizzoASL,
      "Nome": object.nome,
      "Cognome": object.cognome,
    };
  }
}
