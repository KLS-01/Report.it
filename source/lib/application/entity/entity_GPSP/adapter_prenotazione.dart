import 'package:report_it/application/entity/adapter.dart';
import 'package:report_it/application/entity/entity_GPSP/prenotazione_entity.dart';

class AdapterPrenotazione implements Adapter {
  @override
  fromJson(Map<String, dynamic> json) {
    return Prenotazione(
        id: json["ID"],
        idUtente: json["IDUtente"],
        nomeUtente: json["NomeUtente"],
        cognomeUtente: json["CognomeUtente"],
        numeroUtente: json["NumeroUtente"],
        indirizzoUtente: json["IndirizzoUtente"],
        emailUtente: json["EmailUtente"],
        cfUtente: json["CFUtente"],
        idOperatore: json["IDOperatore"],
        cap: json["CAP"],
        impegnativa: json["Impegnativa"],
        nomeASL: json["NomeASL"],
        provincia: json["Provincia"],
        coordASL: json["CoordASL"],
        dataPrenotazione: json["DataPrenotazione"],
        psicologo: json["Psicologo"],
        descrizione: json["Descrizione"]);
  }

  @override
  fromMap(map) {
    return Prenotazione(
        id: map["ID"],
        idUtente: map["IDUtente"],
        nomeUtente: map["NomeUtente"],
        cognomeUtente: map["CognomeUtente"],
        numeroUtente: map["NumeroUtente"],
        indirizzoUtente: map["IndirizzoUtente"],
        emailUtente: map["EmailUtente"],
        cfUtente: map["CFUtente"],
        idOperatore: map["IDOperatore"],
        cap: map["CAP"],
        impegnativa: map["Impegnativa"],
        nomeASL: map["NomeASL"],
        provincia: map["Provincia"],
        coordASL: map["CoordASL"],
        dataPrenotazione: map["DataPrenotazione"],
        psicologo: map["Psicologo"],
        descrizione: map["Descrizione"]);
  }

  @override
  toMap(dynamic prenotazione) {
    prenotazione = prenotazione as Prenotazione;
    return {
      "ID": prenotazione.id,
      "IDUtente": prenotazione.idUtente,
      "IDOperatore": prenotazione.idOperatore,
      "NomeUtente": prenotazione.nomeUtente,
      "CognomeUtente": prenotazione.cognomeUtente,
      "NumeroUtente": prenotazione.numeroUtente,
      "IndirizzoUtente": prenotazione.indirizzoUtente,
      "EmailUtente": prenotazione.emailUtente,
      "CFUtente": prenotazione.cfUtente,
      "CAP": prenotazione.cap,
      "Impegnativa": prenotazione.impegnativa,
      "NomeASL": prenotazione.nomeASL,
      "Provincia": prenotazione.provincia,
      "CoordASL": prenotazione.coordASL,
      "DataPrenotazione": prenotazione.dataPrenotazione,
      "Descrizione": prenotazione.descrizione,
      "Psicologo": prenotazione.psicologo
    };
  }
}
