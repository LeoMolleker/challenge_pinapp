import 'package:challenge_pinapp/core/extensions/context_extension.dart';
import 'package:challenge_pinapp/core/extensions/style_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../models/button_content.dart';

class ResultIndicator extends StatelessWidget {
  const ResultIndicator({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.button,
    required this.iconColor,
  });

  const ResultIndicator.error({
    super.key,
    required this.title,
    this.description,
    this.button,
  }) : icon = Icons.error_outline,
       iconColor = Colors.red;

  const ResultIndicator.empty({
    super.key,
    required this.title,
    this.description,
    this.button,
  }) : icon = Icons.search_off,
       iconColor = AppColors.grey;

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? description;
  final ButtonContent? button;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceXLarge,
      ),
      child: SizedBox(
        child: Column(
          spacing: AppDimensions.spaceXLarge,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: AppDimensions.iconResultIndicatorSize),
            Text(title, style: context.headlineLargeTheme?.black.bold, textAlign: TextAlign.center,),
            if (description?.isNotEmpty == true)
              Text(
                description!,
                style: context.bodyLargeTheme?.secondary,
                textAlign: TextAlign.center,
              ),
            if (button != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: button!.onPressed,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) => AppColors.primary,
                    ),

                    shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
                      (Set<WidgetState> states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusSmall,
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    button!.text,
                    style: context.bodyLargeTheme?.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
