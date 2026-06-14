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

  void _handleTapDown(
    String displayText,
    Color keyColor,
    Color textColor,
    KeyboardProvider provider,
  ) {
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

        final size = MediaQuery.of(context).size;
        final isLandscapeSmall = size.width > size.height && size.height < 500;

        final double vPadding = isLandscapeSmall ? 2.0 : 4.0;
        final double hPadding = isLandscapeSmall ? 1.5 : 2.5;
        final double fSize = isLandscapeSmall ? 18.0 : 22.0;
        final double iSize = isLandscapeSmall ? 18.0 : 22.0;

        return Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (_) =>
              _handleTapDown(displayText, keyColor, textColor, provider),
          onPointerUp: (_) => _handleTapUp(displayText, provider),
          onPointerCancel: (_) => _handleTapCancel(provider),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
            child: Material(
              color: _isPressed
                  ? (isDarkMode ? Colors.grey[600] : Colors.grey[300])
                  : keyColor,
              borderRadius: BorderRadius.circular(8),
              elevation: 1,
              child: Center(
                child: () {
                  if (widget.keyData.primaryChar == '⇧') {
                    return ShiftIcon(
                      color: textColor,
                      isFilled: isShiftEnabled,
                      size: iSize,
                    );
                  } else if (widget.keyData.primaryChar == '⌫') {
                    return Icon(
                      Icons.backspace_outlined,
                      color: textColor,
                      size: iSize,
                    );
                  } else if (widget.keyData.primaryChar == '🌐') {
                    return Icon(Icons.language, color: textColor, size: iSize);
                  } else if (widget.keyData.primaryChar == '⏎') {
                    return Icon(
                      Icons.keyboard_return,
                      color: textColor,
                      size: iSize,
                    );
                  }
                  return Text(
                    displayText,
                    style: TextStyle(
                      fontSize: fSize,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  );
                }(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ShiftIcon extends StatelessWidget {
  final Color color;
  final bool isFilled;
  final double size;

  const ShiftIcon({
    super.key,
    required this.color,
    required this.isFilled,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: ShiftPainter(color: color, isFilled: isFilled),
      ),
    );
  }
}

class ShiftPainter extends CustomPainter {
  final Color color;
  final bool isFilled;

  ShiftPainter({required this.color, required this.isFilled});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (isFilled) {
      paint.style = PaintingStyle.fill;
    } else {
      paint.style = PaintingStyle.stroke;
    }

    final w = size.width;
    final h = size.height;

    // Draw the arrow polygon
    final path = Path()
      ..moveTo(w / 2, h * 0.1) // Tip
      ..lineTo(w * 0.95, h * 0.5) // Right tip corner
      ..lineTo(w * 0.68, h * 0.5) // Right shoulder
      ..lineTo(w * 0.68, h * 0.9) // Right bottom
      ..lineTo(w * 0.32, h * 0.9) // Left bottom
      ..lineTo(w * 0.32, h * 0.5) // Left shoulder
      ..lineTo(w * 0.05, h * 0.5) // Left tip corner
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ShiftPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.isFilled != isFilled;
  }
}
