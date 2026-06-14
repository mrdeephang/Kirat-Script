import 'package:flutter/material.dart';
import 'package:kirat_script/models/kirat_layout.dart';
import 'package:kirat_script/widgets/keyboard_key.dart';
import 'package:kirat_script/widgets/spacebar.dart';
import 'package:provider/provider.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../providers/keyboard_provider.dart';
import '../providers/theme_provider.dart';
import 'emoji_custom_search_view.dart';

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

  const KiratKeyboard({super.key, required this.onKeyPressed});

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
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    final double keyboardHeight = (isLandscape && size.height < 500)
        ? 180.0
        : 340.0;

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
          height: keyboardHeight,
          color: themeProvider.isDarkMode ? Colors.grey[900] : Colors.grey[300],
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: keyboardProvider.isEmojiMode
                      ? _buildEmojiPicker(keyboardProvider, themeProvider)
                      : SizedBox(
                          width: double.infinity,
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
                      onTap: (text) {
                        if (keyboardProvider.isEmojiSearchMode) {
                          keyboardProvider.updateEmojiSearchQuery(text);
                        } else {
                          widget.onKeyPressed(text);
                        }
                      },
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
                          if (keyboardProvider.isEmojiSearchMode) {
                            if (key.primaryChar == '⌫') {
                              keyboardProvider.backspaceEmojiSearchQuery();
                            } else if (key.primaryChar != '⏎') {
                              keyboardProvider.updateEmojiSearchQuery(text);
                            }
                          } else {
                            widget.onKeyPressed(text);
                          }
                        }
                        keyboardProvider.handleKeyPress(key);
                      },
                      showPopup: _showPopup,
                      hidePopup: _hidePopup,
                    ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmojiPicker(
    KeyboardProvider keyboardProvider,
    ThemeProvider themeProvider,
  ) {
    return Column(
      children: [
        Expanded(
          child: EmojiPicker(
            onEmojiSelected: (category, emoji) {
              widget.onKeyPressed(emoji.emoji);
            },
            config: Config(
              emojiViewConfig: EmojiViewConfig(
                backgroundColor: themeProvider.isDarkMode
                    ? Colors.grey[900]!
                    : Colors.grey[300]!,
                columns: 8,
              ),
              categoryViewConfig: CategoryViewConfig(
                backgroundColor: themeProvider.isDarkMode ? Colors.grey[900]! : Colors.grey[300]!,
                extraTab: CategoryExtraTab.SEARCH,
              ),
              searchViewConfig: SearchViewConfig(
                backgroundColor: themeProvider.isDarkMode ? Colors.grey[900]! : Colors.grey[300]!,
                buttonIconColor: themeProvider.isDarkMode ? Colors.white54 : Colors.black54,
                customSearchView: (config, state, showEmojiView) {
                  return EmojiCustomSearchView(
                    config: config,
                    state: state,
                    showEmojiView: showEmojiView,
                    keyboardProvider: keyboardProvider,
                    themeProvider: themeProvider,
                    onEmojiSelectedDirectly: widget.onKeyPressed,
                    keyboardRows: Column(
                      children: [
                        for (int i = 0; i < keyboardProvider.currentKeys.length; i++)
                          _buildKeyboardRow(
                            i,
                            keyboardProvider.currentKeys[i],
                            keyboardProvider.currentKeys.length - 1,
                            keyboardProvider,
                          ),
                      ],
                    ),
                  );
                },
              ),
              bottomActionBarConfig: const BottomActionBarConfig(
                enabled: false,
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 15,
              child: KeyboardKey(
                key: const ValueKey('emoji_abc'),
                keyData: const KiratKey(
                  primaryChar: 'ABC',
                  isSpecial: true,
                  width: 1.5,
                ),
                onTap: (_) => keyboardProvider.toggleEmojiMode(),
                showPopup: _showPopup,
                hidePopup: _hidePopup,
              ),
            ),
            const Spacer(flex: 70),
            Expanded(
              flex: 15,
              child: KeyboardKey(
                key: const ValueKey('emoji_backspace'),
                keyData: const KiratKey(
                  primaryChar: '⌫',
                  isSpecial: true,
                  width: 1.5,
                ),
                onTap: (_) => widget.onKeyPressed('⌫'),
                showPopup: _showPopup,
                hidePopup: _hidePopup,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
