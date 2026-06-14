import 'package:flutter/material.dart';
import 'package:kirat_script/models/kirat_layout.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:kirat_script/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class SpaceBarWithLanguage extends StatefulWidget {
  final KiratKey keyData;
  final Function(String) onTap;

  const SpaceBarWithLanguage({
    super.key,
    required this.keyData,
    required this.onTap,
  });

  @override
  State<SpaceBarWithLanguage> createState() => _SpaceBarWithLanguageState();
}

class _SpaceBarWithLanguageState extends State<SpaceBarWithLanguage> {
  bool _isPressed = false;

  void _handleTapDown() {
    HapticFeedback.lightImpact();
    SystemSound.play(SystemSoundType.click);
    setState(() => _isPressed = true);
  }

  void _handleTapUp() {
    setState(() => _isPressed = false);
    widget.onTap(widget.keyData.primaryChar);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Consumer<KeyboardProvider>(
      builder: (context, keyboardProvider, child) {
        final isDarkMode = themeProvider.isDarkMode;
        final baseColor = isDarkMode ? Colors.grey[800]! : Colors.white;
        final pressedColor = isDarkMode ? Colors.grey[600]! : Colors.grey[300]!;

        return Container(
          margin: const EdgeInsets.all(2),
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (_) => _handleTapDown(),
            onPointerUp: (_) => _handleTapUp(),
            onPointerCancel: (_) => _handleTapCancel(),
            child: Material(
              color: _isPressed ? pressedColor : baseColor,
              borderRadius: BorderRadius.circular(6),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      widget.keyData.primaryChar,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      keyboardProvider.getLanguageDisplayName(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
