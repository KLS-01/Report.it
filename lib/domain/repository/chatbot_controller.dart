import 'package:report_it/data/models/chatbot_dao.dart';
import 'package:report_it/domain/entity/entity_GC/chatbot_entity.dart';

class ChatBotController {
  Future<List<ChatB?>> retrieveAll() {
    return ChatBotDao().RetrieveAll();
  }
}
