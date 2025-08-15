import '../../dtos/post_dto.dart';

abstract class IPostRemoteDataSource{
  Future<List<PostDTO>> getPosts();
}