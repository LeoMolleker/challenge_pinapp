import 'package:challenge_pinapp/domain/repositories/i_post_repository.dart';
import 'package:dart_either/dart_either.dart';

import '../entities/failure.dart';
import '../entities/post.dart';

class GetPostUseCase {
  final IPostRepository _postRepository;

  GetPostUseCase(this._postRepository);

  Future<Either<Failure, List<Post>>> execute() async =>
      await _postRepository.getPosts();
}
