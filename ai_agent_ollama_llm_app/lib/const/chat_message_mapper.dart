import '../datas/models/request_model.dart';
import '../datas/models/response_model.dart';

Messages toMessage(Message message) {
  return Messages(
    role: message.role,
    content: message.content
  );
}