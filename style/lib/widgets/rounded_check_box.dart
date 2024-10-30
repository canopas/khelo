import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class RoundedCheckBox extends StatelessWidget {
  final bool isSelected;
  final Function(bool)? onTap;

  const RoundedCheckBox({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OnTapScale(
      enabled: onTap != null,
      onTap: () => onTap?.call(!isSelected),
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
            color:
                isSelected ? context.colorScheme.primary : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
                width: 2,
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.containerHigh)),
        child: isSelected
            ? Icon(
                CupertinoIcons.checkmark_alt,
                color: context.colorScheme.onPrimary,
                size: 18,
              )
            : null,
      ),
    );
  }
}

class RoundedCheckBoxTile extends StatelessWidget {
  final bool isSelected;
  final String title;
  final TextStyle? style;
  final Function(bool) onTap;

  const RoundedCheckBoxTile({
    super.key,
    required this.title,
    required this.isSelected,
    this.style,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(!isSelected),
      child: Row(
        children: [
          RoundedCheckBox(
            isSelected: isSelected,
            onTap: onTap,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: style ??
                  AppTextStyle.body1
                      .copyWith(color: context.colorScheme.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
