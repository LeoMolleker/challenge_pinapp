import 'package:challenge_pinapp/domain/entities/comment.dart';
import 'package:challenge_pinapp/domain/entities/failure.dart';
import 'package:challenge_pinapp/domain/use_cases/get_post_comments_use_case.dart';
import 'package:challenge_pinapp/domain/use_cases/like_comment_use_case.dart';
import 'package:challenge_pinapp/presentation/controllers/detail/detail_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/ui/screens/detail_page.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/comment_card.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/result_indicator.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../controllers/detail_controller/detail_bloc_controller_test.mocks.dart';

@GenerateMocks([GetPostCommentsUseCase, LikeCommentUseCase])
void main() {
  final MockGetPostCommentsUseCase getPostCommentsUseCase = MockGetPostCommentsUseCase();
  final MockLikeCommentUseCase likeUseCase = MockLikeCommentUseCase();
  final DetailBloc detailBloc = DetailBloc(getPostCommentsUseCase: getPostCommentsUseCase, likeCommentUseCase: likeUseCase);
  final comment = Comment(postId: 1, id: 1, name: 'name', email: 'email', body: 'body',);
  final dummy = Right<Failure, List<Comment>>([comment]);
  final emptyDummy = Right<Failure, List<Comment>>([]);
  final errorDummy = Left<Failure, List<Comment>>(CommentsFailure());
  provideDummy<Either<Failure, List<Comment>>>(dummy);
  provideDummy<Either<Failure, List<Comment>>>(emptyDummy);

  testWidgets('home page with cards', (tester) async {
    when(getPostCommentsUseCase.execute(any)).thenAnswer((_) async => dummy);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: detailBloc..getPostComments(1), child: const DetailPage(postId: 1,)),
      ),
    );
    await tester.pump();
    expect(find.byType(CommentCard), findsOneWidget);
  });

  testWidgets('home page empty', (tester) async {
    when(getPostCommentsUseCase.execute(any)).thenAnswer((_) async => emptyDummy);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: detailBloc..getPostComments(1), child: const DetailPage(postId: 1,)),
      ),
    );
    await tester.pump();
    expect(find.byType(ResultIndicator), findsOneWidget);
  });

  testWidgets('home page error', (tester) async {
    when(getPostCommentsUseCase.execute(any)).thenAnswer((_) async => errorDummy);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: detailBloc, child: const DetailPage(postId: 1,)),
      ),
    );
    await tester.pump();
    expect(find.byType(ResultIndicator), findsOneWidget);

  });
}
