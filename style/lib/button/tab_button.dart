import 'package:flutter/material.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class TabButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final GlobalKey? globalKey;
  final bool selected;

  const TabButton(
    this.text, {
    super.key,
    required this.onTap,
    this.globalKey,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return OnTapScale(
      onTap: onTap,
      child: Container(
        key: globalKey,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? context.colorScheme.primary
              : context.colorScheme.containerLow,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: AppTextStyle.body2.copyWith(
            color: selected
                ? context.colorScheme.onPrimary
                : context.colorScheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
