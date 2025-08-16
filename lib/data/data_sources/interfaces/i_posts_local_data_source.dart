abstract class IPostsLocalDataSource {
  Future<bool> likeComment(int postId);

  Future<Map<int, int>?> getLikeCounts(List<int> postIds);
}
