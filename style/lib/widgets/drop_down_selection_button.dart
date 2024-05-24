import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class DropDownSelectionButton extends StatelessWidget {
  final String? headerText;
  final String? headerImage;
  final String? buttonText;
  final String buttonPlaceHolder;
  final bool showTrailingIcon;
  final Function()? onButtonTap;

  const DropDownSelectionButton({
    super.key,
    this.headerText,
    this.headerImage,
    this.buttonText,
    required this.buttonPlaceHolder,
    this.showTrailingIcon = false,
    this.onButtonTap,
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
          onTap: onButtonTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colorScheme.outline)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    buttonText ?? buttonPlaceHolder,
                    style: AppTextStyle.subtitle3.copyWith(
                        color: buttonText != null
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
