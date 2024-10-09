import 'dart:async';

import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:data/utils/combine_latest.dart';
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
  StreamSubscription? _teamStreamSubscription;
  final TeamService _teamService;
  final MatchService _matchService;
  String? _teamId;

  TeamDetailViewNotifier(this._teamService, this._matchService, String? userId)
      : super(TeamDetailState(currentUserId: userId));

  void setData(String teamId) {
    _teamId = teamId;
    loadData();
  }

  void loadData() {
    if (_teamId == null) return;
    _teamStreamSubscription?.cancel();
    state =
        state.copyWith(loading: state.team == null || state.matches == null);
    final teamCombiner = combineLatest2(_teamService.streamTeamById(_teamId!),
        _matchService.streamMatchesByTeamId(_teamId!));
    _teamStreamSubscription = teamCombiner.listen((data) {
      final teamStat = _calculateTeamStat(_teamId!, data.$2);

      state = state.copyWith(
        team: data.$1,
        matches: data.$2,
        teamStat: teamStat,
        loading: false,
      );
    }, onError: (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint(
          "TeamDetailViewNotifier: error while loading team and matches by id -> $e");
    });
  }

  TeamStat _calculateTeamStat(String teamId, List<MatchModel> matches) {
    final finishedMatches = _filterFinishedMatches(matches);
    if (finishedMatches.isEmpty) return const TeamStat();
    final totalRuns = _totalRuns(teamId, finishedMatches);
    return TeamStat(
      played: finishedMatches.length,
      status: _teamMatchStatus(teamId, finishedMatches),
      runs: totalRuns,
      wickets: _wickets(teamId, finishedMatches),
      batting_average: _battingAverage(teamId, finishedMatches),
      bowling_average: _bowlingAverage(teamId, finishedMatches),
      highest_runs: _highestAndLowestRuns(teamId, finishedMatches).$1,
      lowest_runs: _highestAndLowestRuns(teamId, finishedMatches).$2,
      run_rate: _runRate(teamId, finishedMatches, totalRuns),
    );
  }

  List<MatchModel> _filterFinishedMatches(List<MatchModel> matches) {
    return matches
        .where((match) => match.match_status == MatchStatus.finish)
        .toList();
  }

  int _totalRuns(String teamId, List<MatchModel> finishedMatches) {
    return finishedMatches
        .map((match) => _getTeam(match, teamId))
        .fold<int>(0, (totalRuns, team) => totalRuns + team.run);
  }

  int _wickets(String teamId, List<MatchModel> finishedMatches) {
    return finishedMatches
        .map((match) => _getTeam(match, teamId))
        .fold<int>(0, (totalWickets, team) => totalWickets + team.wicket);
  }

  double _battingAverage(String teamId, List<MatchModel> finishedMatches) {
    return finishedMatches.fold<double>(
      0,
      (total, match) {
        final team = _getTeam(match, teamId);
        final opponentTeam = _getOpponentTeam(match, teamId);

        return total +
            (opponentTeam.wicket > 0 ? team.run / opponentTeam.wicket : 0);
      },
    );
  }

  MatchTeamModel _getTeam(MatchModel match, String teamId) =>
      match.teams.firstWhere((team) => team.team.id == teamId);

  MatchTeamModel _getOpponentTeam(MatchModel match, String teamId) =>
      match.teams.firstWhere((team) => team.team.id != teamId);

  double _bowlingAverage(String teamId, List<MatchModel> finishedMatches) {
    return finishedMatches.fold<double>(
          0,
          (total, match) {
            final team = _getTeam(match, teamId);
            final opponentTeam = _getOpponentTeam(match, teamId);

            return total +
                (team.wicket > 0 ? opponentTeam.run / team.wicket : 0);
          },
        ) /
        finishedMatches.length;
  }

  (int, int) _highestAndLowestRuns(
      String teamId, List<MatchModel> finishedMatches) {
    final firstTeamRuns =
        finishedMatches.map((match) => _getTeam(match, teamId).run).toList();
    if (firstTeamRuns.isEmpty) {
      return (0, 0);
    }
    final highestRuns = firstTeamRuns
        .reduce((value, element) => element > value ? element : value);
    final lowestRuns = firstTeamRuns
        .reduce((value, element) => element < value ? element : value);
    return (highestRuns, lowestRuns);
  }

  double _runRate(String teamId, List<MatchModel> finishedMatches, int runs) {
    final totalOvers = finishedMatches
        .map((match) => _getTeam(match, teamId))
        .fold<double>(0.0, (total, team) => total + team.over);

    return totalOvers > 0 ? runs / totalOvers : 0;
  }

  TeamMatchStatus _teamMatchStatus(
      String teamId, List<MatchModel> finishedMatches) {
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

  @override
  void dispose() {
    _teamStreamSubscription?.cancel();
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
