import 'package:flutter/material.dart';
import 'package:kirat_script/models/kirat_layout.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:kirat_script/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class KeyboardKey extends StatelessWidget {
  final KiratKey keyData;
  final Function(String) onTap;
  final Function()? onLongPress;

  const KeyboardKey({
    super.key,
    required this.keyData,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Consumer<KeyboardProvider>(
      builder: (context, provider, child) {
        final displayText = provider.getKeyText(keyData);

        // Pre-calculate colors to avoid repeated calculations
        final bool isDarkMode = themeProvider.isDarkMode;
        final bool isShiftEnabled = provider.isShiftEnabled;
        final bool isBackspacePressed = provider.isBackspacePressed;

        Color keyColor = isDarkMode ? Colors.grey[700]! : Colors.white;
        Color textColor = isDarkMode ? Colors.white : Colors.black;

        if (keyData.isSpecial) {
          textColor = Colors.white;

          if (keyData.primaryChar == '⇧' && isShiftEnabled) {
            keyColor = Colors.blue[700]!;
          }

          if (keyData.primaryChar == '⌫' && isBackspacePressed) {
            keyColor = Colors.red[700]!;
          }
        }

        return Container(
          margin: const EdgeInsets.all(2),
          child: Material(
            color: keyColor,
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              onTap: () => onTap(displayText),
              onLongPress: keyData.primaryChar == '⌫' ? onLongPress : null,
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
