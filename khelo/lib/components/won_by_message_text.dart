import 'package:flutter/cupertino.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class WonByMessageText extends StatelessWidget {
  final String teamName;
  final int difference;
  final String trailingText;

  const WonByMessageText({
    super.key,
    required this.teamName,
    required this.difference,
    required this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        text: teamName,
        style:
            AppTextStyle.header4.copyWith(color: context.colorScheme.primary),
        children: [
          TextSpan(
              text: context.l10n.score_board_won_by_title,
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textSecondary)),
          TextSpan(
            text: "$difference",
          ),
          TextSpan(
            text: trailingText,
          ),
        ]));
  }
}