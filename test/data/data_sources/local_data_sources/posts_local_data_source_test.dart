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
    {'id': 1, 'likes': 10},
    {'id': 2, 'likes': 20},
    {'id': 3, 'likes': 30},
  ];
  const likesResult = {
    1: 10,
    2: 20,
    3: 30,
  };
  setUp(() {
    database = MockDatabase();
    postLocalDataSource = PostsLocalDataSource(database);
  });

  test('Transaction success', () async {
    when(database.transaction(any)).thenAnswer((_) async {});
    final result = await postLocalDataSource.likeComment(1);
    expect(result, true);
  });

  test('Transaction failed', () async {
    when(database.transaction(any)).thenThrow(Exception());
    final result = await postLocalDataSource.likeComment(1);
    expect(result, false);
  });

  test('Get like counts success', () async {
    when(
      database.query(any, columns: anyNamed('columns'), where: anyNamed('where'), whereArgs: anyNamed('whereArgs')),
    ).thenAnswer((_) async => databaseResponse);
    final result = await postLocalDataSource.getLikeCounts([1, 2, 3]);
    expect(result, likesResult);
  });

  test('Get like counts failed', () async {
    when(
      database.query(any, columns: anyNamed('columns'), where: anyNamed('where'), whereArgs: anyNamed('whereArgs')),
    ).thenThrow(Exception());
    final result = await postLocalDataSource.getLikeCounts([1, 2, 3]);
    expect(result, null);
  });
}
