import 'package:flutter/material.dart';
import 'package:kirat_script/screens/keyboard_screen.dart';
import 'package:provider/provider.dart';
import 'providers/keyboard_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => KeyboardProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirat Keyboard',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const KeyboardScreen(),
    );
  }
}