# Kirat Script Keyboard

A custom, open-source virtual keyboard designed specifically for the Kirat script, featuring seamless bilingual support with an English QWERTY layout.

---

## Overview

Kirat Script Keyboard provides a native typing experience for Kirat characters across mobile and web platforms. Built with Flutter, it offers a robust, dynamic interface that adapts to various screen sizes and orientations, ensuring comfortable text input whether used as an in-app keyboard or an integrated system Input Method Editor (IME).

## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/96d0ac2e-649d-4d26-a482-ff81106b4225" alt="Kirat Script" width="250"/>
  <img src="https://github.com/user-attachments/assets/427d1ef0-4ceb-4b0b-a177-3f63f1e36eb7" alt="English Keyboard" width="250"/>
  <img src="https://github.com/user-attachments/assets/416ac6ad-017c-4d15-ae7b-9041b2b164b5" alt="Kirat Symbols" width="250"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/3f6de3fd-6481-4459-a4eb-b4a2f4ac037a" alt="English Symbols" width="250"/>
  <img src="https://github.com/user-attachments/assets/f2d46e6f-4668-42c9-9c01-6bb304c2fd9c" alt="Language Toggle" width="250"/>
</p>

---

## Core Features

- **Dual Language Support:** Instantly toggle between Kirat script and standard English QWERTY layouts.
- **Smart Layout System:** Adaptive rendering that provides Kirat numerals in Kirat mode and standard Arabic numerals in English mode.
- **Persistent Number Row:** A dedicated top row for numerical input, improving typing efficiency.
- **Responsive Sizing:** Intelligently scales padding and font sizes across portrait and landscape orientations to prevent UI clipping.
- **Dark and Light Modes:** Fully supports dynamic system theming with accessible contrast ratios.
- **Cross-Platform:** Optimized for Android, iOS, and Web environments.

## Keyboard Layout Details

### Kirat Mode

- **Top Row:** Kirat numerals.
- **Main Area:** Kirat consonants and vowels.
- **Symbols:** Kirat-specific punctuation and frequently used characters.

### English Mode

- **Top Row:** Standard numerals.
- **Main Area:** QWERTY layout.
- **Symbols:** Comprehensive standard symbol set.

## Controls

| Key Type            | Function                                                                    |
| :------------------ | :-------------------------------------------------------------------------- |
| **Language Toggle** | Switches the active layout between Kirat and English.                       |
| **Symbols Toggle**  | Switches between the alphanumeric and symbols layouts.                      |
| **Shift**           | Capitalizes letters or accesses alternate characters on the current layout. |
| **Backspace**       | Deletes characters (supports continuous deletion on long-press).            |
| **Enter**           | Inserts a new line or submits the form.                                     |

## Development Setup

### Prerequisites

- Flutter SDK (^3.9.0)
- Dart SDK
- An active emulator or connected physical device

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/mrdeephang/kirat-script.git
   cd kirat-script
   ```

2. Install project dependencies:

   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

### Testing

The project maintains a suite of unit, widget, and integration tests to ensure stability.

```bash
# Run unit and widget tests
flutter test

# Run end-to-end integration tests (requires connected device/emulator)
flutter test integration_test/app_test.dart
```

## Contributing

We welcome contributions from the community. Please read our [CONTRIBUTING.md](CONTRIBUTING.md) file for detailed guidelines on how to report bugs, request features, and submit pull requests.

## Architecture

- **Framework:** Flutter
- **State Management:** Provider
- **Continuous Integration:** GitHub Actions (Automated formatting, analysis, testing, and multi-platform compilation)

## Author

**Deephang Thegim**
GitHub: [@mrdeephang](https://github.com/mrdeephang)

## License

Copyright 2026 Deephang Thegim. All rights reserved.
