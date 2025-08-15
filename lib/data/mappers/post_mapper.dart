import '../../domain/entities/post.dart';
import '../dtos/post_dto.dart';

abstract class PostMapper {
  static Post toEntity(PostDTO postDTO) {
    return Post(
      userId: postDTO.userId,
      id: postDTO.id,
      title: postDTO.title,
      body: postDTO.body,
    );
  }

  static List<Post> toEntityList(List<PostDTO> posts) {
    return posts.map((post) => toEntity(post)).toList();
  }
}
