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
        onRetryTap: () => notifier.onResume(),
      );
    }

    if (state.overList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            context.l10n.match_overs_empty_over_text,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
      );
    }

    return ListView(
      padding: context.mediaQueryPadding,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: FinalScoreView(),
        ),
        ..._buildOverListV1(context, state),
      ],
    );
  }

  List<Widget> _buildOverListV1(
      BuildContext context, MatchDetailTabState state) {
    List<Widget> children = [];

    for (int i = state.overList.length - 1; i >= 0; i--) {
      final over = state.overList.elementAt(i);
      final nextOver = state.overList.elementAtOrNull(i + 1);
      if (nextOver?.inning_id != over.inning_id) {
        children.add(
          _teamNameTitleView(context, state, over.inning_id,
              state.firstInning?.id == over.inning_id ? 1 : 2),
        );

        children.add(_overCellView(context, over.balls, over.bowler.player.name,
            over.striker.player.name, over.nonStriker.player.name));
        if (nextOver?.inning_id == over.inning_id) {
          children.add(Divider(height: 32, color: context.colorScheme.outline));
        }
      }
    }
    return children;
  }

  // List<Widget> _buildOverList(BuildContext context, MatchDetailTabState state,
  //     String inningId, int inningCount) {
  //   final filterBallScore = state.ballScores
  //       .where((element) => inningId == element.inning_id)
  //       .toList();
  //
  //   final oversList = filterBallScore.chunkArrayByOver();
  //   List<Widget> children = [];
  //
  //   if (oversList.isNotEmpty) {
  //     children.add(
  //       _teamNameTitleView(context, state, inningId, inningCount),
  //     );
  //   }
  //
  //   for (int i = oversList.length - 1; i >= 0; i--) {
  //     final over = oversList[i];
  //     final (bowler, striker, nonStriker) = _getPlayerName(state, over.last);
  //     children.add(_overCellView(context, over, bowler, striker, nonStriker));
  //     if (i != 0) {
  //       children.add(Divider(height: 32, color: context.colorScheme.outline));
  //     }
  //   }
  //
  //   return children;
  // }

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

  // (String, String, String) _getPlayerName(
  //     MatchDetailTabState state, BallScoreModel ball) {
  //   final battingTeamId = ball.inning_id == state.firstInning?.id
  //       ? state.firstInning?.team_id
  //       : state.secondInning?.team_id;
  //   final bowlingTeamId = ball.inning_id == state.firstInning?.id
  //       ? state.secondInning?.team_id
  //       : state.firstInning?.team_id;
  //   final battingSquad = state.match?.teams
  //       .firstWhere((element) => battingTeamId == element.team.id)
  //       .team
  //       .players;
  //   final bowlingSquad = state.match?.teams
  //       .firstWhere((element) => bowlingTeamId == element.team.id)
  //       .team
  //       .players;
  //
  //   final bowlerName = bowlingSquad
  //       ?.firstWhere((element) => element.id == ball.bowler_id)
  //       .name;
  //
  //   final batsmanName = battingSquad
  //       ?.firstWhere((element) => element.id == ball.batsman_id)
  //       .name;
  //   final nonStriker = battingSquad
  //       ?.firstWhere((element) => element.id == ball.non_striker_id)
  //       .name;
  //
  //   return (bowlerName ?? "", batsmanName ?? "", nonStriker ?? "");
  // }

  String _getTeamNameByInningId(MatchDetailTabState state, String inningId) {
    final teamId = state.firstInning?.id == inningId
        ? state.firstInning?.team_id
        : state.secondInning?.team_id;

    final teamName = state.match?.teams
        .where((element) => element.team.id == teamId)
        .firstOrNull
        ?.team
        .name;
    return teamName ?? "--";
  }

  Widget _teamNameTitleView(BuildContext context, MatchDetailTabState state,
      String inningId, int inningCount) {
    final title = _getTeamNameByInningId(state, inningId);
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
      child: Text(
        "${context.l10n.match_commentary_inning_count_text(inningCount)}: $title",
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
    );
  }
}
