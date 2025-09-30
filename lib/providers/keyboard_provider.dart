import 'package:flutter/foundation.dart';
import 'package:kirat_script/models/kirat_layout.dart';

class KeyboardProvider with ChangeNotifier {
  bool _isShiftEnabled = false;
  bool _isSymbolsMode = false;
  String _currentLanguage = 'Kirat'; // 'Kirat' or 'english'

  bool get isShiftEnabled => _isShiftEnabled;
  bool get isSymbolsMode => _isSymbolsMode;
  String get currentLanguage => _currentLanguage;

  List<List<KiratKey>> get currentKeys {
    if (_currentLanguage == 'english') {
      return _isSymbolsMode
          ? KiratKeyboardLayout.englishSymbolsLayout
          : KiratKeyboardLayout.englishLayout;
    } else {
      return _isSymbolsMode
          ? KiratKeyboardLayout.KiratSymbolsLayout
          : KiratKeyboardLayout.kiratLayout;
    }
  }

  void handleKeyPress(KiratKey key) {
    if (key.primaryChar == '⇧') {
      toggleShift();
    } else if (key.primaryChar == '🌐') {
      toggleLanguage();
    } else if (key.primaryChar == '!#1' || key.primaryChar == 'ABC') {
      toggleSymbolsMode();
    } else if (!key.isSpecial) {
      // Reset shift after typing a character
      if (_isShiftEnabled) {
        _isShiftEnabled = false;
        notifyListeners();
      }
    }
  }

  void toggleShift() {
    _isShiftEnabled = !_isShiftEnabled;
    notifyListeners();
  }

  void toggleLanguage() {
    _currentLanguage = _currentLanguage == 'Kirat' ? 'english' : 'Kirat';
    _isShiftEnabled = false;
    _isSymbolsMode = false;
    notifyListeners();
  }

  void toggleSymbolsMode() {
    _isSymbolsMode = !_isSymbolsMode;
    _isShiftEnabled = false;
    notifyListeners();
  }

  String getKeyText(KiratKey key) {
    return key.primaryChar;
  }

  String getLanguageDisplayName() {
    return _currentLanguage == 'Kirat' ? 'Kirat' : 'English';
  }
}
