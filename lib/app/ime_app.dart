import 'package:flutter/material.dart';
import 'package:kirat_script/providers/theme_provider.dart';
import 'package:kirat_script/utils/ime_handler.dart';
import 'package:kirat_script/widgets/kirat_keyboard.dart';
import 'package:provider/provider.dart';

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
              } else {
                ImeHandler.commitText(text);
              }
            },
          ),
        ),
      ),
    );
  }
}
