import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/get_post_comments_use_case.dart';
import '../../../domain/use_cases/like_comment_use_case.dart';
import '../worker.dart';
import 'detail_state.dart';

class DetailBloc extends Cubit<DetailState> {
  DetailBloc({required GetPostCommentsUseCase getPostCommentsUseCase, required LikeCommentUseCase likeCommentUseCase})
    : _getPostCommentsUseCase = getPostCommentsUseCase,
      _likeCommentUseCase = likeCommentUseCase,
      super(DetailState());

  final GetPostCommentsUseCase _getPostCommentsUseCase;
  final LikeCommentUseCase _likeCommentUseCase;

  Future<void> getPostComments(int postId) async {
    emit(state.copyWith(comments: Loading()));
    final result = await _getPostCommentsUseCase.execute(postId);
    result.fold(
      ifLeft: (failure) => emit(state.copyWith(comments: Error(failure))),
      ifRight: (comments) => emit(state.copyWith(comments: Success(comments))),
    );
  }

  Future<void> likePost(int postId) async {
    emit(state.copyWith(like: Loading()));
    final result = await _likeCommentUseCase.execute(postId);
    result.fold(
      ifLeft: (failure) => emit(state.copyWith(like: Error(failure))),
      ifRight: (liked) => emit(state.copyWith(like: Success(liked))),
    );
  }
}
