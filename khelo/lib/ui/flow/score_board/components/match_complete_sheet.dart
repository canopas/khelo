import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/data_model_extensions/match_model_extension.dart';
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
        Text(
          context.l10n.score_board_match_complete_title,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _winnerMessageText(context, state.match),
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
          _teamScore(context, state, team: state.match?.teams.firstOrNull),
          _teamScore(
            context,
            state,
            team: state.match?.teams.elementAt(1),
            isLast: true,
          )
        ],
      ),
    );
  }

  Widget _teamScore(
    BuildContext context,
    ScoreBoardViewState state, {
    required MatchTeamModel? team,
    bool isLast = false,
  }) {
    if (team == null) {
      return const SizedBox();
    }
    final (run, wicket, overs) =
        _getTeamRunDetails(state, team.team.id ?? "INVALID ID");
    return _row(
      context,
      title: team.team.name,
      data: run.toString(),
      data1: wicket.toString(),
      data2: overs.toString(),
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
          border: Border(
              top: isLast
                  ? BorderSide(color: context.colorScheme.outline)
                  : BorderSide.none),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(isHeader ? 8 : 0),
              bottom: Radius.circular(isLast ? 8 : 0))),
      child: Row(
        children: [
          Expanded(
              flex: 4, child: _text(context, title: title, isHeader: isHeader)),
          Expanded(
              child: _text(context,
                  title: data, isHeader: isHeader, isRightAlign: true)),
          Expanded(
              child: _text(context,
                  title: data1, isHeader: isHeader, isRightAlign: true)),
          Expanded(
              child: _text(context,
                  title: data2, isHeader: isHeader, isRightAlign: true)),
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
          style: AppTextStyle.subtitle2
              .copyWith(color: context.colorScheme.textPrimary),
        );
      }
      return Text(
        "${winSummary.teamName} ${context.l10n.score_board_won_by_title} ${winSummary.difference} ${winSummary.wonByText}",
        style: AppTextStyle.subtitle2
            .copyWith(color: context.colorScheme.textPrimary),
      );
    } else {
      return const SizedBox();
    }
  }
}
