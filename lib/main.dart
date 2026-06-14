import 'package:flutter/material.dart';
import 'package:kirat_script/app/app.dart';
import 'package:kirat_script/app/app_providers.dart';
import 'package:kirat_script/app/ime_app.dart';

void main() {
  runApp(const AppProviders(child: MyApp()));
}

@pragma('vm:entry-point')
void keyboardMain() {
  runApp(const AppProviders(child: IMEApp()));
}
