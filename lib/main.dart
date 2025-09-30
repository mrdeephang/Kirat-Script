import 'package:flutter/material.dart';
import 'package:kirat_script/screens/keyboard_screen.dart';
import 'package:provider/provider.dart';
import 'providers/keyboard_provider.dart';
import 'providers/theme_provider.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Limbu Keyboard',
          theme: themeProvider.currentTheme,
          home: const KeyboardScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
