import 'package:flutter/material.dart';
import 'package:kirat_script/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Kirat Lipi Keyboard', home: MainPage());
  }
}
