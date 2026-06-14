import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kirat_script/models/kirat_layout.dart';

class KeyboardProvider with ChangeNotifier {
  bool _isShiftEnabled = false;
  bool _isSymbolsMode = false;
  bool _isEmojiMode = false;
  String _currentLanguage = 'kirat';
  bool _isBackspacePressed = false;
  Timer? _backspaceTimer;
  String _emojiSearchQuery = '';
  bool _isEmojiSearchMode = false;

  bool get isShiftEnabled => _isShiftEnabled;
  bool get isSymbolsMode => _isSymbolsMode;
  bool get isEmojiMode => _isEmojiMode;
  String get currentLanguage => _currentLanguage;
  bool get isBackspacePressed => _isBackspacePressed;
  String get emojiSearchQuery => _emojiSearchQuery;
  bool get isEmojiSearchMode => _isEmojiSearchMode;

  List<List<KiratKey>> get currentKeys {
    if (_currentLanguage == 'english') {
      return _isSymbolsMode
          ? KiratKeyboardLayout.englishSymbolsLayout
          : KiratKeyboardLayout.englishLayout;
    } else {
      return _isSymbolsMode
          ? KiratKeyboardLayout.kiratSymbolsLayout
          : KiratKeyboardLayout.kiratLayout;
    }
  }

  void handleKeyPress(KiratKey key) {
    if (key.primaryChar == '⇧') {
      toggleShift();
    } else if (key.primaryChar == '🌐') {
      toggleLanguage();
    } else if (key.primaryChar == '😀') {
      toggleEmojiMode();
    } else if (key.primaryChar == '!#1' ||
        key.primaryChar == 'ᤁᤂᤃ' ||
        key.primaryChar == 'ABC' ||
        key.primaryChar == '!#᥇') {
      toggleSymbolsMode();
    } else if (!key.isSpecial) {
      // shift resets after typing a character
      if (_isShiftEnabled) {
        _isShiftEnabled = false;
        notifyListeners();
      }
    }
  }

  // Fast delete functionality
  void startBackspace() {
    _isBackspacePressed = true;
    notifyListeners();

    // Start continuous deletion after initial press
    _backspaceTimer = Timer.periodic(Duration(milliseconds: 150), (timer) {
      if (_isBackspacePressed) {
        // Notify to delete one character
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void stopBackspace() {
    _isBackspacePressed = false;
    _backspaceTimer?.cancel();
    _backspaceTimer = null;
    notifyListeners();
  }

  void toggleShift() {
    _isShiftEnabled = !_isShiftEnabled;
    notifyListeners();
  }

  void toggleLanguage() {
    _currentLanguage = _currentLanguage == 'kirat' ? 'english' : 'kirat';
    _isShiftEnabled = false;
    _isSymbolsMode = false;
    notifyListeners();
  }

  void setLanguage(String lang) {
    if (_currentLanguage != lang) {
      _currentLanguage = lang;
      _isShiftEnabled = false;
      _isSymbolsMode = false;
      notifyListeners();
    }
  }

  void toggleSymbolsMode() {
    _isSymbolsMode = !_isSymbolsMode;
    _isShiftEnabled = false;
    notifyListeners();
  }

  void toggleEmojiMode() {
    _isEmojiMode = !_isEmojiMode;
    _isShiftEnabled = false;
    _isSymbolsMode = false;
    if (!_isEmojiMode) {
      _isEmojiSearchMode = false;
      _emojiSearchQuery = '';
    }
    notifyListeners();
  }

  void setEmojiSearchMode(bool enabled) {
    _isEmojiSearchMode = enabled;
    if (!enabled) {
      _emojiSearchQuery = '';
    }
    notifyListeners();
  }

  void updateEmojiSearchQuery(String text) {
    _emojiSearchQuery += text;
    notifyListeners();
  }

  void backspaceEmojiSearchQuery() {
    if (_emojiSearchQuery.isNotEmpty) {
      _emojiSearchQuery = _emojiSearchQuery.substring(
        0,
        _emojiSearchQuery.length - 1,
      );
      notifyListeners();
    }
  }

  String getKeyText(KiratKey key) {
    // For Kirat language, shift shows small consonants
    if (_currentLanguage == 'kirat' &&
        _isShiftEnabled &&
        key.shiftChar != null) {
      return key.shiftChar!;
    }
    // For English language, shift shows uppercase
    else if (_currentLanguage == 'english' &&
        _isShiftEnabled &&
        key.shiftChar != null) {
      return key.shiftChar!;
    }
    return key.primaryChar;
  }

  String getLanguageDisplayName() {
    return _currentLanguage == 'kirat' ? 'Kirat' : 'English';
  }

  @override
  void dispose() {
    _backspaceTimer?.cancel();
    super.dispose();
  }
}
