import 'package:flutter/material.dart';
import 'package:kirat_script/models/kirat_layout.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:kirat_script/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:kirat_script/utils/ime_handler.dart';

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
    ImeHandler.performHapticFeedback();
    ImeHandler.playClickSound();
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

        return Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (_) => _handleTapDown(),
          onPointerUp: (_) => _handleTapUp(),
          onPointerCancel: (_) => _handleTapCancel(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 4.0),
            child: Material(
              color: _isPressed ? pressedColor : baseColor,
              borderRadius: BorderRadius.circular(8),
              elevation: 1,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Text(
                      keyboardProvider.currentLanguage == 'English'
                          ? 'English'
                          : 'Kirat',
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Positioned(
                      bottom: -10, // Positioned slightly below the text
                      child: Container(
                        width: 30,
                        height: 3,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
