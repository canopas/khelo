import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class InningCompleteDialog extends ConsumerWidget {
  static Future<T?> show<T>(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const InningCompleteDialog();
      },
    );
  }

  const InningCompleteDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(scoreBoardStateProvider);

    return AlertDialog(
      backgroundColor: context.colorScheme.containerLowOnSurface,
      title: Text(
        context.l10n.score_board_inning_complete_title,
        style: AppTextStyle.header2
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      content: _inningContent(context, state),
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
          context.l10n.score_board_start_next_inning_title,
          expanded: false,
          onPressed: () {
            context.pop(true);
          },
        ),
      ],
    );
  }

  Widget _inningContent(BuildContext context, ScoreBoardViewState state) {
    final teamName = _getCurrentTeamName(context, state);
    final extras = _getExtras(state);
    return Wrap(
      direction: Axis.vertical,
      children: [
        Text(
          teamName,
          style: AppTextStyle.header4
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        Row(
          children: [
            _subTitleText(context, "${context.l10n.score_board_runs_title}:",
                state.totalRuns.toString()),
            const SizedBox(
              width: 16,
            ),
            _subTitleText(context, "${context.l10n.score_board_wickets_text}:",
                state.wicketCount.toString())
          ],
        ),
        Row(
          children: [
            _subTitleText(context, "${context.l10n.score_board_extras_title}:",
                extras.toString()),
            const SizedBox(
              width: 16,
            ),
            _subTitleText(context, "${context.l10n.score_board_overs_title}:",
                _getOverCount(state))
          ],
        ),
      ],
    );
  }

  String _getOverCount(ScoreBoardViewState state) {
    return "${state.overCount - 1}.${state.ballCount}";
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

  String _getCurrentTeamName(BuildContext context, ScoreBoardViewState state) {
    final teamId = state.currentInning?.team_id;
    final teamName = state.match?.teams
        .where((element) => element.team.id == teamId)
        .firstOrNull
        ?.team
        .name;
    return teamName ?? context.l10n.score_board_current_team_title;
  }

  int _getExtras(ScoreBoardViewState state) {
    final extras = state.currentScoresList
        .where((element) => (element.extras_type != null))
        .fold(0, (sum, element) => sum + (element.extras_awarded ?? 0));
    return extras;
  }
}
