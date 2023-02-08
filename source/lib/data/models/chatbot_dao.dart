import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/application/entity/entity_GC/adapter_chatbot.dart';
import 'package:report_it/application/entity/entity_GC/chatbot_entity.dart';

class ChatBotDao {
  FirebaseFirestore database = FirebaseFirestore.instance;

  Future<List<ChatB?>> RetrieveAll() async {
    var ref = database.collection("ChatBot");

    List<ChatB> lista = List.empty(growable: true);

    var c = await ref.get().then((value) {
      for (var d in value.docs) {
        ChatB chat = AdapterChatBot().fromJson(d.data());

        chat.id = d.id;
        lista.add(chat);
      }

      return lista;
    });

    return c;
  }
}
