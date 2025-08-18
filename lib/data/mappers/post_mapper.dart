import '../../domain/entities/post.dart';
import '../dtos/post_dto.dart';

abstract class PostMapper {
  static Post toEntity({required PostDTO postDTO, required bool? isLiked}) {
    return Post(
      userId: postDTO.userId,
      id: postDTO.id,
      title: postDTO.title,
      body: postDTO.body,
      isLiked: isLiked,
    );
  }

  static List<Post> toEntityList({
    required List<PostDTO> posts,
    required Map<int, bool>? likes,
  }) {
    return posts
        .map(
          (post) => toEntity(
            postDTO: post,
            isLiked: likes == null ? null : likes[post.id] ?? false,
          ),
        )
        .toList();
  }
}
