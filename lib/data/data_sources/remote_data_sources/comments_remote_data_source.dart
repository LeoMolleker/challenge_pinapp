import 'package:challenge_pinapp/data/data_sources/interfaces/i_comments_remote_data_source.dart';
import 'package:challenge_pinapp/data/dtos/comment_dto.dart';
import 'package:comments_plugin/comments_plugin.dart';

import '../../../domain/entities/failure.dart';

class CommentsRemoteDataSource implements ICommentsRemoteDataSource {
  final CommentsPlugin _commentsPlugin;

  CommentsRemoteDataSource(this._commentsPlugin);

  @override
  Future<List<CommentDTO>> getPostComments(int postId) async {
    try {
      final comments = await _commentsPlugin.getPostsComments(postId);
      if (comments == null) {
        throw CommentsFailure();
      }
      return CommentDTO.fromJsonList(comments);
    } catch (e) {
      throw CommentsFailure();
    }
  }
}