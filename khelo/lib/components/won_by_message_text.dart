import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class WonByMessageText extends StatelessWidget {
  final MatchResult? matchResult;
  final TextStyle? textStyle;

  const WonByMessageText({
    super.key,
    this.matchResult,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (matchResult == null) {
      return const SizedBox();
    }
    if (matchResult!.winType == WinnerByType.tie) {
      return Text(context.l10n.score_board_match_tied_text,
          style: textStyle ??
              AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary));
    }
    return Text.rich(TextSpan(
        text: matchResult!.teamName,
        style: textStyle ??
            AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
        children: [
          TextSpan(
              text: context.l10n.score_board_won_by_title,
              style: textStyle ??
                  AppTextStyle.body2
                      .copyWith(color: context.colorScheme.textDisabled)),
          TextSpan(
            text: matchResult!.winType
                .getString(context, matchResult!.difference),
          ),
        ]));
  }
}
