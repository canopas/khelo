import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class MatchStatusTag extends StatelessWidget {
  final MatchStatus status;
  final Function()? onTap;

  const MatchStatusTag({
    super.key,
    this.onTap,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return OnTapScale(
      onTap: onTap,
      enabled: onTap != null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          color: status.getColor(context),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            if (onTap != null) ...[
              status == MatchStatus.yetToStart
                  ? Icon(
                      CupertinoIcons.play,
                      size: 16,
                      color: context.colorScheme.onPrimary,
                    )
                  : SvgPicture.asset(
                      Assets.images.icEdit,
                      height: 16,
                      width: 16,
                      colorFilter: ColorFilter.mode(
                          context.colorScheme.onPrimary, BlendMode.srcIn),
                    ),
              const SizedBox(width: 2)
            ],
            Text(
              status.getString(context),
              style: AppTextStyle.caption
                  .copyWith(color: context.colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
