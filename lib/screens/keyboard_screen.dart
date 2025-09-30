import 'package:flutter/material.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:provider/provider.dart';

class KeyboardScreen extends StatefulWidget {
  const KeyboardScreen({super.key});

  @override
  State<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

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

  void _handleKeyPress(String text) {
    // Don't process toggle keys
    if (text == '⇧' || text == '🌐') {
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
    return Scaffold(
      appBar: AppBar(
        title: Consumer<KeyboardProvider>(
          builder: (context, provider, child) {
            return Row(
              children: [
                const Text('kirat Keyboard'),
                const SizedBox(width: 10),
                Chip(
                  label: Text(
                    provider.currentLanguage == 'kirat' ? 'ᤁᤃᤅ' : 'ABC',
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: provider.currentLanguage == 'kirat'
                      ? Colors.green
                      : Colors.orange,
                ),
              ],
            );
          },
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Text input area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                autofocus: true,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText:
                      'Type here... (Tap 🌐 to switch between kirat and English)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          // The keyboard
          kiratKeyboard(onKeyPressed: _handleKeyPress),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  kiratKeyboard({required void Function(String text) onKeyPressed}) {}
}
