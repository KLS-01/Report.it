import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class SPID {
  String? cf;
  String? nome;
  String? luogoNascita;
  DateTime? dataNascita;
  String? sesso;
  String? tipoDocumento;
  String? numeroDocumento;
  String? domicilioFisico;
  String? provinciaNascita;
  DateTime? dataScadenzaDocumento;
  String? numCellulare;
  String? indirizzoEmail;
  String? password;

  get getCf => this.cf;

  set setCf(cf) => this.cf = cf;

  get getNome => this.nome;

  set setNome(nome) => this.nome = nome;

  get getLuogoNascita => this.luogoNascita;

  set setLuogoNascita(luogoNascita) => this.luogoNascita = luogoNascita;

  get getDataNascita => this.dataNascita;

  set setDataNascita(dataNascita) => this.dataNascita = dataNascita;

  get getSesso => this.sesso;

  set setSesso(sesso) => this.sesso = sesso;

  get getTipoDocumento => this.tipoDocumento;

  set setTipoDocumento(tipoDocumento) => this.tipoDocumento = tipoDocumento;

  get getNumeroDocumento => this.numeroDocumento;

  set setNumeroDocumento(numeroDocumento) =>
      this.numeroDocumento = numeroDocumento;

  get getDomicilioFisico => this.domicilioFisico;

  set setDomicilioFisico(domicilioFisico) =>
      this.domicilioFisico = domicilioFisico;

  get getProvinciaNascita => this.provinciaNascita;

  set setProvinciaNascita(provinciaNascita) =>
      this.provinciaNascita = provinciaNascita;

  get getDataScadenzaDocumento => this.dataScadenzaDocumento;

  set setDataScadenzaDocumento(dataScadenzaDocumento) =>
      this.dataScadenzaDocumento = dataScadenzaDocumento;

  get getNumCellulare => this.numCellulare;

  set setNumCellulare(numCellulare) => this.numCellulare = numCellulare;

  get getIndirizzoEmail => this.indirizzoEmail;

  set setIndirizzoEmail(indirizzoEmail) => this.indirizzoEmail = indirizzoEmail;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  SPID(
    this.cf,
    this.nome,
    this.luogoNascita,
    this.dataNascita,
    this.sesso,
    this.tipoDocumento,
    this.numeroDocumento,
    this.domicilioFisico,
    this.provinciaNascita,
    this.dataScadenzaDocumento,
    this.numCellulare,
    this.indirizzoEmail,
    this.password,
  );

  factory SPID.fromJson(Map<String, dynamic> json) {
    return SPID(
        json["CF"],
        json["Nome"],
        json["Luogo di Nascita"],
        DateTime(
          SPID.prendiAnno(json["Data di Nascita"]),
          SPID.prendiMese(json["Data di Nascita"]),
          SPID.prendiGiorno(json["Data di Nascita"]),
        ),
        json["Sesso"],
        json["TipoDocumento"],
        json["Numero Documento"],
        json["Domicilio fisico"],
        json["Provincia di nascita"],
        DateTime(
          SPID.prendiAnno(json["Data Scadenza Documento"]),
          SPID.prendiMese(json["Data Scadenza Documento"]),
          SPID.prendiGiorno(json["Data Scadenza Documento"]),
        ),
        json["Cellulare"].toString(),
        json["Email"],
        json["Password"].toString());
  }

  factory SPID.fromMap(map) {
    return SPID(
        map["CF"],
        map["Nome"],
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

  Map<String?, dynamic> toMap() {
    return {
      "CF": cf,
      "Nome": nome,
      "Luogo di Nascita": luogoNascita,
      "Data di Nascita": dataNascita,
      "Sesso": sesso,
      "TipoDocumento": tipoDocumento,
      "Numero Documento": numeroDocumento,
      "Domicilio fisico": domicilioFisico,
      "Provincia di nascita": provinciaNascita,
      "Data Scadenza Documento": dataScadenzaDocumento,
      "Cellulare": numCellulare,
      "Email": indirizzoEmail,
      "Password": password
    };
  }

  static int prendiAnno(String data) {
    int anno = int.parse(data.substring(6));

    return anno;
  }

  static int prendiMese(String data) {
    int anno = int.parse(data.substring(3, 5));

    return anno;
  }

  static int prendiGiorno(String data) {
    int anno = int.parse(data.substring(0, 2));

    return anno;
  }
}
