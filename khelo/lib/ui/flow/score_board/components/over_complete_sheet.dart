import 'package:collection/collection.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:khelo/ui/flow/score_board/score_board_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class OverCompleteSheet extends ConsumerWidget {
  static Future<T?> show<T>(BuildContext context, OverStatModel overStat) {
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
        return OverCompleteSheet(overStat: overStat);
      },
    );
  }

  final OverStatModel overStat;

  const OverCompleteSheet({super.key, required this.overStat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreBoardStateProvider);

    return BottomSheetWrapper(
      content: _overContent(context, state),
      action: [
        PrimaryButton(
          expanded: false,
          context.l10n.score_board_undo_last_ball_title,
          onPressed: () => context.pop(false),
        ),
        PrimaryButton(
          context.l10n.score_board_start_next_over_title,
          expanded: false,
          onPressed: () => context.pop(true),
        ),
      ],
    );
  }

  Widget _overContent(BuildContext context, ScoreBoardViewState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.score_board_over_complete_title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 16),
        _scoreDetailCard(context, state),
      ],
    );
  }

  Widget _scoreDetailCard(BuildContext context, ScoreBoardViewState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: context.colorScheme.containerLow,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.score_board_end_of_over_by_title(
                state.overCount, state.bowler?.player.name ?? ""),
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _detailInfoCell(
                context,
                placeholder: "${context.l10n.score_board_runs_title}:",
                title: overStat.run.toString(),
              )),
              const SizedBox(width: 8),
              Expanded(
                  child: _detailInfoCell(
                context,
                placeholder: "${context.l10n.common_wickets_text}:",
                title: overStat.wicket.toString(),
              )),
            ],
          ),
          const SizedBox(height: 8),
          _detailInfoCell(context,
              placeholder: "${context.l10n.score_board_extras_title}:",
              title: overStat.extra.toString()),
          const SizedBox(height: 24),
          _detailInfoCell(
            context,
            placeholder: "",
            title: _getCurrentTeamName(context, state),
            isHeading: true,
          ),
          const SizedBox(height: 8),
          for (final batsMan in state.batsMans ?? []) ...[
            _batsManIndividualScore(context, state, batsMan)
          ]
        ],
      ),
    );
  }

  Widget _detailInfoCell(
    BuildContext context, {
    required String placeholder,
    required String title,
    bool showBg = true,
    bool isHeading = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
          color: showBg
              ? isHeading
                  ? context.colorScheme.containerNormal
                  : context.colorScheme.surface
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8)),
      child: Text.rich(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          TextSpan(
              text: placeholder,
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.textDisabled),
              children: [
                WidgetSpan(
                    child: SizedBox(
                  width: placeholder.isEmpty ? 0 : 16,
                )),
                TextSpan(
                    text: title,
                    style: isHeading
                        ? AppTextStyle.subtitle2
                            .copyWith(color: context.colorScheme.textPrimary)
                        : AppTextStyle.body2
                            .copyWith(color: context.colorScheme.textPrimary)),
              ])),
    );
  }

  Widget _batsManIndividualScore(
    BuildContext context,
    ScoreBoardViewState state,
    MatchPlayer batsMan,
  ) {
    final (run, ball) = _getBatsManTotalRuns(state, batsMan.player.id);
    return _detailInfoCell(
      context,
      placeholder: batsMan.player.name ?? "",
      title: "$run($ball)",
      showBg: false,
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

  String _getCurrentTeamName(BuildContext context, ScoreBoardViewState state) {
    final teamId = state.currentInning?.team_id;
    final teamName = state.match?.teams
        .firstWhereOrNull((element) => element.team.id == teamId)
        ?.team
        .name;
    return teamName ?? context.l10n.score_board_current_team_title;
  }
}
