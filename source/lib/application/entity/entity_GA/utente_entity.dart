import 'package:report_it/application/entity/entity_GA/super_utente.dart';
import 'package:report_it/application/entity/entity_GA/tipo_utente.dart';

import 'spid_entity.dart';

class Utente extends SuperUtente {
  String cf;
  SPID? spid;

  get getCf => this.cf;

  set setCf(cf) => this.cf = cf;

  get getSpid => this.spid;

  Utente(this.cf, id) : super(id, TipoUtente.values.byName("Utente"));

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
