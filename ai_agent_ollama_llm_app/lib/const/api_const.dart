import 'package:flutter/foundation.dart';

class ApiConst {
  ApiConst._();

  static const baseUrl = kIsWeb
      ? "http://localhost:11434/api/chat"
      : "http://192.168.1.7:11434/api/chat";
  static const madelName = "gemma4:e2b";
  static const systemMessage = {
    "role": "system",
    "content": "You are a concise assistant.",
  };
}
