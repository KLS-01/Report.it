import 'package:cloud_firestore/cloud_firestore.dart';

class Prenotazione {
  String? id, idUtente, idOperatore, nomeASL, impegnativa;

  String cap, provincia;
  GeoPoint? coordASL;
  Timestamp? dataPrenotazione;

  Prenotazione(
      {required this.id,
      required this.idUtente,
      required this.idOperatore,
      required this.cap,
      required this.impegnativa,
      required this.nomeASL,
      required this.provincia,
      required this.coordASL,
      required this.dataPrenotazione});

  get getId => id;
  set setId(id) => this.id = id;

  get getIdUtente => idUtente;
  set setIdUtente(idUtente) => this.idUtente = idUtente;

  get getIdOperatore => idOperatore;
  set setIdOperatore(idOperatore) => this.idOperatore = idOperatore;

  get getNomeASL => nomeASL;
  set setNomeASL(nomeASL) => this.nomeASL = nomeASL;

  get getCap => cap;
  set setCap(cap) => this.cap = cap;

  get getProvincia => provincia;
  set setProvincia(provincia) => this.provincia = provincia;

  get getCoordASL => coordASL;
  set setCoordASL(coordASL) => this.coordASL = coordASL;

  get getDataPrenotazione => dataPrenotazione;
  set setDataPrenotazione(dataPrenotazione) =>
      this.dataPrenotazione = dataPrenotazione;

  get getImpegnativa => impegnativa;
  set setImpegnativa(impegnativa) => this.impegnativa = impegnativa;

  factory Prenotazione.fromJson(Map<String, dynamic> json) {
    return Prenotazione(
        id: json["ID"],
        idUtente: json["IDUtente"],
        idOperatore: json["IDOperatore"],
        cap: json["CAP"],
        impegnativa: json["Impegnativa"],
        nomeASL: json["NomeASL"],
        provincia: json["Provincia"],
        coordASL: json["CoordASL"],
        dataPrenotazione: json["DataPrenotazione"]);
  }

  factory Prenotazione.fromMap(map) {
    return Prenotazione(
        id: map["ID"],
        idUtente: map["IDUtente"],
        idOperatore: map["IDOperatore"],
        cap: map["CAP"],
        impegnativa: map["Impegnativa"],
        nomeASL: map["NomeASL"],
        provincia: map["Provincia"],
        coordASL: map["CoordASL"],
        dataPrenotazione: map["DataPrenotazione"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "ID": id,
      "IDUtente": idUtente,
      "IDOperatore": idOperatore,
      "CAP": cap,
      "Impegnativa": impegnativa,
      "NomeASL": nomeASL,
      "Provincia": provincia,
      "CoordASL": coordASL,
      "DataPrenotazione": dataPrenotazione,
    };
  }

  @override
  String toString() {
    return 'Denuncia{"ID": $id, "IDUtente": $idUtente, "IDOperatore": $idOperatore, "CAP": $cap, "Impegnativa": $impegnativa, "NomeASL": $nomeASL, "Provincia": $provincia, "CoordASL": $coordASL, "DataPrenotazione": $dataPrenotazione}';
  }
}
