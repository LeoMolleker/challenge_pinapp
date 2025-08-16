
import 'package:challenge_pinapp/presentation/ui/core/extensions/context_extension.dart';
import 'package:challenge_pinapp/presentation/ui/core/extensions/style_extension.dart';
import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/constants/app_dimensions.dart';
import '../core/constants/ui_labels.dart';


class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({
    super.key,
    required this.showSuffixIcon,
    required this.onChanged,
    this.onSuffixPressed,
  });

  final bool showSuffixIcon;
  final void Function(String) onChanged;
  final void Function()? onSuffixPressed;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late TextEditingController _textFieldController;

  @override
  void initState() {
    _textFieldController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textFieldController,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: UiLabels.searchBarHint,
        hintStyle: context.bodyLargeTheme?.secondary,

        prefixIcon: Icon(Icons.search, color: AppColors.grey),
        suffixIcon: widget.showSuffixIcon
            ? IconButton(
                color: AppColors.grey,
                onPressed: () {
                  _textFieldController.clear();
                  widget.onSuffixPressed?.call();
                },
                icon: const Icon(Icons.close),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
      ),
    );
  }
}
