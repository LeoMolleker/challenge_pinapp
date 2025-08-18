import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int userId;
  final int id;
  final String? title;
  final String? body;
  final bool? isLiked;

  const Post({
    required this.userId,
    required this.id,
    this.title,
    this.body,
    required this.isLiked,
  });

  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
    bool? isLiked,
  }){
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  List<Object?> get props => [userId, id, title, body, isLiked];
}
