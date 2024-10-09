import 'package:collection/collection.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/final_score_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/over_score_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/empty_screen.dart';

class MatchDetailOversView extends ConsumerWidget {
  const MatchDetailOversView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailTabStateProvider);
    final notifier = ref.watch(matchDetailTabStateProvider.notifier);

    return _body(context, notifier, state);
  }

  Widget _body(BuildContext context, MatchDetailTabViewNotifier notifier,
      MatchDetailTabState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onResume,
      );
    }

    return (state.overList.isNotEmpty)
        ? ListView(
            padding:
                context.mediaQueryPadding + const EdgeInsets.only(bottom: 24),
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: FinalScoreView(),
              ),
              ..._buildOverList(context, state),
            ],
          )
        : EmptyScreen(
            title: context.l10n.match_detail_match_not_started_error_title,
            description: context.l10n.match_detail_error_description_text,
            isShowButton: false,
          );
  }

  List<Widget> _buildOverList(BuildContext context, MatchDetailTabState state) {
    List<Widget> children = [];

    for (int i = state.overList.length - 1; i >= 0; i--) {
      final over = state.overList.elementAt(i);
      final nextOver = state.overList.elementAtOrNull(i + 1);
      if (nextOver?.inning_id != over.inning_id) {
        children.add(
          _teamNameTitleView(
              context,
              state,
              over.inning_id,
              state.allInnings
                      .firstWhereOrNull(
                        (element) => element.id == over.inning_id,
                      )
                      ?.index ??
                  1),
        );
      } else {
        children.add(Divider(height: 32, color: context.colorScheme.outline));
      }

      children.add(_overCellView(
          context,
          over.balls,
          over.bowler.player.name ?? '',
          over.striker.player.name ?? '',
          over.nonStriker.player.name ?? ''));
    }
    return children;
  }

  Widget _overCellView(BuildContext context, List<BallScoreModel> over,
      String bowler, String striker, String nonStriker) {
    final overCount = over.first.over_number;
    final runs = over.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.runs_scored +
            (element.extras_awarded ?? 0));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.match_commentary_former_over_short_text(overCount),
                style: AppTextStyle.body2
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.match_commentary_runs_text(runs),
                style: AppTextStyle.caption
                    .copyWith(color: context.colorScheme.textDisabled),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${context.l10n.match_commentary_bowler_to_batsman_text(bowler, striker)} & $nonStriker",
                style: AppTextStyle.subtitle2
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              const SizedBox(height: 4),
              OverScoreView(
                over: over,
                size: 24,
              ),
            ],
          ))
        ],
      ),
    );
  }

  String _getTeamNameByInningId(MatchDetailTabState state, String inningId) {
    final teamId = state.allInnings
        .firstWhereOrNull((element) => element.id == inningId)
        ?.team_id;

    final teamName = state.match?.teams
        .firstWhereOrNull((element) => element.team.id == teamId)
        ?.team
        .name;
    return teamName ?? "--";
  }

  Widget _teamNameTitleView(BuildContext context, MatchDetailTabState state,
      String inningId, int inningCount) {
    final title = _getTeamNameByInningId(state, inningId);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Text(
        "${context.l10n.match_commentary_inning_count_text(inningCount)}: $title",
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
    );
  }
}
