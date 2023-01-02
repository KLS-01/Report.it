import 'dart:convert';

import 'spid_entity.dart';

class Utente {
  String cf;
  String id;
  SPID? spid;

  get getCf => this.cf;

  set setCf(cf) => this.cf = cf;

  get getSpid => this.spid;


  Utente(this.cf, this.id);

  factory Utente.fromJson(Map<String, dynamic> json) {
    return Utente(json["CF"], json["id"]);
  }

  factory Utente.fromMap(map) {
    return Utente(map['CF'], map["id"]);

  }

  Map<String, dynamic> toMap() {
    return {
      "CF": cf,
      "id": id,
    };
  }

  setSpid(SPID value) {
    this.spid = value;
  }

}