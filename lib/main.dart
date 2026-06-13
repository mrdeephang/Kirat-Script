import 'package:flutter/material.dart';
import 'package:kirat_script/app/app.dart';
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
