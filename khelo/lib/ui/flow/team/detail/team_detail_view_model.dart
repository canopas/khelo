import 'dart:async';

import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_detail_view_model.freezed.dart';

final teamDetailStateProvider =
    StateNotifierProvider.autoDispose<TeamDetailViewNotifier, TeamDetailState>(
        (ref) => TeamDetailViewNotifier(
              ref.read(teamServiceProvider),
              ref.read(matchServiceProvider),
              ref.read(currentUserPod)?.id,
            ));

class TeamDetailViewNotifier extends StateNotifier<TeamDetailState> {
  late StreamSubscription _teamStreamSubscription;
  final TeamService _teamService;
  final MatchService _matchService;
  String? teamId;

  TeamDetailViewNotifier(this._teamService, this._matchService, String? userId)
      : super(TeamDetailState(currentUserId: userId));

  void setData(String teamId) {
    this.teamId = teamId;
    loadTeamById();
  }

  Future<void> loadTeamById() async {
    if (teamId == null) return;

    state = state.copyWith(loading: state.team == null);
    _teamStreamSubscription =
        _teamService.getTeamStreamById(teamId!).listen((team) {
      state = state.copyWith(team: team, loading: false);
      loadTeamMatches();
    }, onError: (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint(
          "TeamDetailViewNotifier: error while loading team by id -> $e");
    });
  }

  Future<void> loadTeamMatches() async {
    if (state.team == null) {
      return;
    }
    try {
      state = state.copyWith(loading: state.matches == null);
      final matches = await _matchService
          .getMatchesByTeamId(state.team!.id ?? "INVALID ID");
      final teamStat = _calculateTeamStat(matches);
      state =
          state.copyWith(matches: matches, teamStat: teamStat, loading: false);
    } catch (e) {
      debugPrint(
          "TeamDetailViewNotifier: error while loading team matches -> $e");
    }
  }

  TeamStat _calculateTeamStat(List<MatchModel> matches) {
    final finishedMatches = _filterFinishedMatches(matches);
    if (finishedMatches.isEmpty) return const TeamStat();
    return TeamStat(
      played: finishedMatches.length,
      status: _teamMatchStatus(finishedMatches),
      runs: _totalRuns(finishedMatches),
      wickets: _wickets(finishedMatches),
      bating_average: _battingAverage(finishedMatches),
      bowling_average: _bowlingAverage(finishedMatches),
      highest_runs: _highestAndLowestRuns(finishedMatches).$1,
      lowest_runts: _highestAndLowestRuns(finishedMatches).$2,
      run_rate: _runRate(finishedMatches, _totalRuns(finishedMatches)),
    );
  }

  List<MatchModel> _filterFinishedMatches(List<MatchModel> matches) {
    return matches
        .where((match) => match.match_status == MatchStatus.finish)
        .toList();
  }

  int _totalRuns(List<MatchModel> finishedMatches) {
    return finishedMatches
        .map((match) =>
            match.teams.firstWhere((team) => team.team.id == state.team?.id))
        .fold<int>(0, (totalRuns, team) => totalRuns + team.run);
  }

  int _wickets(List<MatchModel> finishedMatches) {
    return finishedMatches
        .map((match) =>
            match.teams.firstWhere((team) => team.team.id == state.team?.id))
        .fold<int>(0, (totalWickets, team) => totalWickets + team.wicket);
  }

  double _battingAverage(List<MatchModel> finishedMatches) {
    return finishedMatches.fold<double>(
      0,
      (total, match) {
        final team =
            match.teams.firstWhere((team) => team.team.id == state.team?.id);
        final opponentTeam =
            match.teams.firstWhere((team) => team.team.id != state.team?.id);

        return total +
            (opponentTeam.wicket > 0 ? team.run / opponentTeam.wicket : 0);
      },
    );
  }

  double _bowlingAverage(List<MatchModel> finishedMatches) {
    return finishedMatches.fold<double>(
          0,
          (total, match) {
            final team = match.teams
                .firstWhere((team) => team.team.id == state.team?.id);
            final opponentTeam = match.teams
                .firstWhere((team) => team.team.id != state.team?.id);

            return total +
                (team.wicket > 0 ? opponentTeam.run / team.wicket : 0);
          },
        ) /
        finishedMatches.length;
  }

  (int, int) _highestAndLowestRuns(List<MatchModel> finishedMatches) {
    final firstTeamRuns = finishedMatches
        .map((match) => match.teams
            .firstWhere((team) => team.team.id == state.team?.id)
            .run)
        .toList();

    final highestRuns = firstTeamRuns
        .reduce((value, element) => element > value ? element : value);
    final lowestRuns = firstTeamRuns
        .reduce((value, element) => element < value ? element : value);
    return (highestRuns, lowestRuns);
  }

  double _runRate(List<MatchModel> finishedMatches, int runs) {
    final totalOvers = finishedMatches
        .map(
            (match) => match.teams.firstWhere((team) => team.team.id == teamId))
        .fold<double>(0.0, (total, team) => total + team.over);

    return totalOvers > 0 ? runs / totalOvers : 0;
  }

  TeamMatchStatus _teamMatchStatus(List<MatchModel> finishedMatches) {
    return finishedMatches.fold<TeamMatchStatus>(
      const TeamMatchStatus(),
      (status, match) {
        final firstTeam = match.teams.firstWhere((team) =>
            team.team.id ==
            (match.toss_decision == TossDecision.bat
                ? match.toss_winner_id
                : match.teams
                    .firstWhere((team) => team.team.id != match.toss_winner_id)
                    .team
                    .id));

        final secondTeam =
            match.teams.firstWhere((team) => team.team.id != firstTeam.team.id);

        if (firstTeam.run == secondTeam.run) {
          return TeamMatchStatus(
              win: status.win, lost: status.lost, tie: status.tie + 1);
        } else if ((firstTeam.run > secondTeam.run &&
                firstTeam.team.id == teamId) ||
            (firstTeam.run < secondTeam.run && secondTeam.team.id == teamId)) {
          return TeamMatchStatus(
              win: status.win + 1, lost: status.lost, tie: status.tie);
        } else {
          return TeamMatchStatus(
              win: status.win, lost: status.lost + 1, tie: status.tie);
        }
      },
    );
  }

  void onTabChange(int tab) {
    if (state.selectedTab != tab) {
      state = state.copyWith(selectedTab: tab);
    }
  }

  onResume() {
    _teamStreamSubscription.cancel();
    loadTeamById();
  }

  @override
  void dispose() {
    _teamStreamSubscription.cancel();
    super.dispose();
  }
}

@freezed
class TeamDetailState with _$TeamDetailState {
  const factory TeamDetailState({
    Object? error,
    TeamModel? team,
    String? currentUserId,
    List<MatchModel>? matches,
    @Default(0) int selectedTab,
    @Default(false) bool loading,
    @Default(TeamStat()) TeamStat teamStat,
  }) = _TeamDetailState;
}
