import 'package:flutter/material.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/indicator/progress_indicator.dart';

import '../text/app_text_style.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final EdgeInsets edgeInsets;
  final bool expanded;
  final bool progress;
  final bool enabled;
  final bool secondaryTint;
  final Color? foreground;
  final Color? background;
  final Function()? onPressed;

  const PrimaryButton(
    this.text, {
    super.key,
    this.onPressed,
    this.edgeInsets =
        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    this.expanded = true,
    this.enabled = true,
    this.progress = false,
    this.secondaryTint = false,
    this.background,
    this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    final AppColorScheme colorScheme = appColorSchemeOf(context);
    final tappable = !progress && enabled;

    final bg = background ??
        (secondaryTint ? colorScheme.containerLow : colorScheme.primary);
    final bgColor = tappable || secondaryTint
        ? bg
        : Color.alphaBlend(bg.withOpacity(0.4), colorScheme.surface);

    final fg = foreground ??
        (secondaryTint ? colorScheme.primary : colorScheme.onPrimary);
    final fgColor = tappable
        ? fg
        : Color.alphaBlend(fg.withOpacity(0.5), colorScheme.surface);

    return OnTapScale(
      onTap: () {
        onPressed?.call();
      },
      enabled: tappable,
      child: Container(
        width: expanded ? double.infinity : null,
        constraints: const BoxConstraints(
          minHeight: 48,
          minWidth: 88,
        ),
        padding: edgeInsets,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: progress,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: AppProgressIndicator(
                  size: AppProgressIndicatorSize.small,
                  color: fgColor,
                ),
              ),
            ),
            Text(
              text,
              style: AppTextStyle.button.copyWith(
                color: fgColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
