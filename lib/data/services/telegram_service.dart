import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:js' as js;

class TelegramService {

  /// Function to initialize the Telegram WebApp.
  Map<String, dynamic>? initTelegramWebApp() {
    final result = js.context.callMethod('initTelegramWebApp');
    debugPrint("InitTelegramWebApp result: $result");
    if (result != null) {
      // Convert JsObject to JSON string and then parse it to a Map
      String jsonString = js.context['JSON'].callMethod('stringify', [result]);
      return jsonDecode(jsonString);
    }
    return null;
  }

  /// Function to send data back to Telegram
  static void sendTelegramData(String data) {
    js.context.callMethod('sendTelegramData', [data]);
  }

  /// Function to control the MainButton in Telegram
  static void setMainButton(String text, bool isVisible) {
    js.context.callMethod('setMainButton', [text, isVisible]);
  }
}