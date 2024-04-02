import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class MatchStatusTag extends StatelessWidget {
  final MatchStatus status;
  const MatchStatusTag({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: status.getColor(context).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.getString(context),
        style:
            AppTextStyle.body2.copyWith(color: context.colorScheme.textPrimary),
      ),
    );
  }
}
