import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';

class OperatoreCUP extends SuperUtente {
  String nome;
  String cognome;
  String password;
  String email;
  String asl;

  get getId => this.id;

  set setId(id) => this.id = id;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getAsl => this.asl;

  set setAsl(asl) => this.asl = asl;

  OperatoreCUP(id, this.password, this.email, this.asl, this.nome, this.cognome)
      : super(id, TipoUtente.values.byName("OperatoreCup"));

  factory OperatoreCUP.fromJson(Map<String, dynamic> json) {
    return OperatoreCUP(
      json["ID"],
      json["Password"],
      json["Email"],
      json["ASL"],
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
      "Nome": nome,
      "Cognome": cognome,
    };
  }
}
