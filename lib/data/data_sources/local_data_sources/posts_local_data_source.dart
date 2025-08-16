import 'package:sqflite/sqflite.dart';

import '../interfaces/i_posts_local_data_source.dart';

class PostsLocalDataSource extends IPostsLocalDataSource {
  final Database _database;

  PostsLocalDataSource(this._database);

  @override
  Future<bool> likeComment(int postId) async {
    try{
      await _database.transaction((txn) async {
        final List<Map<String, dynamic>> result = await txn.query(
          'favorites',
          columns: ['likes'],
          where: 'id = ?',
          whereArgs: [postId],
        );
        int likes = 0;
        if (result.isNotEmpty) {
          likes = result.first['likes'] as int;
        }
        final int newLikes = likes + 1;
        await txn.insert('favorites', {
          'id': postId,
          'likes': newLikes,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      });
      return true;
    }catch(e){
      return false;
    }

  }

  @override
  Future<Map<int, int>?> getLikeCounts(List<int> postIds) async {
    try{
      if (postIds.isEmpty) {
        return {};
      }
      final ids = List.filled(postIds.length, '?').join(',');
      final List<Map<String, dynamic>> result = await _database.query(
        'favorites',
        columns: ['id', 'likes'],
        where: 'id IN ($ids)',
        whereArgs: postIds,
      );
      final likes = {
        for (final row in result) row['id'] as int: row['likes'] as int
      };
      return likes;
    }catch(e){
      return null;
    }

  }
}
