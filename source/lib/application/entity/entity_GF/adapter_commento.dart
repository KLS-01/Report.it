import 'package:report_it/application/entity/adapter.dart';
import 'package:report_it/application/entity/entity_GF/discussione_entity.dart';

class AdapterCommento implements Adapter {
  @override
  fromJson(Map<String, dynamic> json) {
    var c = Commento(json["Creatore"], json["DataOra"].toDate(), json["Testo"],
        json["TipoUtente"]);

    c.id = json["ID"];

    return c;
  }

  @override
  fromMap(map) {
    var c = Commento(map["Creatore"], map["DataOra"].toDate(), map["Testo"],
        map["TipoUtente"]);

    c.id = map["ID"];

    return c;
  }

  @override
  toMap(object) {
    object = object as Commento;
    return {
      "Creatore": object.creatore,
      "DataOra": object.dataCreazione,
      "Testo": object.testo,
      "TipoUtente": object.tipoutente,
    };
  }
}
