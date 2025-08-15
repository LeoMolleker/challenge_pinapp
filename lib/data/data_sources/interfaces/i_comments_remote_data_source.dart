import 'package:challenge_pinapp/data/dtos/comment_dto.dart';

abstract class ICommentsRemoteDataSource{
  Future<List<CommentDTO>> getPostComments(int postId);
}