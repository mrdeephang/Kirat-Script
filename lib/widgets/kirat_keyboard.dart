import 'package:flutter/material.dart';
import 'package:kirat_script/easyconst/colors.dart';
import 'package:kirat_script/models/kirat_layout.dart';
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
        // Only rebuild when absolutely necessary
        if (keyboardProvider.isBackspacePressed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onKeyPressed('⌫');
          });
        }

        final currentKeys = keyboardProvider.currentKeys;
        final lastRowIndex = currentKeys.length - 1;

        return Container(
          height: 300,
          color: themeProvider.isDarkMode ? darkColor : Colors.grey[300],
          child: Column(
            children: [
              for (int i = 0; i < currentKeys.length; i++)
                _buildKeyboardRow(
                  i,
                  currentKeys[i],
                  lastRowIndex,
                  keyboardProvider,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKeyboardRow(
    int rowIndex,
    List<KiratKey> rowKeys,
    int lastRowIndex,
    KeyboardProvider keyboardProvider,
  ) {
    return Expanded(
      child: Row(
        children: [
          for (final key in rowKeys)
            Expanded(
              flex: (key.width * 10).toInt(),
              child: rowIndex == lastRowIndex && key.primaryChar == ' '
                  ? SpaceBarWithLanguage(
                      key: ValueKey(
                        'spacebar_${keyboardProvider.currentLanguage}_${keyboardProvider.isSymbolsMode}',
                      ),
                      keyData: key,
                      onTap: onKeyPressed,
                    )
                  : KeyboardKey(
                      key: ValueKey(
                        'key_${key.primaryChar}_${keyboardProvider.currentLanguage}_${keyboardProvider.isSymbolsMode}',
                      ),
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
    );
  }
}
