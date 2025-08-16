import 'package:challenge_pinapp/presentation/controllers/worker.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/comment.dart';

enum LikeStatus { initial, loading, success, failure }

class DetailState extends Equatable {
  const DetailState({this.comments = const Loading(), this.likeStatus = LikeStatus.initial});

  final Worker<List<Comment>> comments;
  final LikeStatus likeStatus;

  DetailState copyWith({
    Worker<List<Comment>>? comments,
    LikeStatus? likeStatus,
  }) {
    return DetailState(
      comments: comments ?? this.comments,
      likeStatus: likeStatus ?? this.likeStatus,
    );
  }

  @override
  List<Object?> get props => [comments, likeStatus];
}
