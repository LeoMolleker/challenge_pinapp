import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int userId;
  final int id;
  final String? title;
  final String? body;
  final int? likes;

  const Post({
    required this.userId,
    required this.id,
    this.title,
    this.body,
    required this.likes,
  });

  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
    int? likes,
  }){
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      likes: likes ?? this.likes,
    );
  }

  @override
  List<Object?> get props => [userId, id, title, body, likes];
}
