import 'package:data/api/innings/inning_model.dart';
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

    return _body(context, notifier,state);
  }

  Widget _body(BuildContext context, MatchDetailTabViewNotifier notifier,
      MatchDetailTabState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: () async {
          await notifier.cancelStreamSubscription();
          notifier.loadMatch();
        },
      );
    }

    if (state.ballScores.isEmpty) {
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
      BuildContext context, MatchDetailTabState state) {
    List<Widget> children = [];

    children.add(const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: FinalScoreView(),
    ));

    for (int index = state.ballScores.length - 1; index >= 0; index--) {
      if (_isLastBallOfOver(index, state)) {
        if (_isNewInning(index, state)) {
          children.add(_inningOverview(
              context, state, state.ballScores[index].inning_id));
        } else {
          children.add(BowlerSummary(
            state: state,
            index: index + 1,
            inningId: state.ballScores[index + 1].inning_id,
            bowlerId: state.ballScores[index + 1].bowler_id,
            isForBowlerIntro: true,
          ));
          children.add(const SizedBox(height: 24));
          children.add(CommentaryOverOverview(index: index));
          children.add(const SizedBox(
            height: 8,
          ));
        }
      }

      children.add(CommentaryBallSummary(
        state: state,
        ball: state.ballScores[index],
        showBallScore: false,
      ));
      children.add(const SizedBox(height: 8));
    }
    return children;
  }

  bool _isNewInning(int index, MatchDetailTabState state) {
    return state.ballScores[index].inning_id !=
        state.ballScores.elementAtOrNull(index + 1)?.inning_id;
  }

  bool _isLastBallOfOver(int index, MatchDetailTabState state) {
    return state.ballScores[index].over_number !=
        state.ballScores.elementAtOrNull(index + 1)?.over_number;
  }

  Widget _inningOverview(
    BuildContext context,
    MatchDetailTabState state,
    String inningId,
  ) {
    final inningStatus = state.firstInning?.id == inningId
        ? state.firstInning?.innings_status
        : state.secondInning?.innings_status;
    if (inningStatus == InningStatus.finish &&
        state.firstInning?.id == inningId) {
      final teamId = state.firstInning?.team_id;
      final teamName = state.match?.teams
          .firstWhere((element) => element.team.id == teamId)
          .team
          .name;
      return Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text.rich(TextSpan(
                text: "$teamName",
                style: AppTextStyle.header4
                    .copyWith(color: context.colorScheme.primary),
                children: [
                  TextSpan(
                    text: context.l10n.match_commentary_end_inning_text_part_1,
                    style: AppTextStyle.subtitle1
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                  TextSpan(
                      text: context.l10n.match_commentary_runs_text(
                          (state.firstInning?.total_runs ?? 0) + 1)),
                  TextSpan(
                    text: context.l10n.match_commentary_end_inning_text_part_2,
                    style: AppTextStyle.subtitle1
                        .copyWith(color: context.colorScheme.textPrimary),
                  ),
                ])),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
