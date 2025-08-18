import 'package:challenge_pinapp/presentation/controllers/detail/detail_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/controllers/home/home_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/controllers/worker.dart';
import 'package:challenge_pinapp/presentation/ui/core/extensions/context_extension.dart';
import 'package:challenge_pinapp/presentation/ui/core/extensions/style_extension.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/comment_card.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/loading_indicator.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/result_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/comment.dart';
import '../../controllers/detail/detail_state.dart';
import '../core/constants/app_dimensions.dart';
import '../core/constants/ui_labels.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.postId, required this.canLike});

  final int postId;
  final bool canLike;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UiLabels.commentAppBarTitle, style: context.titleLargeTheme?.black.bold),
        centerTitle: true,
      ),
      body: BlocListener<DetailBloc, DetailState>(
        listenWhen: (previous, current) =>
            (current.like.isSuccess || current.like.isError) && previous.like != current.like,
        listener: (BuildContext context, DetailState state) {
          if (state.like.isSuccess) {
            _showDialog(context: context, text: UiLabels.likeSuccess, backgroundColor: Colors.green);
            context.read<HomeBloc>().updatePostsLikes(postId);
            return;
          }
          _showDialog(context: context, text: state.like.error!.title, backgroundColor: Colors.red);
        },
        child: BlocBuilder<DetailBloc, DetailState>(
          buildWhen: (previous, current) => previous.comments != current.comments,
          builder: (context, state) => switch (state.comments) {
            Success<List<Comment>>() => () {
              final comments = state.comments.value!;
              return comments.isEmpty
                  ? ResultIndicator.empty(
                      title: UiLabels.emptyCommentsTitle,
                      description: UiLabels.emptyCommentsDescription,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceLarge),
                      child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(top: AppDimensions.spaceLarge),
                          child: CommentCard(comment: comments[index]),
                        ),
                      ),
                    );
            }(),

            Loading<List<Comment>>() => LoadingIndicator(message: UiLabels.loadingComments),

            Error<List<Comment>>() => ResultIndicator.error(
              title: state.comments.error!.title,
              description: state.comments.error!.description,
            ),
          },
        ),
      ),
      floatingActionButton: canLike
          ? BlocBuilder<DetailBloc, DetailState>(
              buildWhen: (previous, current) => previous.comments != current.comments,
              builder: (context, state) => (state.comments.isSuccess)
                  ? DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () {
                          context.read<DetailBloc>().likePost(postId);
                        },
                        icon: const Icon(Icons.favorite, color: Colors.red),
                      ),
                    )
                  : SizedBox.shrink(),
            )
          : null,
    );
  }

  void _showDialog({required BuildContext context, required String text, required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
        margin: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceLarge, vertical: AppDimensions.spaceMedium),
        content: Text(text, style: context.bodyLargeTheme?.white),
      ),
    );
  }
}
