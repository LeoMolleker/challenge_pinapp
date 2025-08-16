import 'package:challenge_pinapp/presentation/controllers/worker.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/comment.dart';

class DetailState extends Equatable {
  const DetailState({this.comments = const Loading(), this.like = const Loading()});

  final Worker<List<Comment>> comments;
  final Worker<bool> like;

  DetailState copyWith({
    Worker<List<Comment>>? comments,
    Worker<bool>? like,
  }) {
    return DetailState(
      comments: comments ?? this.comments,
      like: like ?? this.like,
    );
  }

  @override
  List<Object?> get props => [comments, like];
}
