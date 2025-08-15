import 'package:dart_either/dart_either.dart';

import '../entities/comment.dart';
import '../entities/failure.dart';
import '../repositories/i_comments_repository.dart';

class GetPostCommentsUseCase {
  final ICommentsRepository _commentsRepository;

  GetPostCommentsUseCase(this._commentsRepository);

  Future<Either<Failure, List<Comment>>> execute(int postId) async =>
      await _commentsRepository.getPostComments(postId);
}
