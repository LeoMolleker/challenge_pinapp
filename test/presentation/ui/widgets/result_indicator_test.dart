import 'package:challenge_pinapp/presentation/ui/models/button_content.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/result_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('result indicator error', (tester) async {
    await tester.pumpWidget(MaterialApp(home: const ResultIndicator.error(title: 'title')));
    expect(find.text('title'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });

  testWidgets('result indicator empty', (tester) async {
    String value = '';
    await tester.pumpWidget(
      MaterialApp(
        home: ResultIndicator.empty(
          title: 'title',
          button: ButtonContent(
            text: 'button',
            onPressed: () {
              value = 'test';
            },
          ),
        ),
      ),
    );
    expect(find.text('title'), findsOneWidget);
    expect(find.byIcon(Icons.search_off), findsOneWidget);
    final button = find.byType(ElevatedButton);
    await tester.tap(button);
    expect(value, 'test');
  });
}
