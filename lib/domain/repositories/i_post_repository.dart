
import 'package:dart_either/dart_either.dart';

import '../entities/failure.dart';
import '../entities/post.dart';

abstract class IPostRepository{
  Future<Either<Failure, List<Post>>> getPosts();

  Future<Either<Failure, bool>> likeComment(int postId);
}