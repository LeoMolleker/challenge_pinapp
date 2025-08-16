import 'package:challenge_pinapp/presentation/ui/core/extensions/context_extension.dart';
import 'package:challenge_pinapp/presentation/ui/core/extensions/style_extension.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/comment.dart';
import '../core/constants/app_dimensions.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: AppDimensions.postCardElevation,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceMedium),
        child: ListTile(
          title: comment.name?.isNotEmpty == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: AppDimensions.spaceLarge,
                  children: [
                    CircleAvatar(child: Icon(Icons.person)),
                    Text(comment.email!, style: context.bodyLargeTheme?.secondary, textAlign: TextAlign.justify),
                  ],
                )
              : null,
          subtitle: Padding(
            padding: const EdgeInsets.only(top: AppDimensions.spaceLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppDimensions.spaceMedium,
              children: [
                if (comment.name?.isNotEmpty == true)
                  Text(comment.name!, style: context.bodyLargeTheme?.black.bold, textAlign: TextAlign.justify),
                if (comment.body?.isNotEmpty == true)
                  Text(comment.body!, style: context.bodyLargeTheme?.black, textAlign: TextAlign.justify),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
