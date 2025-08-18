abstract class IPostsLocalDataSource {
  Future<bool> updateLikeStatus({required int postId, required bool isLiked});

  Future<Map<int, bool>?> getLikes(List<int> postIds);
}
