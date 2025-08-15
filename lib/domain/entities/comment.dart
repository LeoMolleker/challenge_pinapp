import 'package:equatable/equatable.dart';

class Comment extends Equatable{
  final int postId;
  final int id;
  final String? name;
  final String? email;
  final String? body;

  const Comment({
    required this.postId,
    required this.id,
    this.name,
    this.email,
    this.body,
  });

  @override
  List<Object?> get props => [postId, id, name, email, body];
}
