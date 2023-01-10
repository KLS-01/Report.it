import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';

class OperatoreCUP extends SuperUtente {
  String password;
  String email;
  String asl;
  String provincia;
  GeoPoint coordASL;

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

  get getProvincia => this.provincia;
  set setProvincia(provincia) => this.provincia = provincia;

  OperatoreCUP(
      id, this.password, this.email, this.asl, this.coordASL, this.provincia)
      : super(id, TipoUtente.values.byName("OperatoreCup"));

  factory OperatoreCUP.fromJson(Map<String, dynamic> json) {
    return OperatoreCUP(json["ID"], json["Password"], json["Email"],
        json["ASL"], json["CoordASL"], json["Provincia"]);
  }

  factory OperatoreCUP.fromMap(map) {
    return OperatoreCUP(map["ID"], map["Password"], map["Email"], map["ASL"],
        map["CoordASL"], map["Provincia"]);
  }

  Map<String?, dynamic> toMap() {
    return {
      "ID": id,
      "Password": password,
      "Email": email,
      "ASL": asl,
      "CoordASL": coordASL,
      "Provincia": provincia
    };
  }
}
