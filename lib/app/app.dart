import 'package:flutter/material.dart';
import 'package:kirat_script/providers/theme_provider.dart';
import 'package:kirat_script/screens/keyboard_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Kirat Script',
          theme: themeProvider.currentTheme,
          home: const KeyboardScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
