import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/categoria_denuncia.dart';
import 'package:report_it/domain/entity/stato_denuncia.dart';
import 'package:report_it/domain/entity/utente_entity.dart';

class Denuncia {
  String? id;
  String? nomeDenunciante,
      cognomeDenunciante,
      indirizzoDenunciante,
      capDenunciante,
      provinciaDenunciante,
      cellulareDenunciante,
      emailDenunciante,
      tipoDocDenunciante,
      numeroDocDenunciante,
      nomeVittima,
      cognomeVittima,
      denunciato,
      descrizione,
      nomeCaserma,
      coordCaserma,
      nomeUff,
      cognomeUff;

  String? scadenzaDocDenunciante, dataDenuncia;
  bool consenso = false, alreadyFiled = false;
  String idUtente;
  String categoriaDenuncia, statoDenuncia;
  //StatoDenuncia statoDenuncia;

  Denuncia({
    required this.id,
    required this.idUtente,
    required this.nomeDenunciante,
    required this.cognomeDenunciante,
    required this.indirizzoDenunciante,
    required this.capDenunciante,
    required this.provinciaDenunciante,
    required this.cellulareDenunciante,
    required this.emailDenunciante,
    required this.tipoDocDenunciante,
    required this.numeroDocDenunciante,
    required this.scadenzaDocDenunciante,
    required this.dataDenuncia,
    required this.categoriaDenuncia,
    required this.nomeVittima,
    required this.denunciato,
    required this.alreadyFiled,
    required this.consenso,
    required this.descrizione,
    required this.statoDenuncia,
    required this.nomeCaserma,
    required this.coordCaserma,
    required this.nomeUff,
    required this.cognomeUff,
  });

  get getId => id;
  set setId(id) => this.id = id;

  get getNomeDenunciante => nomeDenunciante;
  set setNomeDenunciante(nomeDenunciante) =>
      this.nomeDenunciante = nomeDenunciante;

  get getCognomeDenunciante => cognomeDenunciante;
  set setCognomeDenunciante(cognomeDenunciante) =>
      cognomeDenunciante = cognomeDenunciante;

  get getIndirizzoDenunciante => indirizzoDenunciante;
  set setIndirizzoDenunciante(indirizzoDenunciante) =>
      this.indirizzoDenunciante = indirizzoDenunciante;

  get getCapDenunciante => capDenunciante;
  set setCapDenunciante(capDenunciante) => this.capDenunciante = capDenunciante;

  get getProvinciaDenunciante => provinciaDenunciante;
  set setProvinciaDenunciante(provinciaDenunciante) =>
      this.provinciaDenunciante = provinciaDenunciante;

  get getCellulareDenunciante => cellulareDenunciante;
  set setCellulareDenunciante(cellulareDenunciante) =>
      this.cellulareDenunciante = cellulareDenunciante;

  get getEmailDenunciante => emailDenunciante;
  set setEmailDenunciante(emailDenunciante) =>
      this.emailDenunciante = emailDenunciante;

  get getTipoDocDenunciante => tipoDocDenunciante;
  set setTipoDocDenunciante(tipoDocDenunciante) =>
      this.tipoDocDenunciante = tipoDocDenunciante;

  get getNomeVittima => nomeVittima;
  set setNomeVittima(nomeVittima) => this.nomeVittima = nomeVittima;

  get getCognomeVittima => cognomeVittima;
  set setCognomeVittima(cognomeVittima) => this.cognomeVittima = cognomeVittima;

  get getDenunciato => denunciato;
  set setDenunciato(denunciato) => this.denunciato = denunciato;

  get getDescrizione => descrizione;
  set setDescrizione(descrizione) => this.descrizione = descrizione;

  get getNomeCaserma => nomeCaserma;
  set setNomeCaserma(nomeCaserma) => this.nomeCaserma = nomeCaserma;

  get getCoordCaserma => coordCaserma;
  set setCoordCaserma(coordCaserma) => this.coordCaserma = coordCaserma;

  get getNomeUff => nomeUff;
  set setNomeUff(nomeUff) => this.nomeUff = nomeUff;

  get getCognomeUff => cognomeUff;
  set setCognomeUff(cognomeUff) => this.cognomeUff = cognomeUff;

  get getDataDenuncia => dataDenuncia;
  set setDataDenuncia(dataDenuncia) => this.dataDenuncia = dataDenuncia;

  get getAlreadyFiled => alreadyFiled;
  set setAlreadyFiled(alreadyFiled) => this.alreadyFiled = alreadyFiled;

  get getIdUtente => idUtente;

  factory Denuncia.fromJson(Map<String, dynamic> json) {
    return Denuncia(
      id: json["ID"],
      idUtente: json["idUtente"],
      nomeDenunciante: json["nomeDenunciante"],
      cognomeDenunciante: json["cognomeDenunciante"],
      indirizzoDenunciante: json["indirizzoDenunciante"],
      capDenunciante: json["capDenunciante"],
      provinciaDenunciante: json["provinciaDenunciante"],
      cellulareDenunciante: json["cellulareDenunciante"],
      emailDenunciante: json["emailDenunciante"],
      tipoDocDenunciante: json["tipoDocDenunciante"],
      numeroDocDenunciante: json["numeroDocDenunciante"],
      scadenzaDocDenunciante: json["scadenzaDocDenunciante"],
      dataDenuncia: json["dataDenuncia"],
      categoriaDenuncia: json["categoriaDenuncia"],
      nomeVittima: json["nomeVittima"],
      denunciato: json["denunciato"],
      alreadyFiled: json["alreadyFiled"],
      consenso: json["consenso"],
      descrizione: json["descrizione"],
      statoDenuncia: json["statoDenuncia"],
      nomeCaserma: json["nomeCaserma"],
      coordCaserma: json["coordCaserma"],
      nomeUff: json["nomeUff"],
      cognomeUff: json["cognomeUff"],
    );
  }

  factory Denuncia.fromMap(map) {
    return Denuncia(
      id: map["ID"],
      idUtente: map["idUtente"],
      nomeDenunciante: map["nomeDenunciante"],
      cognomeDenunciante: map["cognomeDenunciante"],
      indirizzoDenunciante: map["indirizzoDenunciante"],
      capDenunciante: map["capDenunciante"],
      provinciaDenunciante: map["provinciaDenunciante"],
      cellulareDenunciante: map["cellulareDenunciante"],
      emailDenunciante: map["emailDenunciante"],
      tipoDocDenunciante: map["tipoDocDenunciante"],
      numeroDocDenunciante: map["numeroDocDenunciante"],
      scadenzaDocDenunciante: map["scadenzaDocDenunciante"],
      dataDenuncia: map["dataDenuncia"],
      categoriaDenuncia: map["categoriaDenuncia"],
      nomeVittima: map["nomeVittima"],
      denunciato: map["denunciato"],
      alreadyFiled: map["alreadyFiled"],
      consenso: map["consenso"],
      descrizione: map["descrizione"],
      statoDenuncia: map["statoDenuncia"],
      nomeCaserma: map["nomeCaserma"],
      coordCaserma: map["coordCaserma"],
      nomeUff: map["nomeUff"],
      cognomeUff: map["cognomeUff"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "ID": id,
      "idUtente": idUtente,
      "NomeDenunciante": nomeDenunciante,
      "CognomeDenunciante": cognomeDenunciante,
      "IndirizzoDenunciante": indirizzoDenunciante,
      "CapDenunciante": capDenunciante,
      "ProvinciaDenunciante": provinciaDenunciante,
      "CellulareDenunciante": cellulareDenunciante,
      "EmailDenunciante": emailDenunciante,
      "TipoDocDenunciante": tipoDocDenunciante,
      "NumeroDocDenunciante": numeroDocDenunciante,
      "ScadenzaDocDenunciante": scadenzaDocDenunciante,
      "DataDenuncia": dataDenuncia,
      "CategoriaDenuncia": categoriaDenuncia,
      "NomeVittima": nomeVittima,
      "Denunciato": denunciato,
      "AlreadyFiled": alreadyFiled,
      "Consenso": consenso,
      "Descrizione": descrizione,
      "StatoDenuncia": statoDenuncia,
      "NomeCaserma": nomeCaserma,
      "CoordCaserma": coordCaserma,
      "NomeUff": nomeUff,
      "CognomeUff": cognomeUff,
    };
  }
}
