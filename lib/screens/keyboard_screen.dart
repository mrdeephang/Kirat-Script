import 'dart:async';
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
  Timer? _fastDeleteTimer;

  void _insertText(String text) {
    final currentText = _textController.text;
    final selection = _textController.selection;

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
    final selection = _textController.selection;

    if (selection.start == 0) return;

    final newText = currentText.replaceRange(
      selection.start - 1,
      selection.start,
      '',
    );

    _textController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selection.start - 1),
    );
  }

  void _startFastDelete() {
    // Initial delete
    _deleteText();

    // Start continuous deletion
    _fastDeleteTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_textController.text.isNotEmpty) {
        _deleteText();
      } else {
        timer.cancel();
      }
    });
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

    return Scaffold(
      appBar: AppBar(
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
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                minLines: 1,
                maxLines: 3,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  letterSpacing: 1.2,
                ),
                controller: _textController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Type here...',
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
          // The keyboard
          KiratKeyboard(
            onKeyPressed: _handleKeyPress,
            onBackspaceLongPress: _startFastDelete,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    _fastDeleteTimer?.cancel();
    super.dispose();
  }
}
