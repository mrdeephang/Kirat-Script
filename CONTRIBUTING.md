# Contributing to Kirat Script Keyboard

First off, thank you for considering contributing to the Kirat Script Keyboard! It's people like you that make open source such a great community to learn, inspire, and create.

## Code of Conduct

By participating in this project, you are expected to uphold our code of conduct. Please be respectful, welcoming, and inclusive to all contributors and users.

## How Can I Contribute?

### Reporting Bugs
If you find a bug, please create an issue providing as much detail as possible:
* A clear and descriptive title.
* Steps to reproduce the issue.
* Expected and actual behavior.
* Screenshots or videos (especially since this is a visual keyboard app).
* Your device model and OS version.

### Suggesting Enhancements
Enhancement suggestions are highly encouraged! If you have ideas for new features, layouts, or improvements:
* Check if there's already an issue open for it.
* Open a new issue with a clear description of the enhancement and why it would be useful.

### Pull Requests
1. **Fork the repo** and create your branch from `main`.
2. **Ensure your code passes tests and formatting**. Before submitting, run:
   ```bash
   flutter format .
   flutter analyze
   flutter test
   ```
3. **Write Conventional Commits**. We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification for commit messages (e.g., `feat: add new symbol layout`, `fix: resolve UI chopping in landscape`).
4. **Update Documentation** if your changes affect the README or require new documentation.
5. **Open a Pull Request** describing your changes in detail, referencing any open issues it resolves.

## Development Setup

1. Make sure you have Flutter installed (SDK version ^3.9.0 is recommended).
2. Clone the repository and run `flutter pub get` to install dependencies.
3. You can run the application on an emulator or a physical device using `flutter run`.

## UI/UX Guidelines
As a keyboard application, user experience is critical. Please ensure that:
* Keys have adequate touch targets (especially in mobile landscape mode).
* Changes respect both dark and light modes.
* Visuals match the premium, glassmorphic aesthetics of the existing application.

Thank you for contributing!
