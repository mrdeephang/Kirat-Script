import 'package:flutter/services.dart';

class KeyboardService {
  static final MethodChannel _channel = MethodChannel('kirat_keyboard');

  // Insert text at cursor position
  static Future<void> insertText(String text) async {
    try {
      await _channel.invokeMethod('insertText', {'text': text});
    } on PlatformException catch (e) {
      print('Failed to insert text: ${e.message}');
    }
  }

  // Delete text
  static Future<void> deleteText() async {
    try {
      await _channel.invokeMethod('deleteText');
    } on PlatformException catch (e) {
      print('Failed to delete text: ${e.message}');
    }
  }

  // Switch to system keyboard
  static Future<void> switchToSystemKeyboard() async {
    try {
      await _channel.invokeMethod('switchToSystemKeyboard');
    } on PlatformException catch (e) {
      print('Failed to switch keyboard: ${e.message}');
    }
  }
}
