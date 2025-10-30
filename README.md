# Kirat Script

> **Custom in-app keyboard for Kirat script** — Seamless bilingual typing with English QWERTY support

---

## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/96d0ac2e-649d-4d26-a482-ff81106b4225" alt="Kirat Keyboard" width="250"/>
  <img src="https://github.com/user-attachments/assets/427d1ef0-4ceb-4b0b-a177-3f63f1e36eb7" alt="English Keyboard" width="250"/>
  <img src="https://github.com/user-attachments/assets/416ac6ad-017c-4d15-ae7b-9041b2b164b5" alt="Kirat Symbols" width="250"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/3f6de3fd-6481-4459-a4eb-b4a2f4ac037a" alt="English Symbols" width="250"/>
  <img src="https://github.com/user-attachments/assets/f2d46e6f-4668-42c9-9c01-6bb304c2fd9c" alt="Language Toggle" width="250"/>
</p>

---

## Features

- **Dual language support** — Toggle between Kirat script and English QWERTY
- **Persistent number row** — Always-visible numbers at the top
- **Dedicated symbols mode** — Quick access to special characters
- **Smart layout system**:
  - Kirat numbers (᥇-᥆) in Kirat mode
  - Standard numbers (0-9) in English mode
  - Comprehensive symbol sets for both languages
- Visual language indicator** — Current mode displayed above spacebar -**Cross-platform\*\* — Optimized for both Android and iOS

---

## Keyboard Layouts

### Kirat Mode

- **Top row**: Kirat numbers ᥇-᥏
- **Main area**: Kirat consonants and vowels
- **Symbols**: Kirat-specific punctuation and common symbols

### English Mode

- **Top row**: Standard numbers 0-9
- **Main area**: QWERTY layout
- **Symbols**: Comprehensive symbol set

---

## Controls

| Button          | Function                                       |
| --------------- | ---------------------------------------------- |
| **Globe**    | Toggle between Kirat and English               |
| **!#1/ABC**     | Switch between letters and symbols             |
| **⇧ Shift**     | Capitalize letters / access additional symbols |
| **⌫ Backspace** | Delete characters                              |
| **⏎ Enter**     | Insert new line                                |

---

## Folder Structure

```
lib/
├── easyconst/
│   └── colors.dart              # Color constants
├── models/
│   └── kirat_layout.dart        # Keyboard layout data
├── providers/
│   ├── keyboard_provider.dart   # Keyboard state management
│   └── theme_provider.dart      # Theme state management
├── screens/
│   └── keyboard_screen.dart     # Main keyboard screen
├── widgets/
│   ├── keyboard_key.dart        # Individual key widget
│   ├── kirat_keyboard.dart      # Kirat layout widget
│   └── spacebar.dart            # Spacebar with language indicator
└── main.dart                    # App entry point
```

---

## Technical Stack

- **Flutter** — Cross-platform framework
- **Provider** — State management
- **Custom widgets** — Keyboard implementation
- **Unicode support** — Kirat character compliance

---

## Usage

1. Launch the app to access the in-app keyboard
2. Tap the **globe icon** to switch languages
3. Use **!#1/ABC** toggle for symbols and special characters
4. Numbers are always accessible from the top row
5. Current language is displayed above the spacebar

---

## How to Run

```bash
# 1. Clone the repository
git clone https://github.com/mrdeephang/kirat-script.git
cd kirat-script

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

---

## Future Enhancements

- **System keyboard integration** — Enable as default keyboard through device settings
- **Custom themes** — User-customizable keyboard appearance
- **Text predictions** — Smart word suggestions
- **Haptic feedback** — Tactile key press response

---

## Author

**Deephang Thegim**  
GitHub: [@mrdeephang](https://github.com/mrdeephang)

---

## License

Copyright © 2025 Deephang Thegim. All rights reserved.
