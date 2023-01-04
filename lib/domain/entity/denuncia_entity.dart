import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/categoria_denuncia.dart';
import 'package:report_it/domain/entity/stato_denuncia.dart';

class Denuncia {
  String? id;
  String nomeDenunciante,
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
      descrizione;

  Timestamp scadenzaDocDenunciante, dataDenuncia;
  GeoPoint? coordCaserma;

  String? nomeCaserma, nomeUff, cognomeUff,idUff;

  bool consenso = false, alreadyFiled = false;
  String idUtente;
  CategoriaDenuncia categoriaDenuncia;
  StatoDenuncia statoDenuncia;
  //StatoDenuncia statoDenuncia;

  Denuncia(
      {required this.id,
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
      required this.cognomeVittima,
      required this.idUff});

  get getId => id;
  set setId(id) => this.id = id;

  get getIdUff => idUff;
  set setIdUff(idUff) =>
      this.idUff = idUff;

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
        idUtente: json["IDUtente"],
        nomeDenunciante: json["NomeDenunciante"],
        cognomeDenunciante: json["CognomeDenunciante"],
        indirizzoDenunciante: json["IndirizzoDenunciante"],
        capDenunciante: json["CapDenunciante"],
        provinciaDenunciante: json["ProvinciaDenunciante"],
        cellulareDenunciante: json["CellulareDenunciante"],
        emailDenunciante: json["EmailDenunciante"],
        tipoDocDenunciante: json["TipoDocDenunciante"],
        numeroDocDenunciante: json["NumeroDocDenunciante"],
        scadenzaDocDenunciante: json["ScadenzaDocDenunciante"],
        dataDenuncia: json["DataDenuncia"],
        categoriaDenuncia:CategoriaDenuncia.values.byName(json["CategoriaDenuncia"]),
        nomeVittima: json["NomeVittima"],
        denunciato: json["Denunciato"],
        alreadyFiled: json["AlreadyFiled"],
        consenso: json["Consenso"],
        descrizione: json["Descrizione"],
        statoDenuncia: StatoDenuncia.values.byName(json["Stato"]),
        nomeCaserma: json["NomeCaserma"],
        coordCaserma: json["CoordCaserma"],
        nomeUff: json["NomeUff"],
        cognomeUff: json["CognomeUff"],
        cognomeVittima: json["CognomeVittima"],
        idUff: json["IDUff"]);
  }

  factory Denuncia.fromMap(map) {
    return Denuncia(
        id: map["ID"],
        idUtente: map["IDUtente"],
        nomeDenunciante: map["NomeDenunciante"],
        cognomeDenunciante: map["CognomeDenunciante"],
        indirizzoDenunciante: map["IndirizzoDenunciante"],
        capDenunciante: map["CapDenunciante"],
        provinciaDenunciante: map["ProvinciaDenunciante"],
        cellulareDenunciante: map["CellulareDenunciante"],
        emailDenunciante: map["EmailDenunciante"],
        tipoDocDenunciante: map["TipoDocDenunciante"],
        numeroDocDenunciante: map["NumeroDocDenunciante"],
        scadenzaDocDenunciante: map["ScadenzaDocDenunciante"],
        dataDenuncia: map["DataDenuncia"],
        categoriaDenuncia: map["CategoriaDenuncia"],
        nomeVittima: map["NomeVittima"],
        denunciato: map["Denunciato"],
        alreadyFiled: map["AlreadyFiled"],
        consenso: map["Consenso"],
        descrizione: map["Descrizione"],
        statoDenuncia: map["Stato"],
        nomeCaserma: map["NomeCaserma"],
        coordCaserma: map["CoordCaserma"],
        nomeUff: map["NomeUff"],
        cognomeUff: map["CognomeUff"],
        cognomeVittima: map["CognomeVittima"],
        idUff: map["IDUff"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "ID": id,
      "IDUtente": idUtente,
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
      "CategoriaDenuncia": categoriaDenuncia.name,
      "NomeVittima": nomeVittima,
      "Denunciato": denunciato,
      "AlreadyFiled": alreadyFiled,
      "Consenso": consenso,
      "Descrizione": descrizione,
      "Stato": statoDenuncia.name,
      "NomeCaserma": nomeCaserma,
      "CoordCaserma": coordCaserma,
      "NomeUff": nomeUff,
      "CognomeUff": cognomeUff,
      "CognomeVittima": cognomeVittima,
      "IDUff": idUff
    };
  }

  @override
  String toString() {
    return 'Denuncia{id: $id, nomeDenunciante: $nomeDenunciante, cognomeDenunciante: $cognomeDenunciante, indirizzoDenunciante: $indirizzoDenunciante, capDenunciante: $capDenunciante, provinciaDenunciante: $provinciaDenunciante, cellulareDenunciante: $cellulareDenunciante, emailDenunciante: $emailDenunciante, tipoDocDenunciante: $tipoDocDenunciante, numeroDocDenunciante: $numeroDocDenunciante, nomeVittima: $nomeVittima, cognomeVittima: $cognomeVittima, denunciato: $denunciato, descrizione: $descrizione, scadenzaDocDenunciante: $scadenzaDocDenunciante, dataDenuncia: $dataDenuncia, coordCaserma: $coordCaserma, nomeCaserma: $nomeCaserma, nomeUff: $nomeUff, cognomeUff: $cognomeUff, consenso: $consenso, alreadyFiled: $alreadyFiled, idUtente: $idUtente, categoriaDenuncia: $categoriaDenuncia, statoDenuncia: $statoDenuncia}';
  }
}
