import 'package:challenge_pinapp/domain/entities/failure.dart';
import 'package:challenge_pinapp/domain/entities/post.dart';
import 'package:challenge_pinapp/domain/use_cases/get_posts_use_case.dart';
import 'package:challenge_pinapp/presentation/controllers/home/home_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/controllers/home/home_state.dart';
import 'package:challenge_pinapp/presentation/controllers/worker.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'home_bloc_controller_test.mocks.dart';

@GenerateMocks([GetPostUseCase])
void main() {
  late GetPostUseCase getPostUseCase;
  late HomeBloc homeBloc;

  final post = Post(userId: 1, id: 1, likes: 1);

  setUp(() {
    getPostUseCase = MockGetPostUseCase();
    homeBloc = HomeBloc(getPostUseCase);
  });

  blocTest(
    'emits success',
    build: () => homeBloc,
    setUp: () {
      final dummy = Right<Failure, List<Post>>([]);
      provideDummy<Either<Failure, List<Post>>>((dummy));
      when(getPostUseCase.execute()).thenAnswer((_) async => dummy);
    },
    act: (bloc) => bloc.getPosts(),
    expect: () => [
      isA<HomeState>().having((state) => state.posts, 'loading', isA<Loading<List<Post>>>()),
      isA<HomeState>().having((state) => state.posts, 'success', isA<Success<List<Post>>>()),
    ],
  );

  blocTest(
    'emits error',
    build: () => homeBloc,
    setUp: () {
      final dummy = Left<Failure, List<Post>>(PostFailure());
      provideDummy<Either<Failure, List<Post>>>((dummy));
      when(getPostUseCase.execute()).thenAnswer((_) async => dummy);
    },
    act: (bloc) => bloc.getPosts(),
    expect: () => [
      isA<HomeState>().having((state) => state.posts, 'loading', isA<Loading<List<Post>>>()),
      isA<HomeState>().having((state) => state.posts, 'error', isA<Error<List<Post>>>()),
    ],
  );

  blocTest(
    'emits search value',
    build: () => homeBloc,
    act: (bloc) => bloc.getFilteredPosts('value'),
    expect: () => [isA<HomeState>().having((state) => state.searchValue, 'loading', 'value')],
  );

  blocTest(
    'emits success',
    build: () => homeBloc,
    setUp: () {
      final dummy = Right<Failure, List<Post>>([post]);
      provideDummy<Either<Failure, List<Post>>>((dummy));
      when(getPostUseCase.execute()).thenAnswer((_) async => dummy);
    },
    act: (bloc) async {
      await bloc.getPosts();
      bloc.updatePostsLikes(1);
    },
    expect: () => [
      isA<HomeState>().having((state) => state.posts, 'loading', isA<Loading<List<Post>>>()),
      isA<HomeState>().having((state) => state.posts, 'success', isA<Success<List<Post>>>()),
      isA<HomeState>().having((state) => state.posts.value?[0].likes, '+1 like', 2)
    ],
  );
}
