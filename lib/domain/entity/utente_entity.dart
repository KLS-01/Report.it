import 'SPID_entity.dart';

class Utente {
  String cf;
  SPID? spid;

  get getCf => this.cf;

  set setCf(cf) => this.cf = cf;

  get getSpid => this.spid;

  set setSpid(spid) => this.spid = spid;

  Utente(this.cf);

  factory Utente.fromJson(Map<String, dynamic> json) {
    return Utente(json["cf"]);
  }

  factory Utente.fromMap(map) {
    return Utente(map['cf']);
  }

  Map<String, dynamic> toMap() {
    return {
      cf: "cf",
    };
  }
}
