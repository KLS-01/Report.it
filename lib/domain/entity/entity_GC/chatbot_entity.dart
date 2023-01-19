class ChatB {
  String domanda;
  String risposta;
  String? id;

  ChatB(this.domanda, this.risposta, {this.id});

  Map<String, dynamic> toMap() {
    return {
      "Domanda": domanda,
      "Risposta": risposta,
    };
  }
}
