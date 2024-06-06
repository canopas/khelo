import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class OverScoreView extends StatelessWidget {
  final List<BallScoreModel> over;
  final double size;

  const OverScoreView({super.key, required this.over, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: over.map((ball) {
        return BallScoreView(
          ball: ball,
          size: size,
        );
      }).toList(),
    );
  }
}

class BallScoreView extends StatelessWidget {
  final BallScoreModel ball;
  final double size;

  const BallScoreView({super.key, required this.ball, this.size = 40});

  @override
  Widget build(BuildContext context) {
    final (title, tint, textColor) = _getTintAndTextByBall(context, ball);
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tint,
        shape: BoxShape.circle,
      ),
      child: Text(
        title,
        style: AppTextStyle.caption.copyWith(color: textColor),
      ),
    );
  }

  (String, Color, Color) _getTintAndTextByBall(
      BuildContext context, BallScoreModel ball) {
    if (ball.wicket_type != null) {
      if (ball.wicket_type == WicketType.retired ||
          ball.wicket_type == WicketType.timedOut ||
          ball.wicket_type == WicketType.retiredHurt) {
        final title = ball.wicket_type == WicketType.retiredHurt
            ? context.l10n.wicket_type_short_retired_hurt_title
            : ball.wicket_type == WicketType.retired
                ? context.l10n.wicket_type_short_retired_title
                : context.l10n.wicket_type_short_timed_out_title;
        return (
          title,
          Colors.transparent,
          ball.wicket_type == WicketType.retiredHurt
              ? context.colorScheme.textPrimary
              : context.colorScheme.alert
        );
      }
      return (
        context.l10n.match_scorecard_wicket_short_text,
        context.colorScheme.alert,
        context.colorScheme.textInversePrimary
      );
    } else {
      return (
        "${ball.runs_scored}",
        ball.is_four
            ? context.colorScheme.secondary
            : ball.is_six
                ? context.colorScheme.primary
                : context.colorScheme.containerLow,
        (ball.is_four || ball.is_six)
            ? context.colorScheme.onPrimary
            : context.colorScheme.textDisabled
      );
    }
  }
}
