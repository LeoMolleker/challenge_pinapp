import 'package:challenge_pinapp/data/data_sources/interfaces/i_post_remote_data_source.dart';
import 'package:challenge_pinapp/data/data_sources/remote_data_sources/post_remote_data_source.dart';
import 'package:challenge_pinapp/domain/entities/failure.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main(){
  late MockDio mockDio;
  late IPostRemoteDataSource postRemoteDataSource;

  final postsResponse = Response(requestOptions: RequestOptions(), data: [
    {
      'userId': 1,
      'id': 1,
      'title': 'Test title',
      'body': 'Test Body',
    },
    {
      'userId': 2,
      'id': 2,
      'title': 'Test title 2',
      'body': 'Test Body 2',
    },
  ]);

  setUp(() {
    mockDio = MockDio();
    postRemoteDataSource = PostRemoteDataSource(mockDio);
  });

  test('Get posts success', () async {
    when(mockDio.get(any)).thenAnswer((_) async => postsResponse);
    final result = await postRemoteDataSource.getPosts();
    expect(result[0].userId, postsResponse.data?[0]['userId']);
    expect(result[0].id, postsResponse.data?[0]['id']);
    expect(result[0].title, postsResponse.data?[0]['title']);
    expect(result[0].body, postsResponse.data?[0]['body']);
    expect(result[1].userId, postsResponse.data?[1]['userId']);
    expect(result[1].id, postsResponse.data?[1]['id']);
    expect(result[1].title, postsResponse.data?[1]['title']);
    expect(result[1].body, postsResponse.data?[1]['body']);
  });

  test('Exception on data source', () async {
    when(mockDio.get(any)).thenThrow(Exception());
    expect(() async => await postRemoteDataSource.getPosts(), throwsA(isA<PostFailure>()));
  });

}