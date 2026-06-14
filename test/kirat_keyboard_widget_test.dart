import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:kirat_script/providers/theme_provider.dart';
import 'package:kirat_script/widgets/kirat_keyboard.dart';
import 'package:kirat_script/widgets/keyboard_key.dart';
import 'package:kirat_script/widgets/spacebar.dart';

void main() {
  Widget createKeyboardApp(Function(String) onKeyPressed) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KeyboardProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: KiratKeyboard(onKeyPressed: onKeyPressed),
        ),
      ),
    );
  }

  testWidgets('KiratKeyboard renders keys and triggers onKeyPressed', (WidgetTester tester) async {
    String pressedKey = '';
    
    await tester.pumpWidget(createKeyboardApp((key) {
      pressedKey = key;
    }));

    // The keyboard should render a number of KeyboardKey widgets.
    expect(find.byType(KeyboardKey), findsWidgets);
    expect(find.byType(SpaceBarWithLanguage), findsOneWidget);

    // Tap on the 'Q' key or equivalent based on layout.
    // The default is English layout. Let's find a text key 'q' or 'w'.
    final qKey = find.text('q');
    if (qKey.evaluate().isNotEmpty) {
      await tester.tap(qKey);
      await tester.pump();
      expect(pressedKey, 'q');
    }

    // Tap the spacebar
    final spaceBar = find.byType(SpaceBarWithLanguage);
    await tester.tap(spaceBar);
    await tester.pump();
    expect(pressedKey, ' ');
  });
}
