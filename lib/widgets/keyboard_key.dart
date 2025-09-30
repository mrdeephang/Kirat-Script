import 'package:flutter/material.dart';
import 'package:kirat_script/models/kirat_layout.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:provider/provider.dart';

class KeyboardKey extends StatelessWidget {
  final KiratKey keyData;
  final Function(String) onTap;

  const KeyboardKey({super.key, required this.keyData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<KeyboardProvider>(
      builder: (context, provider, child) {
        final displayText = provider.getKeyText(keyData);

        Color keyColor = Colors.white;
        Color textColor = Colors.black;

        if (keyData.isSpecial) {
          keyColor = Colors.blue;
          textColor = Colors.white;

          if (keyData.primaryChar == '⇧' && provider.isShiftEnabled) {
            keyColor = Colors.blue[700]!;
          }

          if ((keyData.primaryChar == '!#1' || keyData.primaryChar == 'ABC') &&
              provider.isSymbolsMode) {
            keyColor = Colors.purple;
          }

          if (keyData.primaryChar == '🌐') {
            keyColor = provider.currentLanguage == 'kirat'
                ? Colors.green
                : Colors.orange;
          }
        }

        return Container(
          margin: const EdgeInsets.all(2),
          child: Material(
            color: keyColor,
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              onTap: () => onTap(displayText),
              borderRadius: BorderRadius.circular(6),
              child: Center(
                child: Text(
                  displayText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
