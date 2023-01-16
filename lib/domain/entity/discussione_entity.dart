import 'package:report_it/domain/entity/operatoreCUP_entity.dart';
import 'package:report_it/domain/entity/spid_entity.dart';
import 'package:report_it/domain/entity/uffPolGiud_entity.dart';

class Commento {
  String? id;
  String creatore;
  DateTime dataCreazione;
  String testo;
  String? nome;
  String? cognome;
  String tipoutente;

  Commento(this.creatore, this.dataCreazione, this.testo, this.tipoutente);

  factory Commento.fromJson(Map<String, dynamic> json) {
    var c = Commento(json["Creatore"], json["DataOra"].toDate(), json["Testo"],
        json["TipoUtente"]);

    c.id = json["ID"];

    return c;
  }

  factory Commento.fromMap(map) {
    var c = Commento(map["Creatore"], map["DataOra"].toDate(), map["Testo"],
        map["TipoUtente"]);

    c.id = map["ID"];

    return c;
  }

  Map<String, dynamic> toMap() {
    return {
      "Creatore": creatore,
      "DataOra": dataCreazione,
      "Testo": testo,
      "TipoUtente": tipoutente,
    };
  }
}

class Discussione {
  String categoria;
  DateTime dataCreazione;
  String? id;
  String idCreatore;
  int punteggio;
  String titolo;
  String testo;
  String stato;
  List<Commento?> commenti = List.empty(growable: true);
  String? pathImmagine;
  String? nome;
  String? cognome;
  List<dynamic> listaSostegno = List.empty(growable: true);
  String tipoUtente;

  Discussione(
      this.categoria,
      this.dataCreazione,
      this.idCreatore,
      this.punteggio,
      this.testo,
      this.titolo,
      this.stato,
      this.listaSostegno,
      this.tipoUtente,
      {this.pathImmagine});

  factory Discussione.fromJson(Map<String, dynamic> json) {
    var u = Discussione(
      json["Categoria"],
      json["DataOraCreazione"].toDate(),
      json["IDCreatore"],
      json["Punteggio"],
      json["Testo"],
      json["Titolo"],
      json["Stato"],
      json["ListaCommenti"],
      json["TipoUtente"],
      pathImmagine: json["pathImmagine"],
    );
    u.id = json["ID"];

    return u;
  }

  factory Discussione.fromMap(map) {
    var u = Discussione(
      map["Categoria"],
      map["DataOraCreazione"].toDate(),
      map["IDCreatore"],
      map["Punteggio"],
      map["Testo"],
      map["Titolo"],
      map["Stato"],
      map["ListaCommenti"],
      map["TipoUtente"],
      pathImmagine: map["pathImmagine"],
    );
    u.id = map["ID"];

    return u;
  }

  Map<String, dynamic> toMap() {
    return {
      "Categoria": categoria,
      "DataOraCreazione": dataCreazione,
      "IDCreatore": idCreatore,
      "Punteggio": punteggio,
      "Testo": testo,
      "Titolo": titolo,
      "Stato": stato,
      "pathImmagine": pathImmagine,
      "ListaCommenti": listaSostegno,
      "TipoUtente": tipoUtente,
    };
  }

  void setID(String id) {
    this.id = id;
  }

  void setpathImmagine(String path) {
    this.pathImmagine = path;
  }
}
