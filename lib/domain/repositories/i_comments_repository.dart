import 'package:challenge_pinapp/domain/entities/comment.dart';
import 'package:dart_either/dart_either.dart';

import '../entities/failure.dart';

abstract class ICommentsRepository{
  Future<Either<Failure, List<Comment>>> getPostComments(int postId);
}