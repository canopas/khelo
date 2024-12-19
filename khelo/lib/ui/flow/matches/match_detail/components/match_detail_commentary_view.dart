import 'package:collection/collection.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/commentary_ball_summary.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/commentary_over_overview.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/final_score_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/callback/on_visible_callback.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../domain/extensions/widget_extension.dart';

class MatchDetailCommentaryView extends ConsumerWidget {
  const MatchDetailCommentaryView({super.key});

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
        ? ListView.builder(
            padding:
                context.mediaQueryPadding + const EdgeInsets.only(bottom: 24),
            itemCount: 1 + state.overList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: FinalScoreView(),
                );
              }
              if (index < state.overList.length + 1) {
                final overSummaryIndex = state.overList.length - index;
                final overSummary = state.overList[overSummaryIndex];
                final nextOverSummary =
                    state.overList.elementAtOrNull(overSummaryIndex + 1);
                final team = _getTeamByTeamId(state, overSummary.team_id);

                return _buildCommentaryItem(
                  context,
                  overSummary: overSummary,
                  team: team,
                  nextOverSummary: nextOverSummary,
                );
              }
              return OnVisibleCallback(
                onVisible: () => runPostFrame(notifier.loadBallScores),
                child: (state.loadingBallScoreMore && state.overList.isNotEmpty)
                    ? const Center(child: AppProgressIndicator())
                    : const SizedBox(),
              );
            },
          )
        : EmptyScreen(
            title: context.l10n.match_detail_match_not_started_error_title,
            description: context.l10n.match_detail_error_description_text,
            isShowButton: false,
          );
  }

  Widget _buildCommentaryItem(
    BuildContext context, {
    required OverSummary overSummary,
    required TeamModel? team,
    OverSummary? nextOverSummary,
  }) {
    List<Widget> children = [];

    // Add BowlerSummaryView if applicable
    if (nextOverSummary != null &&
        nextOverSummary.overNumber != overSummary.overNumber) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: BowlerSummaryView(
            bowlerSummary: nextOverSummary.bowlerStatAtStart,
            isForBowlerIntro: true,
          ),
        ),
      );
    }

    // Add CommentaryOverOverview or InningOverview if applicable
    if ((overSummary.balls.lastOrNull?.isLegalDelivery() ?? false) &&
        overSummary.balls.lastOrNull?.ball_number == 6 &&
        nextOverSummary?.inning_id == overSummary.inning_id) {
      children
          .add(CommentaryOverOverview(overSummary: overSummary, team: team));
    } else if (nextOverSummary != null &&
        nextOverSummary.inning_id != overSummary.inning_id) {
      children.addAll([
        _inningOverview(
          context,
          teamName: team?.name ?? "",
          targetRun: overSummary.totalRuns + 1,
        ),
        CommentaryOverOverview(overSummary: overSummary, team: team),
      ]);
    }

    // Add CommentaryBallSummary for each ball
    children.addAll(
      overSummary.balls.reversed.map(
        (ball) => Column(
          children: [
            CommentaryBallSummary(
              ball: ball,
              overSummary: overSummary,
              showBallScore:
                  ball.is_four || ball.is_six || ball.wicket_taker_id != null,
            ),
            if (ball != overSummary.balls.first)
              Divider(color: context.colorScheme.outline),
          ],
        ),
      ),
    );

    return Column(children: children);
  }

  TeamModel? _getTeamByTeamId(MatchDetailTabState state, String teamId) {
    return state.match?.teams
        .firstWhereOrNull((element) => element.team.id == teamId)
        ?.team;
  }

  Widget _inningOverview(BuildContext context,
      {required String teamName, required int targetRun}) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: context.colorScheme.containerLow,
          borderRadius: BorderRadius.circular(8)),
      child: Text.rich(TextSpan(
          text: teamName,
          style: AppTextStyle.subtitle2
              .copyWith(color: context.colorScheme.primary),
          children: [
            TextSpan(
              text: context.l10n.match_commentary_end_inning_text_part_1,
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            TextSpan(text: context.l10n.match_commentary_runs_text(targetRun)),
            TextSpan(
              text: context.l10n.match_commentary_end_inning_text_part_2,
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ])),
    );
  }
}
