import 'package:challenge_pinapp/core/extensions/context_extension.dart';
import 'package:challenge_pinapp/core/extensions/style_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/routes_names.dart';
import '../../../domain/entities/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesNames.detail, arguments: post.id);
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
                Text(
                  post.title!,
                  textAlign: TextAlign.start,
                  style: context.titleLargeTheme?.black.bold,
                ),
              if (post.body?.isNotEmpty == true)
                Text(
                  post.body!,
                  textAlign: TextAlign.justify,
                  style: context.bodyLargeTheme?.secondary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
