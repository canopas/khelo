import 'package:flutter/material.dart';
import 'package:style/extensions/context_extensions.dart';

import '../animations/on_tap_scale.dart';
import '../text/app_text_style.dart';

class ChipButton extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback? onTap;

  const ChipButton({
    super.key,
    this.isSelected = false,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OnTapScale(
      onTap: onTap,
      child: Chip(
        label: Text(
          title,
          style: AppTextStyle.body2.copyWith(
            color: isSelected
                ? context.colorScheme.onPrimary
                : context.colorScheme.textSecondary,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        side: const BorderSide(color: Colors.transparent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: isSelected
            ? context.colorScheme.primary
            : context.colorScheme.containerLowOnSurface,
      ),
    );
  }
}
