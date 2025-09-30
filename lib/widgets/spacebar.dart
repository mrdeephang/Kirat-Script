import 'package:flutter/material.dart';
import 'package:kirat_script/models/kirat_layout.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:kirat_script/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SpaceBarWithLanguage extends StatelessWidget {
  final KiratKey keyData;
  final Function(String) onTap;

  const SpaceBarWithLanguage({
    super.key,
    required this.keyData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Consumer<KeyboardProvider>(
      builder: (context, keyboardProvider, child) {
        return Container(
          margin: const EdgeInsets.all(2),
          child: Material(
            color: themeProvider.isDarkMode ? Colors.grey[900]! : Colors.white,
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              onTap: () => onTap(keyData.primaryChar),
              borderRadius: BorderRadius.circular(6),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      keyData.primaryChar,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      keyboardProvider.getLanguageDisplayName(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode
                            ? Colors.grey[300]
                            : Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
