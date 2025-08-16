import 'package:challenge_pinapp/data/data_sources/interfaces/i_comments_remote_data_source.dart';
import 'package:challenge_pinapp/domain/entities/comment.dart';
import 'package:dart_either/dart_either.dart';

import '../../domain/entities/failure.dart';
import '../../domain/repositories/i_comments_repository.dart';
import '../mappers/comments_mapper.dart';

class CommentsRepository extends ICommentsRepository {
  final ICommentsRemoteDataSource _commentsRemoteDataSource;

  CommentsRepository(this._commentsRemoteDataSource);

  @override
  Future<Either<Failure, List<Comment>>> getPostComments(int postId) async {
    try{
      final comments = await _commentsRemoteDataSource.getPostComments(postId);
      return Right(CommentMapper.toEntityList(comments));
    }catch(e){
      return Left(CommentsFailure());
    }
  }
}


