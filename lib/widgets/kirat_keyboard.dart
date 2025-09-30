import 'package:flutter/material.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:kirat_script/widgets/keyboard_key.dart';
import 'package:kirat_script/widgets/spacebar.dart';
import 'package:provider/provider.dart';

class KiratKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const KiratKeyboard({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<KeyboardProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 300,
          color: Colors.grey[300],
          child: Column(
            children: [
              for (int i = 0; i < provider.currentKeys.length; i++)
                Expanded(
                  child: Row(
                    children: [
                      for (final key in provider.currentKeys[i])
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
                                    provider.handleKeyPress(key);
                                  },
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
