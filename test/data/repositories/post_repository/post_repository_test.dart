import 'package:challenge_pinapp/data/data_sources/interfaces/i_post_remote_data_source.dart';
import 'package:challenge_pinapp/data/data_sources/interfaces/i_posts_local_data_source.dart';
import 'package:challenge_pinapp/data/dtos/post_dto.dart';
import 'package:challenge_pinapp/data/repositories/post_repository.dart';
import 'package:challenge_pinapp/domain/entities/failure.dart';
import 'package:challenge_pinapp/domain/entities/post.dart';
import 'package:challenge_pinapp/domain/repositories/i_post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_repository_test.mocks.dart';

@GenerateMocks([IPostRemoteDataSource, IPostsLocalDataSource])
void main(){
  late IPostRemoteDataSource postRemoteDataSource;
  late MockIPostsLocalDataSource postsLocalDataSource;
  late IPostRepository postRepository;

  final postsDto = [
    PostDTO(userId: 1, id: 1, title: 'Post 1', body: 'Body 1'),
    PostDTO(userId: 2, id: 2, title: 'Post 2', body: 'Body 2'),
  ];

  final likes = {
    1: true,
    2: true,
  };

  setUp((){
    postRemoteDataSource = MockIPostRemoteDataSource();
    postsLocalDataSource = MockIPostsLocalDataSource();
    postRepository = PostRepository(postRemoteDataSource: postRemoteDataSource, postsLocalDataSource: postsLocalDataSource);
  });

  test('Get posts', () async {
    when(postRemoteDataSource.getPosts()).thenAnswer((_) async => postsDto);
    when(postsLocalDataSource.getLikes(any)).thenAnswer((_) async => likes);
    final result = await postRepository.getPosts();
    expect(result.isRight, true);
    result.fold(ifLeft: (l) => expect(l, isA<PostFailure>()), ifRight: (r) {
      expect(r.length, 2);
      expect(r[0].id, 1);
      expect(r[0].isLiked, true);
      expect(r[0].title, postsDto[0].title);
      expect(r[0].body, postsDto[0].body);
      expect(r[1].id, 2);
      expect(r[1].isLiked, true);
      expect(r[1].title, postsDto[1].title);
      expect(r[1].body, postsDto[1].body);
    });

  });

  test('Post failure', () async {
    when(postRemoteDataSource.getPosts()).thenThrow(Exception());
    final result = await postRepository.getPosts();
    expect(result.isLeft, true);
    result.fold(ifLeft: (l) => expect(l, isA<PostFailure>()), ifRight: (r) => expect(r, isA<List<Post>>()));
  });

  test('like success', () async {
    when(postsLocalDataSource.updateLikeStatus(postId: anyNamed('postId'), isLiked: anyNamed('isLiked'))).thenAnswer((_) async => true);
    final result = await postRepository.likeComment(postId: 1, isLiked: true);
    expect(result.isRight, true);

  });

  test('like failure', () async {
    when(postsLocalDataSource.updateLikeStatus(postId: anyNamed('postId'), isLiked: anyNamed('isLiked'))).thenAnswer((_) async => false);
    final result = await postRepository.likeComment(postId: 1, isLiked: true);
    expect(result.isLeft, true);
    result.fold(ifLeft: (l) => expect(l, isA<LikeFailure>()), ifRight: (r) => expect(r, isA<bool>()));
  });
}