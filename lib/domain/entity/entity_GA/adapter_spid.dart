import 'package:report_it/domain/entity/adapter.dart';
import 'package:report_it/domain/entity/entity_GA/spid_entity.dart';

class AdapterSpid implements Adapter {
  @override
  fromJson(Map<String, dynamic> json) {
    return SPID(
        json["CF"],
        json["Nome"],
        json["Cognome"],
        json["Luogo di Nascita"],
        json["Data di Nascita"].toDate(),
        json["Sesso"],
        json["TipoDocumento"],
        json["Numero Documento"],
        json["Domicilio fisico"],
        json["Provincia di nascita"],
        json["Data Scadenza Documento"].toDate(),
        json["Cellulare"].toString(),
        json["Email"],
        json["Password"].toString());
  }

  @override
  fromMap(map) {
    return SPID(
        map["CF"],
        map["Nome"],
        map["Cognome"],
        map["Luogo di Nascita"],
        map["Data di Nascita"],
        map["Sesso"],
        map["TipoDocumento"],
        map["Numero Documento"],
        map["Domicilio fisico"],
        map["Provincia di nascita"],
        map["Data Scadenza Documento"],
        map["Cellulare"],
        map["Email"],
        map["Password"]);
  }

  @override
  toMap(object) {
    object = object as SPID;
    return {
      "CF": object.cf,
      "Nome": object.nome,
      "Cognome": object.cognome,
      "Luogo di Nascita": object.luogoNascita,
      "Data di Nascita": object.dataNascita,
      "Sesso": object.sesso,
      "TipoDocumento": object.tipoDocumento,
      "Numero Documento": object.numeroDocumento,
      "Domicilio fisico": object.domicilioFisico,
      "Provincia di nascita": object.provinciaNascita,
      "Data Scadenza Documento": object.dataScadenzaDocumento,
      "Cellulare": object.numCellulare,
      "Email": object.indirizzoEmail,
      "Password": object.password
    };
  }
}
