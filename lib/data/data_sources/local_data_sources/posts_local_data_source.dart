import 'package:sqflite/sqflite.dart';

import '../interfaces/i_posts_local_data_source.dart';

class PostsLocalDataSource extends IPostsLocalDataSource {
  final Database _database;

  PostsLocalDataSource(this._database);

  @override
  Future<bool> updateLikeStatus({required int postId, required bool isLiked}) async {
    try {
      await _database.insert('favorites', {
        'id': postId,
        'isLiked': isLiked ? 1 : 0,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Map<int, bool>?> getLikes(List<int> postIds) async {
    try {
      if (postIds.isEmpty) {
        return {};
      }
      final ids = List.filled(postIds.length, '?').join(',');
      final List<Map<String, dynamic>> result = await _database.query(
        'favorites',
        columns: ['id', 'isLiked'],
        where: 'id IN ($ids)',
        whereArgs: postIds,
      );
      final likes = {for (final row in result) row['id'] as int: row['isLiked'] == 1 ? true : false};
      return likes;
    } catch (e) {
      return null;
    }
  }
}
