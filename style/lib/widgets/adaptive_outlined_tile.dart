import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class AdaptiveOutlinedTile extends StatelessWidget {
  final String? headerText;
  final String? headerImage;
  final String? title;
  final String placeholder;
  final bool showTrailingIcon;
  final Function()? onTap;

  const AdaptiveOutlinedTile({
    super.key,
    this.headerText,
    this.headerImage,
    this.title,
    required this.placeholder,
    this.showTrailingIcon = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerText != null) ...[
          Row(
            children: [
              if (headerImage != null) ...[
                SvgPicture.asset(
                  headerImage!,
                  colorFilter: ColorFilter.mode(
                      context.colorScheme.textDisabled, BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 4,
                )
              ],
              Text(
                headerText!,
                style: AppTextStyle.caption
                    .copyWith(color: context.colorScheme.textDisabled),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
        OnTapScale(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colorScheme.outline)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title ?? placeholder,
                    style: AppTextStyle.subtitle3.copyWith(
                        color: title != null
                            ? context.colorScheme.textPrimary
                            : context.colorScheme.textSecondary),
                  ),
                ),
                if (showTrailingIcon) ...[
                  SvgPicture.asset(
                    "assets/images/ic_arrow_down.svg",
                    height: 18,
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.textPrimary,
                      BlendMode.srcATop,
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
