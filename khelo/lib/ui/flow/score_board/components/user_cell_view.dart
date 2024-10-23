import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class UserCellView extends StatelessWidget {
  final String? imageUrl;
  final String? initial;
  final String title;
  final double? outerPadding;
  final String? tag;
  final String? subtitle;
  final bool disableCell;
  final bool isSelected;
  final VoidCallback onTap;

  const UserCellView({
    super.key,
    this.imageUrl,
    this.initial,
    this.outerPadding,
    this.tag,
    this.subtitle,
    this.disableCell = false,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final double widgetWidth = 121;
  final double padding = 16.0;
  final double spacingBetweenElements = 16.0;

  @override
  Widget build(BuildContext context) {
    int maxOversInRow = _calculateMaxOversInRow(context);
    double approxCellWidth = _calculateCellWidth(context, maxOversInRow);

    return OnTapScale(
      enabled: !disableCell,
      onTap: onTap,
      child: Container(
        width: approxCellWidth,
        constraints: const BoxConstraints(minHeight: 126),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: disableCell
              ? Colors.transparent
              : context.colorScheme.containerLow,
          border: Border.all(
              color: isSelected
                  ? context.colorScheme.primary
                  : disableCell
                      ? context.colorScheme.outline
                      : Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            initial != null
                ? ImageAvatar(
                    imageUrl: imageUrl,
                    initial: initial ?? "?",
                    size: 40,
                  )
                : _profilePlaceHolder(context, size: 40),
            const SizedBox(height: 16),
            Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            if (subtitle != null) ...[
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: AppTextStyle.body1
                    .copyWith(color: context.colorScheme.textDisabled),
              )
            ],
            if (tag != null) ...[
              Text(
                tag!,
                textAlign: TextAlign.center,
                style: AppTextStyle.body1
                    .copyWith(color: context.colorScheme.alert),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _profilePlaceHolder(
    BuildContext context, {
    required double size,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: context.colorScheme.containerHigh,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        Assets.images.icProfile,
        height: 24,
        width: 24,
        colorFilter: ColorFilter.mode(
          context.colorScheme.textPrimary,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  int _calculateMaxOversInRow(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width -
        (context.mediaQueryPadding.horizontal +
            ((outerPadding ?? padding) * 2));

    int maxOversInRow =
        (screenWidth / (widgetWidth + spacingBetweenElements)).floor();
    return maxOversInRow > 0 ? maxOversInRow : 1;
  }

  double _calculateCellWidth(BuildContext context, int maxOversInRow) {
    double screenWidth = MediaQuery.of(context).size.width -
        (context.mediaQueryPadding.horizontal +
            ((outerPadding ?? padding) * 2));
    double internalPadding = ((maxOversInRow - 1) * spacingBetweenElements);
    return ((screenWidth - internalPadding) / maxOversInRow);
  }
}
