import 'package:challenge_pinapp/data/data_sources/interfaces/i_posts_local_data_source.dart';
import 'package:challenge_pinapp/data/mappers/post_mapper.dart';

import 'package:challenge_pinapp/domain/entities/post.dart';
import 'package:dart_either/dart_either.dart';

import '../../domain/entities/failure.dart';
import '../data_sources/interfaces/i_post_remote_data_source.dart';
import '../../domain/repositories/i_post_repository.dart';

class PostRepository extends IPostRepository {
  final IPostRemoteDataSource _postRemoteDataSource;
  final IPostsLocalDataSource _postsLocalDataSource;

  PostRepository({
    required IPostRemoteDataSource postRemoteDataSource,
    required IPostsLocalDataSource postsLocalDataSource,
  }) : _postRemoteDataSource = postRemoteDataSource,
       _postsLocalDataSource = postsLocalDataSource;

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final posts = await _postRemoteDataSource.getPosts();
      final likes = await _postsLocalDataSource.getLikeCounts(posts.map((post) => post.id).toList());
      return Right(PostMapper.toEntityList(posts: posts, likes: likes));
    } catch (e) {
      return Left(PostFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> likeComment(int postId) async {
    try{
      final likeAdded = await _postsLocalDataSource.likeComment(postId);
      if(!likeAdded){
        throw Exception();
      }
      return Right(likeAdded);
    }catch(e){
      return Left(LikeFailure());
    }

  }
}
