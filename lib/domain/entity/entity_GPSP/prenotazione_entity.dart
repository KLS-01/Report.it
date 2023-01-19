import 'package:cloud_firestore/cloud_firestore.dart';

class Prenotazione {
  String? id, idUtente, idOperatore, nomeASL, impegnativa, psicologo;

  String cap,
      provincia,
      nomeUtente,
      cognomeUtente,
      numeroUtente,
      indirizzoUtente,
      emailUtente,
      cfUtente,
      descrizione;
  GeoPoint? coordASL;
  Timestamp? dataPrenotazione;

  Prenotazione(
      {required this.id,
      required this.idUtente,
      required this.nomeUtente,
      required this.cognomeUtente,
      required this.numeroUtente,
      required this.indirizzoUtente,
      required this.emailUtente,
      required this.cfUtente,
      required this.idOperatore,
      required this.cap,
      required this.impegnativa,
      required this.nomeASL,
      required this.provincia,
      required this.coordASL,
      required this.dataPrenotazione,
      required this.descrizione,
      required this.psicologo});

  get getId => id;
  set setId(id) => this.id = id;

  get getIdUtente => idUtente;
  set setIdUtente(idUtente) => this.idUtente = idUtente;

  get getNomeUtente => nomeUtente;
  set setNomeUtente(nomeUtente) => this.nomeUtente = nomeUtente;

  get getcognomeUtente => cognomeUtente;
  set setcognomeUtente(cognomeUtente) => this.cognomeUtente = cognomeUtente;

  get getNumeroUtente => numeroUtente;
  set setNumeroUtente(numeroUtente) => this.numeroUtente = numeroUtente;

  get getIndirizzoUtente => indirizzoUtente;
  set setIndirizzoUtente(indirizzoUtente) =>
      this.indirizzoUtente = indirizzoUtente;

  get getEmailUtente => emailUtente;
  set setEmailUtente(emailUtente) => this.emailUtente = emailUtente;

  get getCfUtente => cfUtente;
  set setCfUtente(cfUtente) => this.cfUtente = cfUtente;

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

  get getDescrizione => descrizione;
  set setDescrizione(descrizione) => this.descrizione = descrizione;

  get getPsicologo => psicologo;
  set setPsicologo(psicologo) => this.psicologo = psicologo;

  @override
  String toString() {
    return 'Denuncia{"ID": $id, "IDUtente": $idUtente, "NomeUtente": $nomeUtente, "CognomeUtente": $cognomeUtente, "NumeroUtente": $numeroUtente, "IDOperatore": $idOperatore, "CAP": $cap, "Impegnativa": $impegnativa, "NomeASL": $nomeASL, "Provincia": $provincia, "CoordASL": $coordASL, "DataPrenotazione": $dataPrenotazione}';
  }
}
