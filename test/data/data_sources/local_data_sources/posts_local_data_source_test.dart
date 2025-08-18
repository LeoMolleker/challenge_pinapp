import 'package:challenge_pinapp/data/data_sources/interfaces/i_posts_local_data_source.dart';
import 'package:challenge_pinapp/data/data_sources/locaL_data_sources/posts_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import 'posts_local_data_source_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  late IPostsLocalDataSource postLocalDataSource;
  late MockDatabase database;
  const databaseResponse = [
    {'id': 1, 'isLiked': 1},
    {'id': 2, 'isLiked': 1},
    {'id': 3, 'isLiked': 1},
  ];
  const likesResult = {
    1: true,
    2: true,
    3: true,
  };
  setUp(() {
    database = MockDatabase();
    postLocalDataSource = PostsLocalDataSource(database);
  });

  test('Transaction success', () async {
    when(database.insert(any, any, conflictAlgorithm: anyNamed('conflictAlgorithm'))).thenAnswer((_) async {return 1;});
    final result = await postLocalDataSource.updateLikeStatus(postId: 1, isLiked: true);
    expect(result, true);
  });

  test('Transaction failed', () async {
    when(database.insert(any, any, conflictAlgorithm: anyNamed('conflictAlgorithm'))).thenThrow(Exception());
    final result = await postLocalDataSource.updateLikeStatus(postId: 1, isLiked: true);
    expect(result, false);
  });

  test('Get like counts success', () async {
    when(
      database.query(any, columns: anyNamed('columns'), where: anyNamed('where'), whereArgs: anyNamed('whereArgs')),
    ).thenAnswer((_) async => databaseResponse);
    final result = await postLocalDataSource.getLikes([1, 2, 3]);
    expect(result, likesResult);
  });

  test('Get like counts failed', () async {
    when(
      database.query(any, columns: anyNamed('columns'), where: anyNamed('where'), whereArgs: anyNamed('whereArgs')),
    ).thenThrow(Exception());
    final result = await postLocalDataSource.getLikes([1, 2, 3]);
    expect(result, null);
  });
}
