import 'package:ai_agent_ollama_llm_app/datas/models/request_model.dart';
import 'package:flutter/foundation.dart';

class ApiConst {
  ApiConst._();

  static const baseUrl = kIsWeb
      ? "http://localhost:11434/api/chat"
      : "http://192.168.1.2:11434/api/chat";
  static const madelName = "gemma4:e2b";
  static const systemMessage = {
    "role": "system",
    "content": "You are a concise assistant.",
  };
  static List<Tools> systemTools = [
    Tools(
      type: "function",
      function: FunctionTools(
        name: "show_warning_dialog",
        description:
            "Display a dialog to the user with a warning title and content message if user is asking about drugs, alcohol",
        parameters: Parameters(
          type: "object",
          properties: Properties(
            title: Title(
              type: "string",
              description: "The title of the warning dialog",
            ),
            content: Content(
              type: "string",
              description: "Dialog content/message",
            ),
          ),
          required: ["title", "content"],
          additionalProperties: false,
        ),
      ),
    ),
  ];
}
