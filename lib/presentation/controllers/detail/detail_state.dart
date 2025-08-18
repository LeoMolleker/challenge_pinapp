import 'package:challenge_pinapp/presentation/controllers/worker.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/comment.dart';

class DetailState extends Equatable {
  const DetailState({this.isLiked, this.comments = const Loading(), this.like = const Loading()});

  final Worker<List<Comment>> comments;
  final Worker<bool> like;
  final bool? isLiked;

  DetailState copyWith({
    Worker<List<Comment>>? comments,
    Worker<bool>? like,
    bool? isLiked,
  }) {
    return DetailState(
      comments: comments ?? this.comments,
      like: like ?? this.like,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  List<Object?> get props => [comments, like, isLiked];
}
