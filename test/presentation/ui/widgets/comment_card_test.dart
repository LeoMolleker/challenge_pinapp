import 'package:challenge_pinapp/domain/entities/comment.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const comment = Comment(name: 'name', email: 'email', body: 'body', postId: 1, id: 1);
  testWidgets('comment card', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CommentCard(comment: comment)));
    expect(find.text('name'), findsOneWidget);
    expect(find.text('email'), findsOneWidget);
    expect(find.text('body'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
  });
}
