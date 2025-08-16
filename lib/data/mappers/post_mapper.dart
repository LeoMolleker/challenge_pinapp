import '../../domain/entities/post.dart';
import '../dtos/post_dto.dart';

abstract class PostMapper {
  static Post toEntity({required PostDTO postDTO, required int? likes}) {
    return Post(
      userId: postDTO.userId,
      id: postDTO.id,
      title: postDTO.title,
      body: postDTO.body,
      likes: likes,
    );
  }

  static List<Post> toEntityList({
    required List<PostDTO> posts,
    required Map<int, int>? likes,
  }) {
    return posts
        .map(
          (post) => toEntity(
            postDTO: post,
            likes: likes == null ? null : likes[post.id] ?? 0,
          ),
        )
        .toList();
  }
}
