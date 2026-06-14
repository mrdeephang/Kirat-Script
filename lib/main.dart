import 'package:flutter/material.dart';
import 'package:kirat_script/app/app.dart';
import 'package:provider/provider.dart';
import 'providers/keyboard_provider.dart';
import 'providers/theme_provider.dart';
import 'ime_handler.dart';
import 'widgets/kirat_keyboard.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => KeyboardProvider()),
      ],
      child: MyApp(),
    ),
  );
}

@pragma('vm:entry-point')
void keyboardMain() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => KeyboardProvider()),
      ],
      child: const IMEApp(),
    ),
  );
}

class IMEApp extends StatelessWidget {
  const IMEApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.currentTheme.copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: Colors.transparent,
      ),
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: KiratKeyboard(
            onKeyPressed: (text) {
              if (text == '⌫') {
                ImeHandler.sendBackspace();
              } else if (text == '⏎') {
                ImeHandler.sendEnter();
              } else if (text == '⇧' ||
                  text == '🌐' ||
                  text == '!#1' ||
                  text == 'ABC' ||
                  text == '!#᥇' ||
                  text == 'ᤁᤂᤃ') {
              } else {
                ImeHandler.commitText(text);
              }
            },
            onBackspaceLongPress: () {
              ImeHandler.sendBackspace();
            },
          ),
        ),
      ),
    );
  }
}
