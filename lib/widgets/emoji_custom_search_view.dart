import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:kirat_script/providers/keyboard_provider.dart';
import 'package:kirat_script/providers/theme_provider.dart';

class EmojiCustomSearchView extends StatefulWidget {
  final Config config;
  final EmojiViewState state;
  final VoidCallback showEmojiView;
  final KeyboardProvider keyboardProvider;
  final ThemeProvider themeProvider;
  final Function(String) onEmojiSelectedDirectly;
  final Widget keyboardRows;

  const EmojiCustomSearchView({
    super.key,
    required this.config,
    required this.state,
    required this.showEmojiView,
    required this.keyboardProvider,
    required this.themeProvider,
    required this.onEmojiSelectedDirectly,
    required this.keyboardRows,
  });

  @override
  State<EmojiCustomSearchView> createState() => _EmojiCustomSearchViewState();
}

class _EmojiCustomSearchViewState extends State<EmojiCustomSearchView> {
  List<Emoji> _searchResults = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.keyboardProvider.setEmojiSearchMode(true);
      widget.keyboardProvider.setLanguage('english');
    });
    widget.keyboardProvider.addListener(_onSearchQueryChanged);
  }

  @override
  void dispose() {
    widget.keyboardProvider.removeListener(_onSearchQueryChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Safely turn off search mode if the widget is unmounted (e.g. user closed emoji picker entirely)
      // Check if provider is still valid, though provider outlives this widget.
      widget.keyboardProvider.setEmojiSearchMode(false);
    });
    super.dispose();
  }

  void _onSearchQueryChanged() async {
    final query = widget.keyboardProvider.emojiSearchQuery;
    if (query.isNotEmpty) {
      final utils = EmojiPickerUtils();
      final results = await utils.searchEmoji(query, widget.state.categoryEmoji);
      if (mounted) {
        setState(() {
          _searchResults = results;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _searchResults = [];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeProvider.isDarkMode;
    
    return Column(
      children: [
        // Top bar with close button and search query text
        Container(
          height: 40,
          color: isDark ? Colors.grey[850] : Colors.grey[200],
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
                onPressed: widget.showEmojiView, // Return to standard emoji grid
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: widget.keyboardProvider.emojiSearchQuery.isEmpty
                        ? [
                            TextSpan(
                              text: '| ',
                              style: TextStyle(
                                color: isDark ? Colors.blue : Colors.blueAccent,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: "Search emojis...",
                              style: const TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ]
                        : [
                            TextSpan(
                              text: widget.keyboardProvider.emojiSearchQuery,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: '|',
                              style: TextStyle(
                                color: isDark ? Colors.blue : Colors.blueAccent,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Search Results Row
        Container(
          height: 50,
          color: isDark ? Colors.grey[900] : Colors.grey[100],
          child: _searchResults.isEmpty
              ? Center(
                  child: Text(
                    "No results",
                    style: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final emoji = _searchResults[index];
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        // User selected an emoji! Send it directly to the host app.
                        // Bypassing the category selection to avoid index 0 caching bugs.
                        widget.onEmojiSelectedDirectly(emoji.emoji);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.center,
                        child: Text(
                          emoji.emoji,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    );
                  },
                ),
        ),

        // The Keyboard Keys
        Expanded(
          child: widget.keyboardRows,
        ),
      ],
    );
  }
}
