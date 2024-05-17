import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/won_by_message_text.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/data_model_extensions/match_model_extension.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class MatchCompleteDialog extends ConsumerWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    bool showUndoButton = true,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return MatchCompleteDialog(
          showUndoButton: showUndoButton,
        );
      },
    );
  }

  final bool showUndoButton;

  const MatchCompleteDialog({super.key, required this.showUndoButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreBoardStateProvider);

    return AlertDialog(
      backgroundColor: context.colorScheme.surface,
      title: Text(
        context.l10n.score_board_match_complete_title,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      content: _matchContent(context, state),
      actionsOverflowButtonSpacing: 8,
      actions: [
        if (showUndoButton) ...[
          PrimaryButton(
            context.l10n.score_board_undo_last_ball_title,
            expanded: false,
            onPressed: () => context.pop(false),
          ),
        ],
        PrimaryButton(
          context.l10n.score_board_end_match_title,
          expanded: false,
          onPressed: () => context.pop(true),
        ),
      ],
    );
  }

  Widget _matchContent(BuildContext context, ScoreBoardViewState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _winnerMessageText(context, state.match),
        const SizedBox(
          height: 16,
        ),
        Table(
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: context.colorScheme.containerNormalOnSurface,
              ),
              children: [
                Text(context.l10n.score_board_team_title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.subtitle2.copyWith(
                        color: context.colorScheme.textInversePrimary)),
                Text(context.l10n.score_board_r_title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.subtitle2.copyWith(
                        color: context.colorScheme.textInversePrimary)),
                Text(context.l10n.score_board_w_title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.subtitle2.copyWith(
                        color: context.colorScheme.textInversePrimary)),
                Text(context.l10n.score_board_o_title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.subtitle2.copyWith(
                        color: context.colorScheme.textInversePrimary)),
              ],
            ),
            for (final team in state.match?.teams ?? []) ...[
              _teamMatchScores(context, state, team)
            ]
          ],
        ),
      ],
    );
  }

  TableRow _teamMatchScores(
    BuildContext context,
    ScoreBoardViewState state,
    MatchTeamModel team,
  ) {
    final (run, wicket, overs) =
        _getTeamRunDetails(state, team.team.id ?? "INVALID ID");
    return TableRow(
      decoration: BoxDecoration(
          color: context.colorScheme.containerLowOnSurface,
          border:
              Border(top: BorderSide(color: context.colorScheme.secondary))),
      children: [
        Text(team.team.name,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary)),
        Text(run.toString(),
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary)),
        Text(wicket.toString(),
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary)),
        Text(overs.toString(),
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary)),
      ],
    );
  }

  (int, int, double) _getTeamRunDetails(
      ScoreBoardViewState state, String teamId) {
    final teamInning = state.currentInning?.team_id == teamId
        ? state.currentInning
        : state.otherInning;

    return (
      teamInning?.total_runs ?? 0,
      teamInning?.total_wickets ?? 0,
      teamInning?.overs ?? 0
    );
  }

  Widget _winnerMessageText(BuildContext context, MatchModel? match) {
    if (match == null) {
      return const SizedBox();
    }
    final winSummary = match
        .copyWith(match_status: MatchStatus.finish)
        .getWinnerSummary(context);
    if (winSummary != null) {
      if (winSummary.teamName.isEmpty) {
        return Text(
          context.l10n.score_board_match_tied_text,
          style: AppTextStyle.subtitle1
              .copyWith(color: context.colorScheme.primary),
        );
      }
      return WonByMessageText(
        teamName: winSummary.teamName,
        difference: winSummary.difference,
        trailingText: winSummary.wonByText,
      );
    } else {
      return const SizedBox();
    }
  }
}
