class ChatB {
  String domanda;
  String risposta;
  String? id;

  ChatB(this.domanda, this.risposta, {this.id});

  factory ChatB.fromJson(Map<String, dynamic> json) {
    var c = ChatB(json["Domanda"], json["Risposta"]);
    return c;
  }

  factory ChatB.fromMap(map) {
    var c = ChatB(map["Creatore"], map["Risposta"]);

    return c;
  }

  Map<String, dynamic> toMap() {
    return {
      "Domanda": domanda,
      "Risposta": risposta,
    };
  }
}
