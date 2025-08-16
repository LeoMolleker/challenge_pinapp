import 'package:challenge_pinapp/data/data_sources/interfaces/i_comments_remote_data_source.dart';
import 'package:challenge_pinapp/data/dtos/comment_dto.dart';
import 'package:challenge_pinapp/data/repositories/comments_repository.dart';
import 'package:challenge_pinapp/domain/entities/failure.dart';
import 'package:challenge_pinapp/domain/repositories/i_comments_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'comments_repository_test.mocks.dart';

@GenerateMocks([ICommentsRemoteDataSource])
void main(){
  late MockICommentsRemoteDataSource commentsRemoteDataSource;
  late ICommentsRepository commentsRepository;

  final commentsDTO = [
    CommentDTO(postId: 1, id: 1, name: 'Test Name', email: 'test@example.com', body: 'Test Body'),
    CommentDTO(postId: 1, id: 2, name: 'Test Name 2', email: 'test2@example.com', body: 'Test Body 2'),
  ];

  setUp((){
    commentsRemoteDataSource = MockICommentsRemoteDataSource();
    commentsRepository = CommentsRepository(commentsRemoteDataSource);
  });

  test('Get post comments success', () async {
    when(commentsRemoteDataSource.getPostComments(any)).thenAnswer((_) async => commentsDTO);
    final result = await commentsRepository.getPostComments(1);
    expect(result.isRight, true);
    final comments = result.getOrElse(() => []);
    expect(comments[0].postId, commentsDTO[0].postId);
    expect(comments[0].id, commentsDTO[0].id);
    expect(comments[0].name, commentsDTO[0].name);
    expect(comments[0].email, commentsDTO[0].email);
    expect(comments[0].body, commentsDTO[0].body);
    expect(comments[1].postId, commentsDTO[1].postId);
    expect(comments[1].id, commentsDTO[1].id);
    expect(comments[1].name, commentsDTO[1].name);
    expect(comments[1].email, commentsDTO[1].email);
    expect(comments[1].body, commentsDTO[1].body);
  });

  test('Exception on repository', () async {
    when(commentsRemoteDataSource.getPostComments(any)).thenThrow(CommentsFailure());
    final result = await commentsRepository.getPostComments(1);
    expect(result.isLeft, true);
    result.fold(
      ifLeft: (failure) => expect(failure, isA<CommentsFailure>()),
      ifRight: (posts) => expect(posts, []),
    );
  });
}