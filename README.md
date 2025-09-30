# Kirat Script

A custom in-app keyboard implementation for Android and iOS supporting both Kirat script and English QWERTY layouts.

![Image](https://github.com/user-attachments/assets/bd59f19f-a87a-484b-b937-8e9166a27526)
![Image](https://github.com/user-attachments/assets/d96de7eb-26e0-4762-a417-627c81a3548c)

## Features

- **Dual Language Support**: Switch between Kirat script and English QWERTY
- **Always-Accessible Numbers**: Number row permanently visible at the top
- **Dedicated Symbols Mode**: Toggle between letters and symbols
- **Smart Layout**:
  - Kirat numbers (᥇-᥆) in Kirat mode
  - Standard numbers (0-9) in English mode
  - Comprehensive symbol sets for both languages
- **Visual Indicators**: Clear language display above spacebar
- **Responsive Design**: Optimized for both Android and iOS

## Layouts

### Kirat Mode

- Top row: Kirat numbers ᥇-᥆
- Main area: Kirat consonants and vowels
- Symbols: Kirat-specific punctuation and common symbols

### English Mode

- Top row: Standard numbers 0-9
- Main area: QWERTY keyboard layout
- Symbols: Comprehensive symbol set

## Controls

- **🌐 Globe Icon**: Toggle between Kirat and English
- **!#1/ABC**: Toggle between letters and symbols
- **⇧ Shift**: Capitalize letters (English) / access additional symbols
- **⌫ Backspace**: Delete characters
- **⏎ Enter**: Insert new line

## Usage

The keyboard integrates as an in-app input method. Users can:

1. Tap the globe icon to switch languages
2. Use the symbols toggle for special characters
3. Access numbers directly from the top row
4. See current language displayed above spacebar

## Technical Details

Built with Flutter using:

- Provider for state management
- Custom keyboard widget
- Platform-agnostic design
- Unicode-compliant Kirat character support

## Support

Supports Android and iOS devices with Flutter compatibility.
