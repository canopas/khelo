import 'package:collection/collection.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/components/won_by_message_text.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class MatchCompleteSheet extends ConsumerWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    bool showUndoButton = true,
  }) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return MatchCompleteSheet(
          showUndoButton: showUndoButton,
        );
      },
    );
  }

  final bool showUndoButton;

  const MatchCompleteSheet({super.key, required this.showUndoButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreBoardStateProvider);

    return BottomSheetWrapper(
      content: _matchContent(context, state),
      action: [
        if (showUndoButton) ...[
          PrimaryButton(
            context.l10n.score_board_undo_last_ball_title,
            expanded: false,
            onPressed: () => context.pop(false),
          ),
        ],
        PrimaryButton(
          context.l10n.common_end_match_title,
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
        Text(
          context.l10n.score_board_match_complete_title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: context.colorScheme.containerLow,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // passing match_status as finish because matchResult is calculated based on match_status.
              WonByMessageText(
                  matchResult: state.match
                      ?.copyWith(match_status: MatchStatus.finish)
                      .matchResult,
                  textStyle: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textPrimary)),
              const SizedBox(height: 16),
              _table(context, state),
            ],
          ),
        ),
      ],
    );
  }

  Widget _table(
    BuildContext context,
    ScoreBoardViewState state,
  ) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          _row(
            context,
            title: context.l10n.score_board_team_title,
            data: context.l10n.score_board_r_title,
            data1: context.l10n.score_board_w_title,
            data2: context.l10n.score_board_o_title,
            isHeader: true,
          ),
          ...state.allInnings.map(
            (inning) {
              final teamName = state.match?.teams
                  .firstWhereOrNull(
                      (element) => element.team.id == inning.team_id)
                  ?.team
                  .name;
              return _teamScore(context, state,
                  teamRunStat: TeamRunStat(
                      teamName: teamName ?? '',
                      wicket: inning.total_wickets,
                      run: inning.total_runs,
                      over: inning.overs),
                  isLast: inning.id == state.allInnings.last.id);
            },
          ),
        ],
      ),
    );
  }

  Widget _teamScore(
    BuildContext context,
    ScoreBoardViewState state, {
    required TeamRunStat teamRunStat,
    bool isLast = false,
  }) {
    return _row(
      context,
      title: teamRunStat.teamName,
      data: teamRunStat.run.toString(),
      data1: teamRunStat.wicket.toString(),
      data2: teamRunStat.over.toString(),
      isLast: isLast,
    );
  }

  Widget _row(
    BuildContext context, {
    required String title,
    required String data,
    required String data1,
    required String data2,
    isHeader = false,
    isLast = false,
  }) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 16, vertical: isHeader ? 4 : 12),
      decoration: BoxDecoration(
          color: isHeader
              ? context.colorScheme.containerLow
              : context.colorScheme.surface,
          border: Border(top: BorderSide(color: context.colorScheme.outline)),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(isHeader ? 8 : 0),
              bottom: Radius.circular(isLast ? 8 : 0))),
      child: Row(
        children: [
          Expanded(
              flex: 4, child: _text(context, title: title, isHeader: isHeader)),
          for (var dataItem in [data, data1, data2])
            Expanded(
              child: _text(
                context,
                title: dataItem,
                isHeader: isHeader,
                isRightAlign: true,
              ),
            ),
        ],
      ),
    );
  }

  Text _text(
    BuildContext context, {
    required String title,
    bool isHeader = false,
    bool isRightAlign = false,
  }) {
    return Text(
      title,
      textAlign: isRightAlign ? TextAlign.right : TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.body2.copyWith(
          color: isHeader
              ? context.colorScheme.textDisabled
              : context.colorScheme.textPrimary),
    );
  }
}
