import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/final_score_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/components/over_score_view.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_view_model.dart';
import 'package:khelo/domain/extensions/data_model_extensions/ball_score_model_extension.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class MatchDetailOversView extends ConsumerWidget {
  const MatchDetailOversView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchDetailTabStateProvider);

    return _body(context, state);
  }

  Widget _body(BuildContext context, MatchDetailTabState state) {
    if (state.loading) {
      return const Center(child: AppProgressIndicator());
    }
    if (state.ballScores.isEmpty) {
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
      padding: context.mediaQueryPadding +
          const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const FinalScoreView(),
        ..._buildOverList(context, state, state.firstInning?.id ?? ""),
        ..._buildOverList(context, state, state.secondInning?.id ?? ""),
      ],
    );
  }

  List<Widget> _buildOverList(
      BuildContext context, MatchDetailTabState state, String inningId) {
    final filterBallScore = state.ballScores
        .where((element) => inningId == element.inning_id)
        .toList();

    final oversList = filterBallScore.chunkArrayByOver();
    List<Widget> children = [];
    for (int i = oversList.length - 1; i >= 0; i--) {
      final over = oversList[i];

      children.add(const SizedBox(height: 16));

      children.add(_overCellView(context, over));
    }
    children.add(
      _teamNameTitleView(context, state, inningId),
    );

    return children;
  }

  Widget _overCellView(BuildContext context, List<BallScoreModel> over) {
    final overCount = over.first.over_number;
    final runs = over.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.runs_scored +
            (element.extras_awarded ?? 0));
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.match_commentary_former_over_short_text(overCount),
              style: AppTextStyle.header4
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            Text(
              context.l10n.match_commentary_runs_text(runs),
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
          ],
        )),
        Expanded(
            flex: 4,
            child: OverScoreView(
              over: over,
              size: 35,
            ))
      ],
    );
  }

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

  Widget _teamNameTitleView(
      BuildContext context, MatchDetailTabState state, String inningId) {
    final title = _getTeamNameByInningId(state, inningId);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8, left: 4, right: 4),
      child: Text(
        title,
        style: AppTextStyle.header1
            .copyWith(color: context.colorScheme.textSecondary),
      ),
    );
  }
}
