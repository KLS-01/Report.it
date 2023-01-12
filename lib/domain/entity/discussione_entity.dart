class Commento {
  String? id;
  String creatore;
  DateTime dataCreazione;
  int punteggio;
  String testo;

  Commento(this.creatore, this.dataCreazione, this.punteggio, this.testo);

  factory Commento.fromJson(Map<String, dynamic> json) {
    var c = Commento(json["Creatore"], json["DataOra"].toDate(),
        json["Punteggio"], json["Testo"]);

    c.id = json["ID"];

    return c;
  }

  factory Commento.fromMap(map) {
    var c = Commento(map["Creatore"], map["DataOra"].toDate(), map["Punteggio"],
        map["Testo"]);

    c.id = map["ID"];

    return c;
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
  String stato;
  List<Commento?> commenti = List.empty(growable: true);
  String? pathImmagine;

  Discussione(this.categoria, this.dataCreazione, this.idCreatore,
      this.punteggio, this.testo, this.titolo, this.stato,
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
        pathImmagine: json["pathImmagine"]);
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
    };
  }

  void setID(String id) {
    this.id = id;
  }

  void setpathImmagine(String path) {
    this.pathImmagine = path;
  }
}
