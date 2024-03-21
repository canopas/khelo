import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class TeamDetailStatContent extends ConsumerWidget {
  const TeamDetailStatContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamDetailStateProvider);

    if (state.matches
            ?.where((element) => element.match_status == MatchStatus.finish)
            .isEmpty ??
        true) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            context.l10n.team_detail_empty_stat_title,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
      );
    }

    return _content(context, state);
  }

  Widget _content(BuildContext context, TeamDetailState state) {
    return Column(
      children: [
        const SizedBox(height: 24),
        _matchPlayedCount(context, state),
        const SizedBox(height: 24),
        _winLostAndTiedCountView(context, state),
        const SizedBox(height: 16),
        _runWicketView(context, state),
        const SizedBox(height: 16),
        _averageCountView(
          context,
          context.l10n.team_detail_batting_average_title,
          "${_calculateTeamBattingAverage(state)}",
        ),
        const SizedBox(height: 16),
        _averageCountView(
          context,
          context.l10n.team_detail_bowling_average_title,
          "${_calculateTeamBowlingAverage(state)}",
        ),
        const SizedBox(height: 16),
        _highestAndLowestRunCount(context, state),
        const SizedBox(height: 16),
        _runRateCount(context, state)
      ],
    );
  }

  Widget _matchPlayedCount(BuildContext context, TeamDetailState state) {
    final playedMatchCount = state.matches
            ?.where((element) => element.match_status == MatchStatus.finish)
            .length ??
        0;
    return Center(
      child: Text.rich(
        TextSpan(
            text: playedMatchCount.toString(),
            style: AppTextStyle.header1
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              TextSpan(
                text: playedMatchCount == 1
                    ? context.l10n.team_detail_match_played_title
                    : context.l10n.team_detail_matches_played_title,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textSecondary),
              )
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _winLostAndTiedCountView(
    BuildContext context,
    TeamDetailState state,
  ) {
    final (win, lost, tie) = _calculateTotalMatchResultCount(state);
    return Row(
      children: [
        Expanded(
          child: _matchResultCountCell(context,
              title: context.l10n.team_detail_won_title,
              count: win.toDouble(),
              tintColor: context.colorScheme.positive),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: _matchResultCountCell(context,
              title: context.l10n.team_detail_lost_title,
              count: lost.toDouble(),
              tintColor: context.colorScheme.alert),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: _matchResultCountCell(context,
              title: context.l10n.team_detail_tied_title,
              count: tie.toDouble(),
              tintColor: context.colorScheme.warning),
        ),
      ],
    );
  }

  (int, int, int) _calculateTotalMatchResultCount(TeamDetailState state) {
    if (state.matches == null) {
      return (0, 0, 0);
    }

    var win = 0;
    var lost = 0;
    var tie = 0;

    for (final match in state.matches!
        .where((element) => element.match_status == MatchStatus.finish)) {
      final firstTeam = match.toss_decision == TossDecision.bat
          ? match.teams
              .firstWhere((element) => element.team.id == match.toss_winner_id)
          : match.teams
              .firstWhere((element) => element.team.id != match.toss_winner_id);
      final secondTeam = match.teams
          .firstWhere((element) => element.team.id != firstTeam.team.id);

      if (firstTeam.run! == secondTeam.run!) {
        tie += 1;
      } else if (firstTeam.run! > secondTeam.run!) {
        if (firstTeam.team.id == state.team?.id) {
          win += 1;
        } else {
          lost += 1;
        }
      } else {
        if (secondTeam.team.id == state.team?.id) {
          win += 1;
        } else {
          lost += 1;
        }
      }
    }

    return (win, lost, tie);
  }

  Widget _matchResultCountCell(
    BuildContext context, {
    required String title,
    required double count,
    bool showFraction = false,
    Color? tintColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tintColor?.withOpacity(0.5) ??
            context.colorScheme.containerLowOnSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
            text:
                "${showFraction ? "${count.toStringAsFixed(2)}%" : count.toInt().toString()} ",
            style: AppTextStyle.header1
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              TextSpan(
                text: title,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textSecondary),
              )
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _runWicketView(
    BuildContext context,
    TeamDetailState state,
  ) {
    final (runs, wickets) = _calculateTotalRunsAndWickets(state);
    return Row(
      children: [
        Expanded(
            child: _totalRunsWicketCountCell(
                context, context.l10n.team_detail_runs_made_title, runs)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: _totalRunsWicketCountCell(context,
                context.l10n.team_detail_wickets_taken_title, wickets)),
      ],
    );
  }

  (int, int) _calculateTotalRunsAndWickets(TeamDetailState state) {
    if (state.matches == null) {
      return (0, 0);
    }

    var runs = 0;
    var wicket = 0;

    for (final match in state.matches!
        .where((element) => element.match_status == MatchStatus.finish)) {
      final team = match.teams
          .firstWhere((element) => element.team.id == state.team?.id);

      runs += (team.run ?? 0);
      wicket += (team.wicket ?? 0);
    }

    return (runs, wicket);
  }

  Widget _totalRunsWicketCountCell(
      BuildContext context, String title, int count) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.containerLowOnSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
            text: "$count",
            style: AppTextStyle.header1
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              TextSpan(
                text: "\n$title",
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textSecondary),
              )
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _averageCountView(BuildContext context, String title, String average) {
    return Center(
      child: Text.rich(
        TextSpan(
            text: average,
            style: AppTextStyle.header1
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              TextSpan(
                text: title,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textSecondary),
              )
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }

  double _calculateTeamBattingAverage(TeamDetailState state) {
    if (state.matches == null) {
      return 0;
    }
    final matches = state.matches!
        .where((element) => element.match_status == MatchStatus.finish);
    int totalTeamRuns = 0;
    int totalTeamOuts = 0;

    for (var match in matches) {
      final team = match.teams
          .firstWhere((element) => element.team.id == state.team?.id);

      final opponentTeam = match.teams
          .firstWhere((element) => element.team.id != state.team?.id);

      totalTeamRuns += team.run ?? 0;
      totalTeamOuts += opponentTeam.wicket ?? 0;
    }

    if (totalTeamOuts > 0) {
      return totalTeamRuns / totalTeamOuts;
    } else {
      return 0;
    }
  }

  double _calculateTeamBowlingAverage(TeamDetailState state) {
    if (state.matches == null) {
      return 0;
    }
    final matches = state.matches!
        .where((element) => element.match_status == MatchStatus.finish);

    int totalTeamRunsConceded = 0;
    int totalTeamWicketsTaken = 0;

    for (var match in matches) {
      final team = match.teams
          .firstWhere((element) => element.team.id == state.team?.id);

      final opponentTeam = match.teams
          .firstWhere((element) => element.team.id != state.team?.id);

      totalTeamRunsConceded += opponentTeam.run ?? 0;
      totalTeamWicketsTaken += team.wicket ?? 0;
    }

    if (totalTeamWicketsTaken > 0) {
      return totalTeamRunsConceded / totalTeamWicketsTaken;
    } else {
      return 0;
    }
  }

  Widget _highestAndLowestRunCount(
      BuildContext context, TeamDetailState state) {
    final (highest, lowest) = _calculateHighestAndLowestRun(state);
    return Row(
      children: [
        Expanded(
            child: _totalRunsWicketCountCell(
                context, context.l10n.team_detail_highest_runs_title, highest)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: _totalRunsWicketCountCell(
                context, context.l10n.team_detail_lowest_runs_title, lowest)),
      ],
    );
  }

  (int, int) _calculateHighestAndLowestRun(TeamDetailState state) {
    if (state.matches == null) {
      return (0, 0);
    }

    final completedMatches = state.matches!
        .where((element) => element.match_status == MatchStatus.finish);

    final firstTeam = completedMatches.first.teams
        .firstWhere((element) => element.team.id == state.team?.id);

    var highest = firstTeam.run ?? 0;
    var lowest = firstTeam.run ?? 0;

    for (final match in completedMatches) {
      final team = match.teams
          .firstWhere((element) => element.team.id == state.team?.id);

      if ((team.run ?? 0) > highest) {
        highest = team.run ?? 0;
      }
      if ((team.run ?? 0) < lowest) {
        lowest = team.run ?? 0;
      }
    }

    return (highest, lowest);
  }

  Widget _runRateCount(
    BuildContext context,
    TeamDetailState state,
  ) {
    return Row(
      children: [
        Expanded(
            child: _matchResultCountCell(
          context,
          title: context.l10n.team_detail_run_rate_title,
          count: _calculateRunRate(state),
          showFraction: true,
        )),
      ],
    );
  }

  double _calculateRunRate(TeamDetailState state) {
    final matches = state.matches!
        .where((element) => element.match_status == MatchStatus.finish);
    int totalRuns = 0;
    double totalOvers = 0.0;

    for (var match in matches) {
      final team = match.teams
          .firstWhere((element) => element.team.id == state.team?.id);
      int runs = team.run ?? 0;
      double overs = team.over ?? 0;

      totalRuns += runs;
      totalOvers += overs;
    }

    double runRate = totalRuns / totalOvers;

    return runRate;
  }
}
