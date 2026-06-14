import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kirat_script/models/kirat_layout.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:kirat_script/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:kirat_script/utils/ime_handler.dart';

class KeyboardKey extends StatefulWidget {
  final KiratKey keyData;
  final Function(String) onTap;
  final Function(BuildContext, String, Color, Color)? showPopup;
  final Function()? hidePopup;

  const KeyboardKey({
    super.key,
    required this.keyData,
    required this.onTap,
    this.showPopup,
    this.hidePopup,
  });

  @override
  State<KeyboardKey> createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  bool _isPressed = false;
  Timer? _longPressDelayTimer;

  void _handleTapDown(String displayText, Color keyColor, Color textColor, KeyboardProvider provider) {
    ImeHandler.performHapticFeedback();
    ImeHandler.playClickSound();
    setState(() => _isPressed = true);
    if (!widget.keyData.isSpecial && widget.keyData.primaryChar != ' ') {
      widget.showPopup?.call(context, displayText, keyColor, textColor);
    }

    if (widget.keyData.primaryChar == '⌫') {
      _longPressDelayTimer?.cancel();
      _longPressDelayTimer = Timer(const Duration(milliseconds: 400), () {
        provider.startBackspace();
      });
    }
  }

  void _handleTapUp(String displayText, KeyboardProvider provider) {
    setState(() => _isPressed = false);
    widget.hidePopup?.call();

    if (widget.keyData.primaryChar == '⌫') {
      _longPressDelayTimer?.cancel();
      if (provider.isBackspacePressed) {
        provider.stopBackspace();
      } else {
        widget.onTap(displayText);
      }
    } else {
      widget.onTap(displayText);
    }
  }

  void _handleTapCancel(KeyboardProvider provider) {
    setState(() => _isPressed = false);
    widget.hidePopup?.call();

    if (widget.keyData.primaryChar == '⌫') {
      _longPressDelayTimer?.cancel();
      if (provider.isBackspacePressed) {
        provider.stopBackspace();
      }
    }
  }

  @override
  void dispose() {
    _longPressDelayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Consumer<KeyboardProvider>(
      builder: (context, provider, child) {
        final displayText = provider.getKeyText(widget.keyData);

        final bool isDarkMode = themeProvider.isDarkMode;
        final bool isShiftEnabled = provider.isShiftEnabled;
        final bool isBackspacePressed = provider.isBackspacePressed;

        Color keyColor = isDarkMode ? Colors.grey[800]! : Colors.white;
        Color textColor = isDarkMode ? Colors.white : Colors.black;

        if (widget.keyData.isSpecial) {
          keyColor = isDarkMode ? Colors.grey[700]! : Colors.grey[400]!;
          textColor = isDarkMode ? Colors.white : Colors.black;

          if (widget.keyData.primaryChar == '⇧' && isShiftEnabled) {
            keyColor = isDarkMode ? Colors.blue[700]! : Colors.blue[200]!;
            textColor = isDarkMode ? Colors.white : Colors.blue[900]!;
          }

          if (widget.keyData.primaryChar == '⌫' && isBackspacePressed) {
            keyColor = isDarkMode ? Colors.red[700]! : Colors.red[200]!;
            textColor = isDarkMode ? Colors.white : Colors.red[900]!;
          }
        }

        return Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (_) =>
              _handleTapDown(displayText, keyColor, textColor, provider),
          onPointerUp: (_) => _handleTapUp(displayText, provider),
          onPointerCancel: (_) => _handleTapCancel(provider),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2.5,
              vertical: 4.0,
            ),
            child: Material(
              color: _isPressed
                  ? (isDarkMode ? Colors.grey[600] : Colors.grey[300])
                  : keyColor,
              borderRadius: BorderRadius.circular(8),
              elevation: 1,
              child: Center(
                child: Text(
                  displayText,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
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
