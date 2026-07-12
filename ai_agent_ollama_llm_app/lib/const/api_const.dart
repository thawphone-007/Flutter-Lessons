import 'package:flutter/foundation.dart';

import '../datas/models/request_model.dart';

class ApiConst {
  ApiConst._();

  static const baseUrl = kIsWeb
      ? "http://localhost:11434/api/chat"
      : "http://192.168.1.4:11434/api/chat";
  static const madelName = "gemma4:e2b";
  static const binancePriceUrl = "https://api.binance.com/api/v3/ticker/price";
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
          properties: {
            "title": {
              "type": "string",
              "description": "The title of the warning dialog",
            },
            "content": {
              "type": "string",
              "description": "Dialog content/message",
            },
          },
          required: ["title", "content"],
          additionalProperties: false,
        ),
      ),
    ),
    Tools(
      type: "function",
      function: FunctionTools(
        name: "get_binance_price",
        description:
            "Get the latest cryptocurrency price from Binance by trading pair symbol, for example BTCUSDT, ETHUSDT, or BNBUSDT",
        parameters: Parameters(
          type: "object",
          properties: {
            "symbol": {
              "type": "string",
              "description":
                  "Binance trading pair symbol in uppercase, for example BTCUSDT, ETHUSDT, SOLUSDT.",
            },
          },
          required: ["symbol"],
          additionalProperties: false,
        ),
      ),
    ),
  ];
}
