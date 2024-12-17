import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class MatchGroupTag extends StatelessWidget {
  final MatchGroup tag;

  const MatchGroupTag({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          color: context.colorScheme.primary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          tag.getString(context),
          style: TextStyle(
            fontFamily: AppTextStyle.poppinsFontFamily,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
