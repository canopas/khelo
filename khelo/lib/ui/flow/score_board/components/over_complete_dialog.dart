import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class OverCompleteDialog extends ConsumerWidget {
  static Future<T?> show<T>(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const OverCompleteDialog();
      },
    );
  }

  const OverCompleteDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(scoreBoardStateProvider);

    return AlertDialog(
      backgroundColor: context.colorScheme.containerLowOnSurface,
      title: Text(
        context.l10n.score_board_over_complete_title,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      content: _overContent(context, state),
      actionsOverflowButtonSpacing: 8,
      actions: [
        PrimaryButton(
          expanded: false,
          context.l10n.score_board_undo_last_ball_title,
          onPressed: () {
            context.pop(false);
          },
        ),
        PrimaryButton(
          context.l10n.score_board_start_next_over_title,
          expanded: false,
          onPressed: () {
            context.pop(true);
          },
        ),
      ],
    );
  }

  Widget _overContent(BuildContext context, ScoreBoardViewState state) {
    final (run, wicket, extra) = _getCurrentOverStatics(state);

    return Wrap(
      direction: Axis.vertical,
      children: [
        _overSummaryText(context, state),
        Row(
          children: [
            _subTitleText(context, "${context.l10n.score_board_runs_title}:",
                run.toString()),
            const SizedBox(
              width: 8,
            ),
            _subTitleText(context, "${context.l10n.score_board_wickets_text}:",
                wicket.toString()),
            const SizedBox(
              width: 8,
            ),
            _subTitleText(context, "${context.l10n.score_board_extras_title}:",
                extra.toString()),
          ],
        ),
        const Divider(),
        _teamScoreText(context, state),
        for (final batsMan in state.batsMans ?? []) ...[
          _batsManIndividualScore(context, state, batsMan)
        ]
      ],
    );
  }

  Widget _overSummaryText(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    return Text.rich(TextSpan(
        text: context.l10n.score_board_end_of_over_title,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textSecondary),
        children: [
          TextSpan(
            text: state.overCount.toString(),
            style: AppTextStyle.header4
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          TextSpan(
            text: context.l10n.score_board_by_title,
          ),
          TextSpan(
            text: "${state.bowler?.player.name}",
            style: AppTextStyle.header4
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ]));
  }

  Widget _subTitleText(BuildContext context, String title, String subTitle) {
    return Text.rich(TextSpan(
        text: title,
        style: AppTextStyle.subtitle2
            .copyWith(color: context.colorScheme.textSecondary),
        children: [
          TextSpan(
              text: " $subTitle",
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary)),
        ]));
  }

  Widget _teamScoreText(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    final teamName = _getCurrentTeamName(context, state);
    return Text.rich(TextSpan(
        text: teamName,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary, fontSize: 22),
        children: [
          TextSpan(
            text: " ${state.totalRuns}/${state.wicketCount}",
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textSecondary),
          ),
          TextSpan(
            text: " (${state.overCount})",
            style: AppTextStyle.body1
                .copyWith(color: context.colorScheme.textSecondary),
          )
        ]));
  }

  Widget _batsManIndividualScore(
      BuildContext context, ScoreBoardViewState state, MatchPlayer batsMan) {
    final (run, ball) = _getBatsManTotalRuns(state, batsMan.player.id);
    return Text.rich(TextSpan(
        text: batsMan.player.name,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
        children: [
          TextSpan(
            text: " $run",
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textSecondary),
          ),
          TextSpan(
            text: "($ball)",
            style: AppTextStyle.body1
                .copyWith(color: context.colorScheme.textSecondary),
          ),
        ]));
  }

  (int, int) _getBatsManTotalRuns(ScoreBoardViewState state, String batsManId) {
    final scoresList = state.currentScoresList
        .where((element) => element.batsman_id == batsManId);

    int totalRuns = scoresList
        .where((element) => (element.extras_type == ExtrasType.noBall ||
            element.extras_type == null))
        .fold(0, (sum, element) => sum + (element.runs_scored ?? 0));

    final batsManFacedBall = scoresList
        .where((element) => (element.extras_type != ExtrasType.wide))
        .length;

    return (totalRuns, batsManFacedBall);
  }

  (int, int, int) _getCurrentOverStatics(ScoreBoardViewState state) {
    final scoresList = state.currentScoresList
        .where((element) => element.over_number == state.overCount);

    int run = scoresList
        .where((element) => (element.extras_type == ExtrasType.noBall ||
            element.extras_type == null))
        .fold(0, (sum, element) => sum + (element.runs_scored ?? 0));

    final wicket = scoresList
        .where((element) => (element.wicket_type != null &&
            element.wicket_type != WicketType.retiredHurt))
        .length;

    final extras = scoresList
        .where((element) => (element.extras_type != null))
        .fold(0, (sum, element) => sum + (element.extras_awarded ?? 0));

    return (run, wicket, extras);
  }

  String _getCurrentTeamName(BuildContext context, ScoreBoardViewState state) {
    final teamId = state.currentInning?.team_id;
    final teamName = state.match?.teams
        .where((element) => element.team.id == teamId)
        .firstOrNull
        ?.team
        .name;
    return teamName ?? context.l10n.score_board_current_team_title;
  }
}
