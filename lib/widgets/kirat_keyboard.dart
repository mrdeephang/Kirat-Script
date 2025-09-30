import 'package:flutter/material.dart';
import 'package:kirat_script/easyconst/colors.dart';
import 'package:kirat_script/widgets/keyboard_key.dart';
import 'package:kirat_script/widgets/spacebar.dart';
import 'package:provider/provider.dart';
import '../providers/keyboard_provider.dart';
import '../providers/theme_provider.dart';

class KiratKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  final Function() onBackspaceLongPress;

  const KiratKeyboard({
    super.key,
    required this.onKeyPressed,
    required this.onBackspaceLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Consumer<KeyboardProvider>(
      builder: (context, keyboardProvider, child) {
        if (keyboardProvider.isBackspacePressed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onKeyPressed('⌫');
          });
        }

        return Container(
          height: 300,
          color: themeProvider.isDarkMode ? darkColor : Colors.grey[300],
          child: Column(
            children: [
              for (int i = 0; i < keyboardProvider.currentKeys.length; i++)
                Expanded(
                  child: Row(
                    children: [
                      for (final key in keyboardProvider.currentKeys[i])
                        Expanded(
                          flex: (key.width * 10).toInt(),
                          child: i == 5 && key.primaryChar == ' '
                              ? SpaceBarWithLanguage(
                                  keyData: key,
                                  onTap: onKeyPressed,
                                )
                              : KeyboardKey(
                                  keyData: key,
                                  onTap: (text) {
                                    if (!key.isSpecial ||
                                        key.primaryChar == ' ' ||
                                        key.primaryChar == '⌫' ||
                                        key.primaryChar == '⏎') {
                                      onKeyPressed(text);
                                    }
                                    keyboardProvider.handleKeyPress(key);
                                  },
                                  onLongPress: key.primaryChar == '⌫'
                                      ? onBackspaceLongPress
                                      : null,
                                ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
