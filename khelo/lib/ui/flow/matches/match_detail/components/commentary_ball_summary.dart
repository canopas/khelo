import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/over_score_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class CommentaryBallSummary extends ConsumerWidget {
  final MatchDetailTabState state;
  final BallScoreModel ball;
  final bool showBallScore;

  const CommentaryBallSummary({
    super.key,
    required this.state,
    required this.ball,
    this.showBallScore = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
        if (showBallScore) ...[BallScoreView(ball: ball, size: 24)]
      ],
    );
  }

  Widget _ballSummaryTextView(
    BuildContext context,
  ) {
    final (batsMan, bowler, fielder, outPlayer) = _getPlayerName(state, ball);
    final wicketTakerText = ball.wicket_type != null
        ? " ${ball.wicket_type?.getString(context)}${fielder != null ? context.l10n.match_commentary_by_fielder_text(fielder) : ""}!!"
        : "";
    final (run, ballCount, fours, sixes) =
        _getBatsmanSummary(context, state, ball);

    String batsManSummary = " ";
    if (ball.wicket_type != null) {
      batsManSummary += outPlayer ?? batsMan;

      if (ball.wicket_type != WicketType.retired &&
          ball.wicket_type != WicketType.retiredHurt &&
          ball.wicket_type != WicketType.timedOut) {
        batsManSummary +=
            context.l10n.match_commentary_b_bowler_text(bowler ?? "");

        if (fielder != null) {
          batsManSummary +=
              context.l10n.match_commentary_c_fielder_text(fielder);
        }
      }
      batsManSummary += context.l10n
          .match_commentary_runs_fours_sixes_text(run, ballCount, fours, sixes);
    }
    return Text.rich(
      style:
          AppTextStyle.body1.copyWith(color: context.colorScheme.textDisabled),
      TextSpan(
          text: context.l10n
              .match_commentary_bowler_to_batsman_text(bowler ?? "", batsMan),
          children: [
            TextSpan(
              text: " ${_getBallResult(context, ball)}",
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

  (String, String?, String?, String?) _getPlayerName(
      MatchDetailTabState state, BallScoreModel ball) {
    final battingTeamId = ball.inning_id == state.firstInning?.id
        ? state.firstInning?.team_id
        : state.secondInning?.team_id;
    final bowlingTeamId = ball.inning_id == state.firstInning?.id
        ? state.secondInning?.team_id
        : state.firstInning?.team_id;
    final battingSquad = state.match?.teams
        .firstWhere((element) => battingTeamId == element.team.id)
        .team
        .players;
    final bowlingSquad = state.match?.teams
        .firstWhere((element) => bowlingTeamId == element.team.id)
        .team
        .players;

    final bowlerName = bowlingSquad
        ?.firstWhere((element) => element.id == ball.bowler_id)
        .name;

    final fielderName = bowlingSquad
        ?.where((element) => element.id == ball.wicket_taker_id)
        .firstOrNull
        ?.name;

    final batsmanName = battingSquad
        ?.firstWhere((element) => element.id == ball.batsman_id)
        .name;
    String? outPlayerName;
    if (ball.player_out_id != ball.batsman_id) {
      outPlayerName = battingSquad
          ?.where((element) => element.id == ball.player_out_id)
          .firstOrNull
          ?.name;
    }
    return (batsmanName ?? "", bowlerName, fielderName, outPlayerName);
  }

  (int, int, int, int) _getBatsmanSummary(
      BuildContext context, MatchDetailTabState state, BallScoreModel ball) {
    if (ball.wicket_type == null) {
      return (0, 0, 0, 0);
    }
    final score = state.ballScores.where((element) =>
        element.inning_id == ball.inning_id &&
        element.batsman_id == ball.player_out_id &&
        element.extras_type != ExtrasType.penaltyRun &&
        element.wicket_type == WicketType.retired &&
        element.wicket_type == WicketType.retiredHurt &&
        element.wicket_type == WicketType.timedOut);

    int fours = 0;
    int sixes = 0;
    int ballCount = 0;
    int run = 0;
    for (var element in score) {
      if (element.extras_type != ExtrasType.wide) {
        ballCount = ballCount + 1;
      }

      if (element.extras_type == ExtrasType.noBall) {
        final extra = (element.extras_awarded ?? 0) > 1
            ? (element.extras_awarded ?? 1) - 1
            : 0;
        run = run + extra;
      }
      run = run + element.runs_scored;
      if (element.is_six && element.runs_scored == 6) {
        sixes = sixes + 1;
      } else if (element.is_four && element.runs_scored == 4) {
        fours = fours + 1;
      }
    }

    return (run, ballCount, fours, sixes);
  }

  String _getBallResult(BuildContext context, BallScoreModel ball) {
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
