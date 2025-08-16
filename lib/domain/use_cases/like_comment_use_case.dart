import 'package:challenge_pinapp/domain/entities/failure.dart';
import 'package:challenge_pinapp/domain/repositories/i_post_repository.dart';
import 'package:dart_either/dart_either.dart';

class LikeCommentUseCase {
  final IPostRepository _postRepository;

  LikeCommentUseCase(this._postRepository);

  Future<Either<Failure, bool>> execute(int postId) async =>
      await _postRepository.likeComment(postId);
}
