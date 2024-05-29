import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class InningCompleteSheet extends ConsumerWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    bool showUndoButton = true,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return InningCompleteSheet(
          showUndoButton: showUndoButton,
        );
      },
    );
  }

  final bool showUndoButton;

  const InningCompleteSheet({super.key, required this.showUndoButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreBoardStateProvider);

    return BottomSheetWrapper(
      content: _inningContent(context, state),
      action: [
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.score_board_inning_complete_title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: context.colorScheme.containerLow,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Text(
                teamName,
                style: AppTextStyle.subtitle2
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: _detailInfoCell(
                          context,
                          "${context.l10n.score_board_runs_title}:",
                          (state.currentInning?.total_runs ?? "").toString())),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _detailInfoCell(
                          context,
                          "${context.l10n.score_board_wickets_text}:",
                          (state.otherInning?.total_wickets ?? "").toString())),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: _detailInfoCell(
                          context,
                          "${context.l10n.score_board_extras_title}:",
                          extras.toString())),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _detailInfoCell(
                          context,
                          "${context.l10n.score_board_overs_title}:",
                          _getOverCount(state))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _detailInfoCell(
      BuildContext context, String placeholder, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(8)),
      child: Text.rich(TextSpan(
          text: placeholder,
          style: AppTextStyle.body2
              .copyWith(color: context.colorScheme.textDisabled),
          children: [
            const WidgetSpan(
                child: SizedBox(
              width: 16,
            )),
            TextSpan(
                text: title,
                style: AppTextStyle.body2
                    .copyWith(color: context.colorScheme.textPrimary)),
          ])),
    );
  }

  String _getOverCount(ScoreBoardViewState state) {
    return state.currentInning?.overs.toString() ??
        "${state.overCount - 1}.${state.ballCount}";
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
