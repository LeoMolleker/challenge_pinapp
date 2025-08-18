import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_pinapp/domain/entities/comment.dart';
import 'package:challenge_pinapp/domain/entities/failure.dart';
import 'package:challenge_pinapp/domain/use_cases/get_post_comments_use_case.dart';
import 'package:challenge_pinapp/domain/use_cases/like_comment_use_case.dart';
import 'package:challenge_pinapp/presentation/controllers/detail/detail_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/controllers/detail/detail_state.dart';
import 'package:challenge_pinapp/presentation/controllers/worker.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_bloc_controller_test.mocks.dart';

@GenerateMocks([GetPostCommentsUseCase, LikeCommentUseCase])
void main() {
  late MockGetPostCommentsUseCase getPostCommentsUseCase;
  late MockLikeCommentUseCase likeCommentUseCase;
  late DetailBloc detailBloc;

  setUp(() {
    getPostCommentsUseCase = MockGetPostCommentsUseCase();
    likeCommentUseCase = MockLikeCommentUseCase();
    detailBloc = DetailBloc(getPostCommentsUseCase: getPostCommentsUseCase, likeCommentUseCase: likeCommentUseCase);
  });

  blocTest(
    'emits success',
    build: () => detailBloc,
    setUp: () {
      final dummy = Right<Failure, List<Comment>>([]);
      provideDummy<Either<Failure, List<Comment>>>((dummy));
      when(getPostCommentsUseCase.execute(any)).thenAnswer((_) async => dummy);
    },
    act: (bloc) => bloc.getPostComments(1),
    expect: () => [
      isA<DetailState>().having((state) => state.comments, 'loading', isA<Loading<List<Comment>>>()),
      isA<DetailState>().having((state) => state.comments, 'success', isA<Success<List<Comment>>>()),
    ],
  );

  blocTest(
    'emits error',
    build: () => detailBloc,
    setUp: () {
      final dummy = Left<Failure, List<Comment>>(CommentsFailure());
      provideDummy<Either<Failure, List<Comment>>>((dummy));
      when(getPostCommentsUseCase.execute(any)).thenAnswer((_) async => dummy);
    },
    act: (bloc) => bloc.getPostComments(1),
    expect: () => [
      isA<DetailState>().having((state) => state.comments, 'loading', isA<Loading<List<Comment>>>()),
      isA<DetailState>().having((state) => state.comments, 'error', isA<Error<List<Comment>>>()),
    ],
  );

  blocTest(
    'emits success',
    build: () => detailBloc,
    setUp: () {
      final dummy = Right<Failure, bool>(true);
      provideDummy<Either<Failure, bool>>((dummy));
      when(likeCommentUseCase.execute(postId: anyNamed('postId'), isLiked: anyNamed('isLiked'))).thenAnswer((_) async => dummy);
    },
    act: (bloc) => bloc.likePost(postId: 1, isLiked: true),
    expect: () => [
      isA<DetailState>().having((state) => state.like, 'loading', isA<Loading<bool>>()),
      isA<DetailState>().having((state) => state.like, 'success', isA<Success<bool>>()),
    ],
  );

  blocTest(
    'emits error',
    build: () => detailBloc,
    setUp: () {
      final dummy = Left<Failure, bool>(LikeFailure());
      provideDummy<Either<Failure, bool>>((dummy));
      when(likeCommentUseCase.execute(postId: anyNamed('postId'), isLiked: anyNamed('isLiked'))).thenAnswer((_) async => dummy);
    },
    act: (bloc) => bloc.likePost(postId: 1, isLiked: true),
    expect: () => [
      isA<DetailState>().having((state) => state.like, 'loading', isA<Loading<bool>>()),
      isA<DetailState>().having((state) => state.like, 'error', isA<Error<bool>>()),
    ],
  );
}
