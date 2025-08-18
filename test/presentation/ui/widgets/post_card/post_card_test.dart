import 'package:challenge_pinapp/domain/entities/failure.dart';
import 'package:challenge_pinapp/domain/entities/post.dart';
import 'package:challenge_pinapp/domain/use_cases/get_posts_use_case.dart';
import 'package:challenge_pinapp/presentation/controllers/home/home_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/post_card.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_card_test.mocks.dart';

@GenerateMocks([GetPostUseCase])
void main() {
  const post = Post(userId: 1, id: 1, title: 'title', body: 'body', isLiked: true);
  final useCase = MockGetPostUseCase();
  final homeBloc = HomeBloc(useCase);

  testWidgets('post card', (tester) async {
    final dummy = Right<Failure, List<Post>>([post]);
    provideDummy<Either<Failure, List<Post>>>(dummy);
    when(useCase.execute()).thenAnswer((_) async => dummy);
    await homeBloc.getPosts();
    await tester.pumpWidget(
      BlocProvider.value(
        value: homeBloc,
        child: MaterialApp(home: const PostCard(post: post)),
      ),
    );
    expect(find.text('title'), findsOneWidget);
    expect(find.text('body'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
