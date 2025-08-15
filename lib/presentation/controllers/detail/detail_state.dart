import 'package:challenge_pinapp/presentation/controllers/worker.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/comment.dart';

class DetailState extends Equatable {
  const DetailState({this.comments = const Loading()});

  final Worker<List<Comment>> comments;

  DetailState copyWith({
    Worker<List<Comment>>? comments,
  }) {
    return DetailState(
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object?> get props => [comments];
}
