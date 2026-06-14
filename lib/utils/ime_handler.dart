import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImeHandler {
  static const MethodChannel _channel = MethodChannel('kirat_keyboard/ime');

  static Future<void> commitText(String text) async {
    try {
      await _channel.invokeMethod('commitText', {'text': text});
    } on PlatformException catch (e) {
      debugPrint("Failed to commit text: '${e.message}'.");
    }
  }

  static Future<void> sendBackspace() async {
    try {
      await _channel.invokeMethod('sendBackspace');
    } on PlatformException catch (e) {
      debugPrint("Failed to send backspace: '${e.message}'.");
    }
  }

  static Future<void> deleteSurroundingText(
    int beforeLength,
    int afterLength,
  ) async {
    try {
      await _channel.invokeMethod('deleteSurroundingText', {
        'beforeLength': beforeLength,
        'afterLength': afterLength,
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to delete text: '${e.message}'.");
    }
  }

  static Future<void> sendEnter() async {
    try {
      await _channel.invokeMethod('sendEnter');
    } on PlatformException catch (e) {
      debugPrint("Failed to send enter: '${e.message}'.");
    }
  }
}
