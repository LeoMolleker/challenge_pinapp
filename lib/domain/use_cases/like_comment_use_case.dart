import 'package:challenge_pinapp/domain/repositories/i_post_repository.dart';

class LikeCommentUseCase {
  final IPostRepository _postRepository;

  LikeCommentUseCase(this._postRepository);

  Future<bool> execute(int postId) async =>
      await _postRepository.likeComment(postId);
}
