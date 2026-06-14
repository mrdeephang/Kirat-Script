import 'package:flutter_test/flutter_test.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:kirat_script/models/kirat_layout.dart';

void main() {
  group('KeyboardProvider Unit Tests', () {
    late KeyboardProvider provider;

    setUp(() {
      provider = KeyboardProvider();
    });

    test('Initial state is correct', () {
      expect(provider.currentLanguage, 'kirat');
      expect(provider.isSymbolsMode, isFalse);
      expect(provider.isShiftEnabled, isFalse);
      expect(provider.isBackspacePressed, isFalse);
    });

    test('toggleLanguage switches between english and kirat', () {
      expect(provider.currentLanguage, 'kirat');
      provider.handleKeyPress(
        const KiratKey(primaryChar: '🌐', isSpecial: true),
      );
      expect(provider.currentLanguage, 'english');
      provider.handleKeyPress(
        const KiratKey(primaryChar: '🌐', isSpecial: true),
      );
      expect(provider.currentLanguage, 'kirat');
    });

    test('toggleShift enables and disables shift mode', () {
      expect(provider.isShiftEnabled, isFalse);
      provider.handleKeyPress(
        const KiratKey(primaryChar: '⇧', isSpecial: true),
      );
      expect(provider.isShiftEnabled, isTrue);
      provider.handleKeyPress(
        const KiratKey(primaryChar: '⇧', isSpecial: true),
      );
      expect(provider.isShiftEnabled, isFalse);
    });

    test('Shift mode disables after typing a regular character', () {
      provider.handleKeyPress(
        const KiratKey(primaryChar: '⇧', isSpecial: true),
      );
      expect(provider.isShiftEnabled, isTrue);
      // Type a normal character
      provider.handleKeyPress(
        const KiratKey(primaryChar: 'A', isSpecial: false),
      );
      expect(provider.isShiftEnabled, isFalse);
    });
  });
}
