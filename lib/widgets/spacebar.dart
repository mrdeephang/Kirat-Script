import 'package:flutter/material.dart';
import 'package:kirat_script/models/kirat_layout.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:provider/provider.dart';

class SpaceBarWithLanguage extends StatelessWidget {
  final KiratKey keyData;
  final Function(String) onTap;

  const SpaceBarWithLanguage({
    super.key,
    required this.keyData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<KeyboardProvider>(
      builder: (context, provider, child) {
        return Container(
          margin: const EdgeInsets.all(2),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              onTap: () => onTap(keyData.primaryChar),
              borderRadius: BorderRadius.circular(6),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      keyData.primaryChar,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .transparent, // Make space character invisible
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      provider.getLanguageDisplayName(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
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
