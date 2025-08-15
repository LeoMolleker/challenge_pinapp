import 'package:challenge_pinapp/domain/entities/comment.dart';

import '../dtos/comment_dto.dart';

abstract class CommentMapper {
  static Comment toEntity(CommentDTO commentDTO) {
    return Comment(
      postId: commentDTO.postId,
      id: commentDTO.id,
      name: commentDTO.name,
      email: commentDTO.email,
      body: commentDTO.body,
    );
  }

  static List<Comment> toEntityList(List<CommentDTO> comments) {
    return comments.map((comment) => toEntity(comment)).toList();
  }
}
