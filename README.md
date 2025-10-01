# Kirat Script

A custom in-app keyboard implementation for Android and iOS supporting both Kirat script and English QWERTY layouts.

## Screenshots

<img src="https://github.com/user-attachments/assets/96d0ac2e-649d-4d26-a482-ff81106b4225" alt="Screenshot 1" width="300"/>
<img src="https://github.com/user-attachments/assets/427d1ef0-4ceb-4b0b-a177-3f63f1e36eb7" alt="Screenshot 2" width="300"/>
<img src="https://github.com/user-attachments/assets/416ac6ad-017c-4d15-ae7b-9041b2b164b5" alt="Screenshot 3" width="300"/>
<img src="https://github.com/user-attachments/assets/3f6de3fd-6481-4459-a4eb-b4a2f4ac037a" alt="Screenshot 4" width="300"/>
<img src="https://github.com/user-attachments/assets/f2d46e6f-4668-42c9-9c01-6bb304c2fd9c" alt="Screenshot 5" width="300"/>



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

## Future Enhancement

- make it usable as default keyboard through settings

## Author

Copyright © 2025 Deephang Thegim. All rights reserved.
