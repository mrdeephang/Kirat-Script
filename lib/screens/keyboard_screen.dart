import 'package:flutter/material.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:kirat_script/providers/theme_provider.dart';
import 'package:kirat_script/widgets/kirat_keyboard.dart';
import 'package:provider/provider.dart';

class KeyboardScreen extends StatefulWidget {
  const KeyboardScreen({super.key});

  @override
  State<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Disable system keyboard by preventing focus
    _focusNode.unfocus();
  }

  void _insertText(String text) {
    final currentText = _textController.text;
    var selection = _textController.selection;

    if (selection.start < 0 || selection.end < 0) {
      selection = TextSelection.collapsed(offset: currentText.length);
    }

    final newText = currentText.replaceRange(
      selection.start,
      selection.end,
      text,
    );

    _textController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selection.start + text.length),
    );
  }

  void _deleteText() {
    final currentText = _textController.text;
    var selection = _textController.selection;

    if (selection.start < 0 || selection.end < 0) {
      selection = TextSelection.collapsed(offset: currentText.length);
    }

    if (selection.start == 0 && selection.end == 0) return;

    final startIndex = selection.start == selection.end
        ? selection.start - 1
        : selection.start;

    final newText = currentText.replaceRange(startIndex, selection.end, '');

    _textController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: startIndex),
    );
  }

  void _handleKeyPress(String text) {
    if (text == '⇧' ||
        text == '🌐' ||
        text == '!#1' ||
        text == 'ABC' ||
        text == '!#᥇' ||
        text == 'ᤁᤂᤃ') {
      return;
    }

    if (text == '⌫') {
      _deleteText();
    } else if (text == '⏎') {
      _insertText('\n');
    } else {
      _insertText(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    final isLandscapeSmall = size.width > size.height && size.height < 500;

    return Scaffold(
      appBar: isLandscapeSmall
          ? null
          : AppBar(
              title: Consumer<KeyboardProvider>(
                builder: (context, keyboardProvider, child) {
                  return const Text(
                    'Kirat Keyboard',
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              actions: [
                IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Colors.white,
                  ),
                  onPressed: () => themeProvider.toggleTheme(),
                  tooltip: 'Toggle theme',
                ),
              ],
            ),
      body: GestureDetector(
        onTap: () {
          // system keyboard won't open on typing
          _focusNode.unfocus();
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(isLandscapeSmall ? 4.0 : 16.0),
                  child: TextField(
                    minLines: 1,
                    maxLines: null,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      letterSpacing: 1.2,
                    ),
                    controller: _textController,
                    focusNode: _focusNode,
                    readOnly: true,
                    showCursor: true,
                    decoration: InputDecoration(
                      hintText: 'Tap below to type with Kirat keyboard...',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: themeProvider.isDarkMode
                            ? Colors.grey[400]
                            : Colors.grey[600],
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      filled: true,
                      fillColor: themeProvider.isDarkMode
                          ? Colors.grey[800]
                          : Colors.white,
                    ),
                  ),
                ),
              ),
              KiratKeyboard(onKeyPressed: _handleKeyPress),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
