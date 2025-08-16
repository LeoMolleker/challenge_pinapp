import 'package:challenge_pinapp/presentation/controllers/detail/detail_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/controllers/home/home_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/controllers/worker.dart';
import 'package:challenge_pinapp/presentation/ui/core/extensions/context_extension.dart';
import 'package:challenge_pinapp/presentation/ui/core/extensions/style_extension.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/loading_indicator.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/result_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/comment.dart';
import '../../controllers/detail/detail_state.dart';
import '../core/constants/app_dimensions.dart';
import '../core/constants/ui_labels.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments', style: context.titleLargeTheme?.black.bold), centerTitle: true),
      body: BlocListener<DetailBloc, DetailState>(
        listenWhen: (previous, current) =>
        (current.likeStatus == LikeStatus.success ||
            current.likeStatus == LikeStatus.failure) && previous.likeStatus != current.likeStatus,
        listener: (BuildContext context, DetailState state) {
          if(state.likeStatus == LikeStatus.success){
            _showDialog(context: context, text: UiLabels.likeSuccess, backgroundColor: Colors.green);
            context.read<HomeBloc>().updatePostsLikes(postId);
            return;
          }
          _showDialog(context: context, text: UiLabels.likeError, backgroundColor: Colors.red);
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
                          child: Card(
                            color: Colors.white,
                            elevation: AppDimensions.postCardElevation,
                            child: Padding(
                              padding: const EdgeInsets.all(AppDimensions.spaceMedium),
                              child: ListTile(
                                title: comments[index].name?.isNotEmpty == true
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        spacing: AppDimensions.spaceLarge,
                                        children: [
                                          CircleAvatar(child: Icon(Icons.person)),
                                          Text(
                                            comments[index].email!,
                                            style: context.bodyLargeTheme?.secondary,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      )
                                    : null,
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: AppDimensions.spaceLarge),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: AppDimensions.spaceMedium,
                                    children: [
                                      if (comments[index].name?.isNotEmpty == true)
                                        Text(
                                          comments[index].name!,
                                          style: context.bodyLargeTheme?.black.bold,
                                          textAlign: TextAlign.justify,
                                        ),
                                      if (comments[index].body?.isNotEmpty == true)
                                        Text(
                                          comments[index].body!,
                                          style: context.bodyLargeTheme?.black,
                                          textAlign: TextAlign.justify,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
      floatingActionButton: DecoratedBox(
        decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        child: IconButton(
          onPressed: () {
            context.read<DetailBloc>().likePost(postId);
          },
          icon: const Icon(Icons.favorite, color: Colors.red),
        ),
      ),
    );
  }

  void _showDialog({required BuildContext context, required String text, required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceLarge, vertical: AppDimensions.spaceMedium),
        content: Text(text, style: context.bodyLargeTheme?.white),
      ),
    );
  }
}
