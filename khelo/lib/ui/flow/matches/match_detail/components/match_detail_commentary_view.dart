import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/commentary_ball_summary.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/commentary_over_overview.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/final_score_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

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
        onRetryTap: () => notifier.onResume(),
      );
    }

    if (state.overList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            context.l10n.match_commentary_empty_commentary_text,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
      );
    }

    return ListView(
      padding: context.mediaQueryPadding,
      children: _buildCommentaryList(context, state),
    );
  }

  List<Widget> _buildCommentaryList(
    BuildContext context,
    MatchDetailTabState state,
  ) {
    List<Widget> children = [];

    children.add(const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: FinalScoreView(),
    ));
    for (int index = state.overList.length - 1; index >= 0; index--) {
      final overSummary = state.overList[index];
      final team = _getTeamByTeamId(state, overSummary.team_id);

      final nextOverSummary = state.overList.elementAtOrNull(index + 1);
      if (nextOverSummary != null &&
          nextOverSummary.overNumber != overSummary.overNumber) {
        children.add(BowlerSummaryView(
          bowlerSummary:nextOverSummary.bowlerStatAtStart,
          isForBowlerIntro: true,
        ));
        children.add(const SizedBox(height: 24));
      }

      if ((overSummary.balls.lastOrNull?.isLegalDelivery() ?? false) &&
          overSummary.balls.lastOrNull?.ball_number == 6 &&
          nextOverSummary?.inning_id == overSummary.inning_id) {
        children
            .add(CommentaryOverOverview(overSummary: overSummary, team: team));
        children.add(const SizedBox(height: 24));
      } else if (nextOverSummary != null &&
          nextOverSummary.inning_id != overSummary.inning_id) {
        children.add(_inningOverview(context,
            teamName: team?.name ?? "", targetRun: overSummary.totalRuns + 1));
      }

      for (final ball in overSummary.balls.reversed) {
        children.add(CommentaryBallSummary(
          ball: ball,
          overSummary: overSummary,
          showBallScore: false,
        ));
        children.add(const SizedBox(height: 8));
      }
    }
    return children;
  }

  TeamModel? _getTeamByTeamId(MatchDetailTabState state, String teamId) {
    return state.match?.teams
        .where((element) => element.team.id == teamId)
        .firstOrNull
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
