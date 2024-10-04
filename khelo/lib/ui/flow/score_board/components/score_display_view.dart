import 'package:collection/collection.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/gen/assets.gen.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class ScoreDisplayView extends ConsumerWidget {
  final List<BallScoreModel> currentOverBall;
  final String? battingTeamName;
  final String? bowlingTeamName;
  final String overCountString;

  const ScoreDisplayView({
    super.key,
    required this.currentOverBall,
    required this.battingTeamName,
    required this.bowlingTeamName,
    required this.overCountString,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreBoardStateProvider);

    return Expanded(
      child: ListView(
        children: [
          _matchScoreView(context, state),
          const SizedBox(height: 32),
          Divider(height: 0, color: context.colorScheme.outline),
          _batsManDetailsView(context, state),
          _bowlerAndBallDetailView(context, state),
        ],
      ),
    );
  }

  Widget _teamName(
    BuildContext context, {
    required bool isBatting,
    String? inningString,
  }) {
    final teamName = isBatting
        ? (battingTeamName ?? "") +
            (inningString != null ? " - $inningString" : "")
        : bowlingTeamName ?? "";
    return Text(
      teamName,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.subtitle1
          .copyWith(color: context.colorScheme.textPrimary),
    );
  }

  Widget _matchScoreView(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    final inningString = state.match?.match_type == MatchType.testMatch
        ? (state.currentInning?.index == 1 || state.currentInning?.index == 2)
            ? context.l10n.common_first_inning_title
            : context.l10n.common_second_inning_title
        : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: context.colorScheme.containerLowOnSurface,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _teamName(context, isBatting: true, inningString: inningString),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '${state.currentInning?.total_runs ?? 0}/${state.otherInning?.total_wickets ?? 0}',
                      style: AppTextStyle.header1
                          .copyWith(color: context.colorScheme.textPrimary),
                    ),
                    TextSpan(
                      text:
                          '($overCountString/${state.match?.revised_target?.overs ?? state.match?.number_of_over})',
                      style: AppTextStyle.body1
                          .copyWith(color: context.colorScheme.textPrimary),
                    ),
                  ],
                ),
              ),
              _powerPlayTag(context, state)
            ],
          ),
          _runNeededText(context, state),
        ],
      ),
    );
  }

  Widget _powerPlayTag(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    final powerPlayText = _getPowerPlayText(context, state);
    if (powerPlayText != null) {
      return Text(
        powerPlayText,
        style: AppTextStyle.caption
            .copyWith(color: context.colorScheme.textDisabled),
      );
    } else {
      return const SizedBox();
    }
  }

  String? _getPowerPlayText(BuildContext context, ScoreBoardViewState state) {
    if (state.match?.power_play_overs1.contains(state.overCount) ?? false) {
      return context.l10n.power_play_text(1);
    } else if (state.match?.power_play_overs2.contains(state.overCount) ??
        false) {
      return context.l10n.power_play_text(2);
    } else if (state.match?.power_play_overs3.contains(state.overCount) ??
        false) {
      return context.l10n.power_play_text(3);
    }
    return null;
  }

  Widget _runNeededText(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    if (state.nextInning == null) {
      final requiredRun = getRequiredRun(state);
      final pendingOver = (state.match?.revised_target?.overs.toInt() ??
              state.match?.number_of_over ??
              0) -
          state.overCount;
      final pendingBall = (pendingOver * 6) + (6 - state.ballCount);
      return Text(
        state.match?.match_type == MatchType.testMatch
            ? context.l10n
                .score_board_need_run_text(requiredRun < 0 ? 0 : requiredRun)
            : context.l10n.score_board_run_need_in_ball_text(
                requiredRun < 0 ? 0 : requiredRun,
                pendingBall < 0 ? 0 : pendingBall),
        textAlign: TextAlign.center,
        style:
            AppTextStyle.caption.copyWith(color: context.colorScheme.secondary),
      );
    } else {
      return const SizedBox();
    }
  }

  int getRequiredRun(ScoreBoardViewState state) {
    final currentPlayingTeam = state.match?.teams.firstWhereOrNull(
        (element) => element.team.id == state.currentInning?.team_id);
    final otherTeam = state.match?.teams.firstWhereOrNull(
        (element) => element.team.id != currentPlayingTeam?.team.id);

    final revisedRun = state.match?.revised_target?.runs;

    return ((revisedRun ?? ((otherTeam?.run ?? 0) + 1))) -
        (currentPlayingTeam?.run ?? 0);
  }

  Widget _batsManDetailsView(BuildContext context, ScoreBoardViewState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _batManCellView(context, state, state.batsMans?.firstOrNull),
            VerticalDivider(
              color: context.colorScheme.outline,
            ),
            _batManCellView(context, state, state.batsMans?.elementAtOrNull(1)),
          ],
        ),
      ),
    );
  }

  Widget _batManCellView(
    BuildContext context,
    ScoreBoardViewState state,
    MatchPlayer? user,
  ) {
    bool isOnStrike = state.strikerId == user?.player.id;
    final (run, ball) =
        _getBatsManTotalRuns(state, user?.player.id ?? "INVALID ID");
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: isOnStrike ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: SvgPicture.asset(
                Assets.images.icBatSelected,
                height: 24,
                width: 24,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedDefaultTextStyle(
                    style: AppTextStyle.subtitle1.copyWith(
                        color: isOnStrike
                            ? context.colorScheme.secondary
                            : context.colorScheme.textPrimary),
                    overflow: TextOverflow.ellipsis,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      user?.player.name ??
                          context.l10n.score_board_player_title,
                    ),
                  ),
                  Text(
                    "$run($ball)",
                    style: AppTextStyle.body2
                        .copyWith(color: context.colorScheme.textDisabled),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  (int, int) _getBatsManTotalRuns(ScoreBoardViewState state, String batsManId) {
    final scoresList = state.currentScoresList
        .where((element) => element.batsman_id == batsManId);

    int totalRuns = scoresList
        .where((element) => (element.extras_type == ExtrasType.noBall ||
            element.extras_type == null))
        .fold(0, (sum, element) => sum + element.runs_scored);

    final batsManFacedBall = scoresList
        .where((element) => (element.extras_type != ExtrasType.wide))
        .length;

    return (totalRuns, batsManFacedBall);
  }

  Widget _bowlerAndBallDetailView(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: context.colorScheme.containerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _teamName(context, isBatting: false),
          ),
          const SizedBox(height: 8),
          _bowlerNameView(
              context,
              state.bowler?.player.name ??
                  context.l10n.score_board_player_title),
          const SizedBox(height: 16),
          _ballHistoryListView(context),
        ],
      ),
    );
  }

  Widget _bowlerNameView(BuildContext context, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: SvgPicture.asset(
                  Assets.images.icCricket,
                  height: 16,
                  width: 16,
                  colorFilter: ColorFilter.mode(
                      context.colorScheme.secondary, BlendMode.srcIn),
                )),
            TextSpan(
              text: ' $name',
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ballHistoryListView(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final ball in currentOverBall) ...[
            _ballView(context, ball),
            const SizedBox(width: 8)
          ]
        ],
      ),
    );
  }

  Widget _ballView(BuildContext context, BallScoreModel ball) {
    bool showCircle = ball.wicket_type != WicketType.retired &&
        ball.wicket_type != WicketType.retiredHurt &&
        ball.wicket_type != WicketType.timedOut;
    final (bgColor, tintColor) = _getBackGroundColorBasedOnBall(context, ball);
    if (!showCircle) {
      return Text(_getTextBasedOnBall(context, ball),
          style: AppTextStyle.body2
              .copyWith(color: context.colorScheme.textPrimary));
    }
    return Container(
      height: 48,
      width: 48,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
      ),
      child: Text(
        _getTextBasedOnBall(context, ball),
        style: AppTextStyle.body2.copyWith(color: tintColor),
      ),
    );
  }

  String _getTextBasedOnBall(BuildContext context, BallScoreModel ball) {
    if (ball.wicket_type != null) {
      if (ball.wicket_type == WicketType.retired) {
        return context.l10n.wicket_type_short_retired_title;
      } else if (ball.wicket_type == WicketType.retiredHurt) {
        return context.l10n.wicket_type_short_retired_hurt_title;
      } else if (ball.wicket_type == WicketType.timedOut) {
        return context.l10n.wicket_type_short_timed_out_title;
      } else {
        return context.l10n.score_board_wicket_short_text;
      }
    } else if (ball.extras_type != null) {
      switch (ball.extras_type!) {
        case ExtrasType.wide:
          return context.l10n.score_board_wide_ball_short_text;
        case ExtrasType.noBall:
          return context.l10n.score_board_no_ball_short_text;
        case ExtrasType.bye:
          return context.l10n.score_board_run_sup_script_text(
              "${ball.extras_awarded ?? 0}",
              context.l10n.score_board_bye_short_text);
        case ExtrasType.legBye:
          return context.l10n.score_board_run_sup_script_text(
              "${ball.extras_awarded ?? 0}",
              context.l10n.score_board_leg_bye_short_text);
        case ExtrasType.penaltyRun:
          return "P";
      }
    } else if (ball.wicket_type == null && ball.extras_type == null) {
      return "${ball.runs_scored}";
    } else {
      return "";
    }
  }

  (Color, Color) _getBackGroundColorBasedOnBall(
      BuildContext context, BallScoreModel ball) {
    if (ball.wicket_type != null) {
      if (ball.wicket_type == WicketType.retired ||
          ball.wicket_type == WicketType.retiredHurt ||
          ball.wicket_type == WicketType.timedOut) {
        return (Colors.transparent, context.colorScheme.textPrimary);
      } else {
        return (context.colorScheme.alert, context.colorScheme.onPrimary);
      }
    } else if (ball.is_six || ball.is_four) {
      return (
        ball.is_four
            ? context.colorScheme.secondary
            : context.colorScheme.primary,
        context.colorScheme.onPrimary
      );
    } else if (ball.extras_type != null) {
      return (
        context.colorScheme.containerHigh,
        context.colorScheme.textPrimary
      );
    } else {
      return (
        context.colorScheme.containerLow,
        context.colorScheme.textPrimary
      );
    }
  }
}
