import '../../../domain/entities/post.dart';
import '../worker.dart';

class HomeState {
  final Worker<List<Post>> posts;
  final String searchValue;

  HomeState({this.posts = const Loading<List<Post>>(), this.searchValue = ''});

  HomeState copyWith({Worker<List<Post>>? posts, String? searchValue}) =>
      HomeState(
        posts: posts ?? this.posts,
        searchValue: searchValue ?? this.searchValue,
      );

  List<Post> filteredPosts() => searchValue.isEmpty
      ? posts.value!
      : posts.value!
            .where(
              (post) =>
                  post.title!.toLowerCase().contains(searchValue.toLowerCase()),
            )
            .toList();
}
