import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class ScoreDisplayView extends ConsumerWidget {
  const ScoreDisplayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreBoardStateProvider);

    return Expanded(
      child: ListView(
        children: [
          _matchScoreView(context, state),
          const SizedBox(
            height: 24,
          ),
          _batsManDetailsView(context, state),
          _bowlerAndBallDetailView(context, state),
        ],
      ),
    );
  }

  Widget _matchScoreView(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    final currentOver = _getCurrentOver(state);

    return Stack(
      children: [
        _powerPlayTag(context, state),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.vertical,
            children: [
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${state.totalRuns}/${state.wicketCount}',
                      style: AppTextStyle.subtitle1.copyWith(
                          color: context.colorScheme.textPrimary, fontSize: 39),
                    ),
                    TextSpan(
                      text: '($currentOver/${state.match?.number_of_over})',
                      style: AppTextStyle.header4
                          .copyWith(color: context.colorScheme.textSecondary),
                    ),
                  ],
                ),
              ),
              _runNeededText(context, state),
            ],
          ),
        ),
      ],
    );
  }

  Widget _powerPlayTag(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    final powerPlayText = _getPowerPlayText(context, state);
    if (powerPlayText != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(12))),
        child: Text(
          powerPlayText,
          style: AppTextStyle.body1.copyWith(
              color: context.colorScheme.textInversePrimary,
              fontWeight: FontWeight.w500),
        ),
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
    if (state.otherInning?.innings_status == InningStatus.finish) {
      final requiredRun = ((state.otherInning?.total_runs ?? 0) + 1) -
          (state.currentInning?.total_runs ?? 0);
      final pendingOver = (state.match?.number_of_over ?? 0) - state.overCount;
      final pendingBall = (pendingOver * 6) + (6 - state.ballCount);
      return Text(
        context.l10n.score_board_need_run_text(
            requiredRun < 0 ? 0 : requiredRun,
            pendingBall < 0 ? 0 : pendingBall),
        textAlign: TextAlign.center,
        style:
            AppTextStyle.subtitle1.copyWith(color: context.colorScheme.warning),
      );
    } else {
      return const SizedBox();
    }
  }

  String _getCurrentOver(ScoreBoardViewState state) {
    return state.currentInning?.overs.toString() ??
        "${state.overCount - 1}.${state.ballCount}";
  }

  Widget _batsManDetailsView(BuildContext context, ScoreBoardViewState state) {
    return Row(
      children: [
        _batManCellView(context, state, state.batsMans?.firstOrNull),
        _batManCellView(context, state, state.batsMans?.elementAtOrNull(1)),
      ],
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.outline)),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.sports_cricket,
                  color: isOnStrike
                      ? context.colorScheme.primary
                      : context.colorScheme.textDisabled,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.player.name ?? context.l10n.score_board_player_title,
                    style: AppTextStyle.header1
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                  Text(
                    "$run($ball)",
                    style: AppTextStyle.header4
                        .copyWith(color: context.colorScheme.textSecondary),
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
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: context.colorScheme.secondaryVariant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bowlerNameView(
              context,
              state.bowler?.player.name ??
                  context.l10n.score_board_player_title),
          const SizedBox(
            height: 16,
          ),
          _ballHistoryListView(context, state),
        ],
      ),
    );
  }

  Widget _bowlerNameView(BuildContext context, String name) {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
              child: Icon(
            Icons.sports_baseball_outlined,
            color: context.colorScheme.surface,
          )),
          TextSpan(
            text: ' $name',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _ballHistoryListView(BuildContext context, ScoreBoardViewState state) {
    return SingleChildScrollView(
      reverse: true,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final ball in _getFilteredCurrentOverBall(state)) ...[
            _ballView(context, ball),
            const SizedBox(width: 8)
          ]
        ],
      ),
    );
  }

  List<BallScoreModel> _getFilteredCurrentOverBall(ScoreBoardViewState state) {
    final list = state.currentScoresList
        .where((element) =>
            element.over_number == state.overCount &&
            element.extras_type != ExtrasType.penaltyRun)
        .toList();
    return list;
  }

  Widget _ballView(BuildContext context, BallScoreModel ball) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.containerLow,
          border: Border.all(color: context.colorScheme.outline)),
      child: Text(_getTextBasedOnBall(context, ball)),
    );
  }

  String _getTextBasedOnBall(BuildContext context, BallScoreModel ball) {
    if (ball.wicket_type != null) {
      return context.l10n.score_board_wicket_short_text;
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
}
