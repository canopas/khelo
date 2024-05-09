import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class InningCompleteDialog extends ConsumerWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    bool showUndoButton = true,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return InningCompleteDialog(
          showUndoButton: showUndoButton,
        );
      },
    );
  }

  final bool showUndoButton;

  const InningCompleteDialog({super.key, required this.showUndoButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreBoardStateProvider);

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
        if (showUndoButton) ...[
          PrimaryButton(
            context.l10n.score_board_undo_last_ball_title,
            expanded: false,
            onPressed: () => context.pop(false),
          ),
        ],
        PrimaryButton(
          context.l10n.score_board_start_next_inning_title,
          expanded: false,
          onPressed: () => context.pop(true),
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
            _subTitleText(
              context,
              title: "${context.l10n.score_board_runs_title}:",
              subTitle: (state.currentInning?.total_runs ?? "").toString(),
            ),
            const SizedBox(
              width: 16,
            ),
            _subTitleText(
              context,
              title: "${context.l10n.score_board_wickets_text}:",
              subTitle: (state.otherInning?.total_wickets ?? "").toString(),
            )
          ],
        ),
        Row(
          children: [
            _subTitleText(
              context,
              title: "${context.l10n.score_board_extras_title}:",
              subTitle: extras.toString(),
            ),
            const SizedBox(
              width: 16,
            ),
            _subTitleText(
              context,
              title: "${context.l10n.score_board_overs_title}:",
              subTitle: _getOverCount(state),
            )
          ],
        ),
      ],
    );
  }

  String _getOverCount(ScoreBoardViewState state) {
    return state.currentInning?.overs.toString() ??
        "${state.overCount - 1}.${state.ballCount}";
  }

  Widget _subTitleText(
    BuildContext context, {
    required String title,
    required String subTitle,
  }) {
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
