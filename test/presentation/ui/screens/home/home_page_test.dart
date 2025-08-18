import 'package:challenge_pinapp/domain/entities/failure.dart';
import 'package:challenge_pinapp/domain/entities/post.dart';
import 'package:challenge_pinapp/domain/use_cases/get_posts_use_case.dart';
import 'package:challenge_pinapp/presentation/controllers/home/home_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/ui/screens/home_page.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/post_card.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/result_indicator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../controllers/home_bloc_controller/home_bloc_controller_test.mocks.dart';

@GenerateMocks([GetPostUseCase])
void main() {
  final MockGetPostUseCase useCase = MockGetPostUseCase();
  final HomeBloc homeBloc = HomeBloc(useCase);
  final post = Post(userId: 1, id: 1, title: 'title', body: 'body', isLiked: true);
  final dummy = Right<Failure, List<Post>>([post]);
  final emptyDummy = Right<Failure, List<Post>>([]);
  final errorDummy = Left<Failure, List<Post>>(PostFailure());
  provideDummy<Either<Failure, List<Post>>>(dummy);
  provideDummy<Either<Failure, List<Post>>>(emptyDummy);

  testWidgets('home page with cards', (tester) async {
    when(useCase.execute()).thenAnswer((_) async => dummy);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: homeBloc, child: const HomePage()),
      ),
    );
    await tester.pump();
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(PostCard), findsOneWidget);
  });

  testWidgets('home page empty', (tester) async {
    when(useCase.execute()).thenAnswer((_) async => emptyDummy);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: homeBloc, child: const HomePage()),
      ),
    );
    await tester.pump();
    expect(find.byType(ResultIndicator), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('home page error', (tester) async {
    when(useCase.execute()).thenAnswer((_) async => errorDummy);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: homeBloc, child: const HomePage()),
      ),
    );
    await tester.pump();
    expect(find.byType(ResultIndicator), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
  });
}
