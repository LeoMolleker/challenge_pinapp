import 'package:challenge_pinapp/presentation/controllers/home/home_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/controllers/home/home_state.dart';
import 'package:challenge_pinapp/presentation/ui/core/extensions/context_extension.dart';
import 'package:challenge_pinapp/presentation/ui/core/extensions/style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';
import '../core/constants/app_dimensions.dart';
import '../core/constants/routes_names.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesNames.detail, arguments: {'postId': post.id, 'canLike': post.likes != null});
      },
      child: Card(
        color: Colors.white,
        elevation: AppDimensions.postCardElevation,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spaceLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppDimensions.spaceLarge,
            children: [
              if (post.title?.isNotEmpty == true)
                Text(post.title!, textAlign: TextAlign.start, style: context.titleLargeTheme?.black.bold),
              if (post.body?.isNotEmpty == true)
                Text(post.body!, textAlign: TextAlign.justify, style: context.bodyLargeTheme?.secondary),
              if (post.likes != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: AppDimensions.spaceSmall,
                  children: [
                    Icon(Icons.favorite, color: Colors.red),
                    BlocSelector<HomeBloc, HomeState, Post>(
                      selector: (HomeState state) => state.posts.value!.firstWhere((p) => p.id == post.id),
                      builder: (BuildContext context, Post updatedPost) =>
                          Text(updatedPost.likes.toString(), style: context.bodyLargeTheme?.secondary),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
