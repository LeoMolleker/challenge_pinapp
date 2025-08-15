import 'package:equatable/equatable.dart';

import '../core/app_labels.dart';

abstract class Failure with EquatableMixin {
  final String title;
  final String? description;

  Failure({required this.title, this.description});

  @override
  List<Object?> get props => [title, description];
}

class PostFailure extends Failure {
  PostFailure()
    : super(
        title: AppLabels.failedPostsTitle,
        description: AppLabels.failedPostDescription,
      );
}

class CommentsFailure extends Failure {
  CommentsFailure()
      : super(
    title: AppLabels.failedCommentsTitle,
    description: AppLabels.failedCommentsDescription,
  );
}
