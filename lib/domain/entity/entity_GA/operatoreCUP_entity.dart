import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';

class OperatoreCUP extends SuperUtente {
  String password;
  String email;
  String asl;
  GeoPoint coordASL;
  String capASL;
  String cittaASL;
  String indirizzoASL;
  String provinciaASL;
  String nome;
  String cognome;

  get getId => this.id;
  set setId(id) => this.id = id;

  get getPassword => this.password;
  set setPassword(password) => this.password = password;

  get getEmail => this.email;
  set setEmail(email) => this.email = email;

  get getAsl => this.asl;
  set setAsl(asl) => this.asl = asl;

  get getCoordAsl => this.coordASL;
  set setCoordAsl(coordASL) => this.coordASL = coordASL;

  OperatoreCUP(
    id,
    this.password,
    this.email,
    this.asl,
    this.coordASL,
    this.capASL,
    this.cittaASL,
    this.indirizzoASL,
    this.provinciaASL,
    this.nome,
    this.cognome,
  ) : super(id, TipoUtente.values.byName("OperatoreCup"));

  factory OperatoreCUP.fromJson(Map<String, dynamic> json) {
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

  factory OperatoreCUP.fromMap(map) {
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

  Map<String?, dynamic> toMap() {
    return {
      "ID": id,
      "Password": password,
      "Email": email,
      "ASL": asl,
      "CoordASL": coordASL,
      "ProvinciaASL": provinciaASL,
      "CapASL": capASL,
      "CittaASL": cittaASL,
      "IndirizzoASL": indirizzoASL,
      "Nome": nome,
      "Cognome": cognome,
    };
  }
}
