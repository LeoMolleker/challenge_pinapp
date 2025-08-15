import 'package:challenge_pinapp/core/constants/app_dimensions.dart';
import 'package:challenge_pinapp/core/extensions/context_extension.dart';
import 'package:challenge_pinapp/core/extensions/style_extension.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppDimensions.spaceLarge,
        children: [
          CircularProgressIndicator(),
          Text(message, style: context.bodyLargeTheme?.secondary),
        ],
      ),
    );
  }
}
