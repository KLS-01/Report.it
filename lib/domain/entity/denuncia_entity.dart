import 'package:report_it/domain/entity/categoria_denuncia.dart';
import 'package:report_it/domain/entity/stato_denuncia.dart';

class Denuncia {
  String? id,
      nomeDenunciante,
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

  DateTime? scadenzaDocDenunciante, dataDenuncia;
  bool consenso = false, alreadyFiled = false;
  Utente? utente;
  CategoriaDenuncia categoriaDenuncia;
  StatoDenuncia statoDenuncia;

  Denuncia(
    this.id,
    this.utente,
    this.nomeDenunciante,
    this.cognomeDenunciante,
    this.indirizzoDenunciante,
    this.capDenunciante,
    this.provinciaDenunciante,
    this.cellulareDenunciante,
    this.emailDenunciante,
    this.tipoDocDenunciante,
    this.numeroDocDenunciante,
    this.scadenzaDocDenunciante,
    this.dataDenuncia,
    this.categoriaDenuncia,
    this.nomeVittima,
    this.denunciato,
    this.alreadyFiled,
    this.consenso,
    this.descrizione,
    this.statoDenuncia,
    this.nomeCaserma,
    this.coordCaserma,
    this.nomeUff,
    this.cognomeUff,
  );

  String? get getId => id;
  set setId(String? id) => this.id = id;

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

  factory Denuncia.fromJson(Map<String, dynamic> json) {
    return Denuncia(
      json["ID"],
      json["utente"],
      json["nomeDenunciante"],
      json["cognomeDenunciante"],
      json["indirizzoDenunciante"],
      json["capDenunciante"],
      json["provinciaDenunciante"],
      json["cellulareDenunciante"],
      json["emailDenunciante"],
      json["tipoDocDenunciante"],
      json["numeroDocDenunciante"],
      json["scadenzaDocDenunciante"],
      json["dataDenuncia"],
      json["categoriaDenuncia"],
      json["nomeVittima"],
      json["denunciato"],
      json["alreadyFiled"],
      json["consenso"],
      json["descrizione"],
      json["statoDenuncia"],
      json["nomeCaserma"],
      json["coordCaserma"],
      json["nomeUff"],
      json["cognomeUff"],
    );
  }

  factory Denuncia.fromMap(map) {
    return Denuncia(
      map["ID"],
      map["utente"],
      map["nomeDenunciante"],
      map["cognomeDenunciante"],
      map["indirizzoDenunciante"],
      map["capDenunciante"],
      map["provinciaDenunciante"],
      map["cellulareDenunciante"],
      map["emailDenunciante"],
      map["tipoDocDenunciante"],
      map["numeroDocDenunciante"],
      map["scadenzaDocDenunciante"],
      map["dataDenuncia"],
      map["categoriaDenuncia"],
      map["nomeVittima"],
      map["denunciato"],
      map["alreadyFiled"],
      map["consenso"],
      map["descrizione"],
      map["statoDenuncia"],
      map["nomeCaserma"],
      map["coordCaserma"],
      map["nomeUff"],
      map["cognomeUff"],
    );
  }

  Map<String?, dynamic> toMap() {
    return {
      "ID": id,
      "Utente": utente,
      "nomeDenunciante": nomeDenunciante,
      "cognomeDenunciante": cognomeDenunciante,
      "indirizzoDenunciante": indirizzoDenunciante,
      "capDenunciante": capDenunciante,
      "provinciaDenunciante": provinciaDenunciante,
      "cellulareDenunciante": cellulareDenunciante,
      "emailDenunciante": emailDenunciante,
      "tipoDocDenunciante": tipoDocDenunciante,
      "numeroDocDenunciante": numeroDocDenunciante,
      "scadenzaDocDenunciante": scadenzaDocDenunciante,
      "dataDenuncia": tipoDocDenunciante,
      "categoriaDenuncia": tipoDocDenunciante,
      "nomeVittima": tipoDocDenunciante,
      "denunciato": tipoDocDenunciante,
      "alreadyFiled": tipoDocDenunciante,
      "consenso": consenso,
      "descrizione": descrizione,
      "statoDenuncia": statoDenuncia,
      "nomeCaserma": nomeCaserma,
      "coordCaserma": coordCaserma,
      "nomeUff": nomeUff,
      "cognomeUff": cognomeUff,
    };
  }
}
