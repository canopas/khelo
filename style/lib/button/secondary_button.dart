import 'package:flutter/material.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final Function()? onPressed;

  const SecondaryButton(
    this.text, {
    super.key,
    this.enabled = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OnTapScale(
      onTap: onPressed,
      enabled: enabled,
      child: Material(
        type: MaterialType.transparency,
        child: Chip(
          label: Text(
            text,
            style: AppTextStyle.body2.copyWith(
                color: enabled
                    ? context.colorScheme.primary
                    : Color.alphaBlend(
                        context.colorScheme.primary.withValues(alpha: 0.5),
                        context.colorScheme.surface)),
          ),
          backgroundColor: context.colorScheme.containerLowOnSurface,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          side: const BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
