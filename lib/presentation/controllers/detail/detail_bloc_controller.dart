import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/get_post_comments_use_case.dart';
import '../worker.dart';
import 'detail_state.dart';

class DetailBloc extends Cubit<DetailState>{
  DetailBloc(this._getPostCommentsUseCase) : super(DetailState());

  final GetPostCommentsUseCase _getPostCommentsUseCase;

  Future<void> getPostComments(int postId) async {
    emit(state.copyWith(comments: Loading()));
    final result = await _getPostCommentsUseCase.execute(postId);
    result.fold(
      ifLeft: (failure) => emit(state.copyWith(comments: Error(failure))),
      ifRight: (comments) => emit(state.copyWith(comments: Success(comments))),
    );
  }
}