import 'package:challenge_pinapp/presentation/ui/widgets/home_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('home search bar', (tester) async {
    String textFieldValue = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomeSearchBar(
            showSuffixIcon: true,
            onChanged: (value) {
              textFieldValue = value;
            },
          ),
        ),
      ),
    );
    final textField = find.byType(TextField);
    await tester.tap(textField);
    await tester.enterText(textField, 'test');
    await tester.pump();
    expect(textField, findsOneWidget);
    expect(textFieldValue, 'test');
    final button = find.byType(IconButton);
    expect(button, findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
