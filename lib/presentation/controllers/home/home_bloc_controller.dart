import 'package:challenge_pinapp/presentation/controllers/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';
import '../../../domain/use_cases/get_posts_use_case.dart';
import '../worker.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc(this._getPostUseCase) : super(HomeState());

  final GetPostUseCase _getPostUseCase;

  Future<void> getPosts() async {
    emit(state.copyWith(posts: const Loading<List<Post>>()));
    final result = await _getPostUseCase.execute();

    result.fold(
      ifLeft: (failure) => emit(state.copyWith(posts: Error<List<Post>>(failure))),
      ifRight: (posts) => emit(state.copyWith(posts: Success<List<Post>>(posts))),
    );
  }

  void getFilteredPosts(String value) {
    emit(state.copyWith(searchValue: value));
  }

  void updatePostsLikes(int postId) {
    emit(
      state.copyWith(
        posts: Success<List<Post>>(
          state.posts.value!.map((post) => post.id == postId ? post.copyWith(likes: post.likes! + 1) : post).toList(),
        ),
      ),
    );
  }
}
