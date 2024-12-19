import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/team/detail/components/primer_progress_bar.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class TeamDetailStatContent extends ConsumerWidget {
  const TeamDetailStatContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamDetailStateProvider);

    if (state.matches
        .where((element) => element.match_status == MatchStatus.finish)
        .isEmpty) {
      return EmptyScreen(
        title: context.l10n.team_detail_empty_stat_title,
        description: context.l10n.team_detail_empty_stat_description_text,
        isShowButton: false,
      );
    }

    return _content(context, state);
  }

  Widget _content(BuildContext context, TeamDetailState state) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _matchPlayedProgress(
          context,
          state.team!.stat.status,
          state.team!.stat.played,
        ),
        const SizedBox(height: 16),
        _teamStatsView(context, state.team!.stat),
      ],
    );
  }

  Widget _matchPlayedProgress(
    BuildContext context,
    TeamMatchStatus status,
    int playedMatches,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.containerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.team_detail_match_title(playedMatches),
            textAlign: TextAlign.center,
            style: AppTextStyle.header2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          const SizedBox(height: 16),
          PrimerProgressBar(status: status),
        ],
      ),
    );
  }

  Widget _teamStatsView(BuildContext context, TeamStat stat) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _teamStatCell(context,
              title: context.l10n.team_detail_runs_made_title,
              count: stat.runs.toString()),
          _teamStatCell(context,
              title: context.l10n.team_detail_wickets_taken_title,
              count: stat.wickets.toString()),
          _teamStatCell(context,
              title: context.l10n.common_batting_average_title,
              count: stat.batting_average.toStringAsFixed(2)),
          _teamStatCell(context,
              title: context.l10n.common_bowling_average_title,
              count: stat.bowling_average.toStringAsFixed(2)),
          _teamStatCell(context,
              title: context.l10n.team_detail_highest_runs_title,
              count: stat.highest_runs.toString()),
          _teamStatCell(context,
              title: context.l10n.team_detail_lowest_runs_title,
              count: stat.lowest_runs.toString()),
          _teamStatCell(context,
              title: context.l10n.team_detail_run_rate_title,
              count: '${stat.run_rate.toStringAsFixed(2)}%'),
        ],
      ),
    );
  }

  Widget _teamStatCell(
    BuildContext context, {
    required String title,
    required String count,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.body1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ),
          Text(
            count,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          )
        ],
      ),
    );
  }
}
