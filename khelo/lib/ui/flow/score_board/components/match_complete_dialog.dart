import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class MatchCompleteDialog extends ConsumerWidget {
  static Future<T?> show<T>(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const MatchCompleteDialog();
      },
    );
  }

  const MatchCompleteDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(scoreBoardStateProvider);
    return AlertDialog(
      backgroundColor: context.colorScheme.containerLowOnSurface,
      title: Text(
        context.l10n.score_board_match_complete_title,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      content: _matchContent(context, state),
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
          context.l10n.score_board_end_match_title,
          expanded: false,
          onPressed: () {
            context.pop(true);
          },
        ),
      ],
    );
  }

  Widget _matchContent(BuildContext context, ScoreBoardViewState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _winnerMessageText(context, state),
        const SizedBox(
          height: 16,
        ),
        Table(
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: context.colorScheme.secondaryVariant,
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
      BuildContext context, ScoreBoardViewState state, MatchTeamModel team) {
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

    final inningOver = teamInning?.overs ?? 0;

    final ballCount = inningOver - inningOver.truncate();
    final over = inningOver - 1;
    final overCount = over + ballCount;

    return (
      teamInning?.total_runs ?? 0,
      teamInning?.total_wickets ?? 0,
      overCount
    );
  }

  Widget _winnerMessageText(BuildContext context, ScoreBoardViewState state) {
    final firstInning = state.otherInning;
    final secondInning = state.currentInning;

    if (firstInning!.total_runs! > secondInning!.total_runs!) {
      final teamName = state.match?.teams
          .where((element) => element.team.id == firstInning.team_id)
          .firstOrNull
          ?.team
          .name;

      final runDifference = firstInning.total_runs! - secondInning.total_runs!;

      return _messageText(context, teamName, runDifference,
          context.l10n.score_board_runs_dot_title);
    } else {
      final team = state.match?.teams
          .where((element) => element.team.id == secondInning.team_id)
          .firstOrNull;
      final teamName = team?.team.name;

      final wicketDifference = team!.squad.length - state.wicketCount;

      return _messageText(context, teamName, wicketDifference,
          context.l10n.score_board_wickets_dot_title);
    }
  }

  Widget _messageText(BuildContext context, String? teamName, int difference,
      String trailingText) {
    return Text.rich(TextSpan(
        text: "$teamName",
        style: AppTextStyle.header4
            .copyWith(color: context.colorScheme.textPrimary),
        children: [
          TextSpan(
              text: context.l10n.score_board_won_by_title,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textSecondary)),
          TextSpan(
            text: "$difference",
          ),
          TextSpan(
              text: trailingText,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textSecondary)),
        ]));
  }
}
