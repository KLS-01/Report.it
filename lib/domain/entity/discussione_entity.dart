class Commento {
  String creatore;
  DateTime dataCreazione;
  int punteggio;
  String testo;

  Commento(this.creatore, this.dataCreazione, this.punteggio, this.testo);

  factory Commento.fromJson(Map<String, dynamic> json) {
    return Commento(json["Creatore"], json["DataOra"].toDate(),
        json["Punteggio"], json["Testo"]);
  }

  factory Commento.fromMap(map) {
    return Commento(map["Creatore"], map["DataOra"].toDate(), map["Punteggio"],
        map["Testo"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "Creatore": creatore,
      "DataOra": dataCreazione,
      "Punteggio": punteggio,
      "Testo": testo,
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
  List<Commento?> commenti = List.empty(growable: true);

  Discussione(this.categoria, this.dataCreazione, this.idCreatore,
      this.punteggio, this.testo, this.titolo);

  factory Discussione.fromJson(Map<String, dynamic> json) {
    var u = Discussione(
      json["Categoria"],
      json["DataOraCreazione"].toDate(),
      json["IDCreatore"],
      json["Punteggio"],
      json["Testo"],
      json["Titolo"],
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
    };
  }

  void setID(String id) {
    this.id = id;
  }
}
