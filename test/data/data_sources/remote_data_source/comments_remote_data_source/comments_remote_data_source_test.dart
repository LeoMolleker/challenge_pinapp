import 'package:challenge_pinapp/data/data_sources/interfaces/i_comments_remote_data_source.dart';
import 'package:challenge_pinapp/data/data_sources/remote_data_sources/comments_remote_data_source.dart';
import 'package:challenge_pinapp/domain/entities/failure.dart';
import 'package:comments_plugin/comments_plugin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'comments_remote_data_source_test.mocks.dart';

@GenerateMocks([CommentsPlugin])
void main() {
  late ICommentsRemoteDataSource commentsRemoteDataSource;
  late MockCommentsPlugin commentsPlugin;

  final comments = [
    {'id': 1, 'postId': 1, 'name': 'Test Name', 'email': 'test@example.com', 'body': 'Test Body'},
    {'id': 2, 'postId': 1, 'name': 'Test Name 2', 'email': 'test2@example.com', 'body': 'Test Body 2'},
  ];

  setUp(() {
    commentsPlugin = MockCommentsPlugin();
    commentsRemoteDataSource = CommentsRemoteDataSource(commentsPlugin);
  });

  test('Get post comments success', () async {
    when(commentsPlugin.getPostsComments(any)).thenAnswer((_) async => comments);
    final result = await commentsRemoteDataSource.getPostComments(1);
    expect(result[0].id, comments[0]['id']);
    expect(result[0].postId, comments[0]['postId']);
    expect(result[0].name, comments[0]['name']);
    expect(result[0].email, comments[0]['email']);
    expect(result[0].body, comments[0]['body']);
    expect(result[1].id, comments[1]['id']);
    expect(result[1].postId, comments[1]['postId']);
    expect(result[1].name, comments[1]['name']);
    expect(result[1].email, comments[1]['email']);
    expect(result[1].body, comments[1]['body']);
  });

  test('Plugin return null', () async {
    when(commentsPlugin.getPostsComments(any)).thenAnswer((_) async => null);
    expect(() async => await commentsRemoteDataSource.getPostComments(1), throwsA(isA<CommentsFailure>()));
  });

  test('Exception on data source', () async {
    when(commentsPlugin.getPostsComments(any)).thenThrow(Exception());
    expect(() async => await commentsRemoteDataSource.getPostComments(1), throwsA(isA<CommentsFailure>()));
  });
}
