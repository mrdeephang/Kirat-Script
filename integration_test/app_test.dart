import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kirat_script/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End App Test', () {
    testWidgets('Type "q" into the TextField using the virtual keyboard', (
      tester,
    ) async {
      app.main();
      // Wait for the app to settle
      await tester.pumpAndSettle();

      // The default layout is Kirat. We need to switch to English to find 'q'.
      final globeKey = find.byIcon(Icons.language);
      expect(globeKey, findsOneWidget);
      await tester.tap(globeKey);
      await tester.pumpAndSettle();

      // Find the 'q' key and tap it
      final qKey = find.text('q');
      expect(qKey, findsOneWidget);
      await tester.tap(qKey);
      await tester.pumpAndSettle();

      // Find the spacebar and tap it
      final spaceKey = find.text(
        'English',
      ); // In english layout, spacebar text is 'English'
      if (spaceKey.evaluate().isNotEmpty) {
        await tester.tap(spaceKey);
        await tester.pumpAndSettle();
      }

      // Verify the TextField contains the text
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, contains('q '));
    });
  });
}
