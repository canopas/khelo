import 'package:collection/collection.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/over_score_view.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class CommentaryBallSummary extends StatelessWidget {
  final OverSummary overSummary;
  final BallScoreModel ball;
  final bool showBallScore;

  const CommentaryBallSummary({
    super.key,
    required this.overSummary,
    required this.ball,
    this.showBallScore = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _ballNumberView(context),
          const SizedBox(width: 24),
          Expanded(child: _ballSummaryTextView(context)),
        ],
      ),
    );
  }

  Widget _ballNumberView(BuildContext context) {
    return Column(
      children: [
        Text("${ball.over_number - 1}.${ball.ball_number}",
            style: showBallScore
                ? AppTextStyle.caption
                    .copyWith(color: context.colorScheme.textDisabled)
                : AppTextStyle.body1
                    .copyWith(color: context.colorScheme.textDisabled)),
        if (showBallScore) ...[
          const SizedBox(height: 4),
          BallScoreView(ball: ball, size: 24)
        ]
      ],
    );
  }

  Widget _ballSummaryTextView(BuildContext context) {
    final outPlayerSummary = overSummary.outPlayers
        .firstWhereOrNull((element) => element.player.id == ball.player_out_id);
    final wicketTakerText = ball.wicket_type != null
        ? " ${ball.wicket_type?.getString(context)}${outPlayerSummary?.catchBy != null ? context.l10n.match_commentary_by_fielder_text(outPlayerSummary?.catchBy?.name ?? "") : ""}!!"
        : "";

    final bowlerName = overSummary.bowler.player.name;
    final batsmanName = _getBatsmanNameById(ball.batsman_id);

    String batsManSummary = " ";
    if (outPlayerSummary != null && outPlayerSummary.wicketType != null) {
      batsManSummary += outPlayerSummary.player.name ?? '';

      if (outPlayerSummary.wicketType != WicketType.retired &&
          outPlayerSummary.wicketType != WicketType.retiredHurt &&
          outPlayerSummary.wicketType != WicketType.timedOut) {
        batsManSummary += context.l10n.match_commentary_b_bowler_text(
            outPlayerSummary.ballBy?.name ?? "");

        if (outPlayerSummary.catchBy != null) {
          batsManSummary += context.l10n.match_commentary_c_fielder_text(
              outPlayerSummary.catchBy?.name ?? "");
        }
      }
      batsManSummary += context.l10n.match_commentary_runs_fours_sixes_text(
          outPlayerSummary.runs,
          outPlayerSummary.ballFaced,
          outPlayerSummary.fours,
          outPlayerSummary.sixes);
    }
    return Text.rich(
      style:
          AppTextStyle.body1.copyWith(color: context.colorScheme.textDisabled),
      TextSpan(
          text: context.l10n.match_commentary_bowler_to_batsman_text(
              bowlerName ?? '', batsmanName),
          children: [
            TextSpan(
              text: " ${_getBallResult(context)}",
              style: AppTextStyle.body1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            TextSpan(
              text: wicketTakerText,
            ),
            TextSpan(
              text: batsManSummary,
              style: AppTextStyle.body1
                  .copyWith(color: context.colorScheme.textPrimary),
            )
          ]),
    );
  }

  String _getBatsmanNameById(String batsmanId) {
    if (overSummary.striker.player.id == batsmanId) {
      return overSummary.striker.player.name ?? '';
    } else if (overSummary.nonStriker.player.id == batsmanId) {
      return overSummary.nonStriker.player.name ?? '';
    } else if (overSummary.outPlayers
        .map((e) => e.player.id)
        .contains(batsmanId)) {
      return overSummary.outPlayers
              .firstWhere((e) => e.player.id == batsmanId)
              .player
              .name ??
          '';
    } else {
      return "";
    }
  }

  String _getBallResult(BuildContext context) {
    if (ball.extras_type == null && ball.wicket_type == null) {
      if (ball.runs_scored == 4 && ball.is_four) {
        return context.l10n.match_commentary_four_text;
      } else if (ball.runs_scored == 6 && ball.is_six) {
        return context.l10n.match_commentary_six_text;
      } else {
        return context.l10n.match_commentary_runs_text(ball.runs_scored);
      }
    } else if (ball.extras_type != null &&
        ball.extras_type != ExtrasType.penaltyRun) {
      final totalRuns = (ball.extras_awarded ?? 0) + ball.runs_scored;
      return "${ball.extras_type!.getString(context)}${totalRuns > 1 ? "$totalRuns" : ""}";
    } else if (ball.wicket_type != null) {
      return context.l10n.match_commentary_out_text;
    } else {
      return "--";
    }
  }
}
