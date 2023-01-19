import 'package:report_it/domain/entity/adapter.dart';
import 'package:report_it/domain/entity/entity_GC/chatbot_entity.dart';

class AdapterChatBot implements Adapter {
  @override
  fromJson(Map<String, dynamic> json) {
    var c = ChatB(json["Domanda"], json["Risposta"]);
    return c;
  }

  @override
  fromMap(map) {
    var c = ChatB(map["Creatore"], map["Risposta"]);
    return c;
  }

  @override
  toMap(dynamic chatB) {
    chatB = chatB as ChatB;
    return {
      "Domanda": chatB.domanda,
      "Risposta": chatB.risposta,
    };
  }
}
