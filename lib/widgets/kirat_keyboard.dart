import 'package:flutter/material.dart';
import 'package:kirat_script/models/kirat_layout.dart';
import 'package:kirat_script/widgets/keyboard_key.dart';
import 'package:kirat_script/widgets/spacebar.dart';
import 'package:provider/provider.dart';
import '../providers/keyboard_provider.dart';
import '../providers/theme_provider.dart';

class PopupData {
  final Offset position;
  final Size size;
  final String text;
  final Color keyColor;
  final Color textColor;

  PopupData({
    required this.position,
    required this.size,
    required this.text,
    required this.keyColor,
    required this.textColor,
  });
}

class KiratKeyboard extends StatefulWidget {
  final Function(String) onKeyPressed;
  final Function() onBackspaceLongPress;

  const KiratKeyboard({
    super.key,
    required this.onKeyPressed,
    required this.onBackspaceLongPress,
  });

  @override
  State<KiratKeyboard> createState() => _KiratKeyboardState();
}

class _KiratKeyboardState extends State<KiratKeyboard> {
  final ValueNotifier<PopupData?> _popupNotifier = ValueNotifier(null);
  final GlobalKey _keyboardKey = GlobalKey();

  void _showPopup(
    BuildContext keyContext,
    String text,
    Color keyColor,
    Color textColor,
  ) {
    final keyBox = keyContext.findRenderObject() as RenderBox?;
    final keyboardBox =
        _keyboardKey.currentContext?.findRenderObject() as RenderBox?;

    if (keyBox == null || keyboardBox == null) return;

    final offset = keyBox.localToGlobal(Offset.zero, ancestor: keyboardBox);
    _popupNotifier.value = PopupData(
      position: offset,
      size: keyBox.size,
      text: text,
      keyColor: keyColor,
      textColor: textColor,
    );
  }

  void _hidePopup() {
    _popupNotifier.value = null;
  }

  @override
  void dispose() {
    _popupNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Dynamically adjust height for landscape to prevent overflow
    // Standard portrait height adjusted to 340 for a comfortable size
    final double keyboardHeight = isLandscape ? 180.0 : 340.0;
    final double containerHeight =
        keyboardHeight + 70.0; // 70px extra for the popup preview

    return Consumer<KeyboardProvider>(
      builder: (context, keyboardProvider, child) {
        if (keyboardProvider.isBackspacePressed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.onKeyPressed('⌫');
          });
        }

        final currentKeys = keyboardProvider.currentKeys;
        final lastRowIndex = currentKeys.length - 1;

        return Container(
          key: _keyboardKey,
          height: containerHeight,
          color: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: keyboardHeight,
                color: themeProvider.isDarkMode
                    ? Colors.grey[900]
                    : Colors.grey[300],
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
              ),
              ValueListenableBuilder<PopupData?>(
                valueListenable: _popupNotifier,
                builder: (context, popupData, child) {
                  if (popupData == null) return const SizedBox.shrink();

                  return Positioned(
                    left: popupData.position.dx - (popupData.size.width * 0.25),
                    top: popupData.position.dy - popupData.size.height - 10,
                    width: popupData.size.width * 1.5,
                    height: popupData.size.height * 1.8,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: popupData.keyColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          popupData.text,
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w500,
                            color: popupData.textColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
                      onTap: widget.onKeyPressed,
                    )
                  : KeyboardKey(
                      key: ValueKey(
                        'key_${key.primaryChar}_${keyboardProvider.currentLanguage}_${keyboardProvider.isSymbolsMode}_${keyboardProvider.isShiftEnabled}',
                      ),
                      keyData: key,
                      onTap: (text) {
                        if (!key.isSpecial ||
                            key.primaryChar == ' ' ||
                            key.primaryChar == '⌫' ||
                            key.primaryChar == '⏎') {
                          widget.onKeyPressed(text);
                        }
                        keyboardProvider.handleKeyPress(key);
                      },
                      onLongPress: key.primaryChar == '⌫'
                          ? widget.onBackspaceLongPress
                          : null,
                      showPopup: _showPopup,
                      hidePopup: _hidePopup,
                    ),
            ),
        ],
      ),
    );
  }
}
