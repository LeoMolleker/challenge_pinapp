
import 'package:challenge_pinapp/data/mappers/post_mapper.dart';

import 'package:challenge_pinapp/domain/entities/post.dart';
import 'package:dart_either/dart_either.dart';

import '../../domain/entities/failure.dart';
import '../data_sources/interfaces/i_post_remote_data_source.dart';
import '../../domain/repositories/i_post_repository.dart';

class PostRepository extends IPostRepository {
  final IPostRemoteDataSource _postRemoteDataSource;

  PostRepository(this._postRemoteDataSource);

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final posts = await _postRemoteDataSource.getPosts();
      return Right(PostMapper.toEntityList(posts));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
