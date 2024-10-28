import 'dart:async';

import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/service/tournament/tournament_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_detail_view_model.freezed.dart';

final tournamentDetailStateProvider = StateNotifierProvider.autoDispose<
    TournamentDetailStateViewNotifier, TournamentDetailState>(
  (ref) =>
      TournamentDetailStateViewNotifier(ref.read(tournamentServiceProvider)),
);

class TournamentDetailStateViewNotifier
    extends StateNotifier<TournamentDetailState> {
  final TournamentService _tournamentService;
  StreamSubscription? _tournamentSubscription;

  TournamentDetailStateViewNotifier(this._tournamentService)
      : super(const TournamentDetailState());

  String? _tournamentId;

  void setData(String tournamentId) {
    _tournamentId = tournamentId;
    loadTournament();
  }

  void loadTournament() async {
    if (_tournamentId == null) return;
    _tournamentSubscription?.cancel();

    state = state.copyWith(loading: true);

    _tournamentSubscription = _tournamentService
        .streamTournamentById(_tournamentId!)
        .listen((tournament) {
      final teamPoints = _calculatePointsTable(tournament);
      state = state.copyWith(
        tournament: tournament,
        teamPoints: teamPoints,
        loading: false,
      );
      onMatchFilter(null);
      onStatFilter(null);
    }, onError: (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "TournamentDetailStateViewNotifier: error while loading tournament list -> $e");
    });
  }

  void onTabChange(int tab) {
    if (state.selectedTab != tab) {
      state = state.copyWith(selectedTab: tab);
    }
  }

  void onTeamsSelected(List<TeamModel> teams) async {
    if (state.tournament == null) return;
    try {
      final teamIds = teams.map((e) => e.id).toList();
      await _tournamentService.updateTeamIds(state.tournament!.id, teamIds);
    } catch (e) {
      state = state.copyWith(actionError: e);
      debugPrint(
          "TournamentDetailStateViewNotifier: error while selecting teams -> $e");
    }
  }

  void onMatchesSelected(List<MatchModel> matches) async {
    if (state.tournament == null) return;
    try {
      final matchIds = matches.map((e) => e.id).toList();
      await _tournamentService.updateMatchIds(state.tournament!.id, matchIds);
    } catch (e) {
      state = state.copyWith(actionError: e);
      debugPrint(
          "TournamentDetailStateViewNotifier: error while selecting matches -> $e");
    }
  }

  void onMatchFilter(String? filter) {
    if (state.tournament == null) return;

    final matches = state.tournament!.matches;

    if (filter == null) {
      state = state.copyWith(filteredMatches: matches);
      return;
    }
    final names = state.tournament!.teams.map((e) => e.name).toList();

    if (names.contains(filter)) {
      final filteredMatches = matches.where((match) {
        return match.teams.any((team) => team.team.name == filter);
      }).toList();

      state = state.copyWith(
        matchFilter: filter,
        filteredMatches: filteredMatches,
      );
    } else {
      state = state.copyWith(matchFilter: filter, filteredMatches: matches);
    }
  }

  void onStatFilter(KeyStatTag? tag) {
    if (state.tournament == null) return;

    final filteredStats = state.tournament!.keyStats
        .where((element) => element.tag == (tag ?? state.statFilter))
        .toList();
    state = state.copyWith(
        filteredStats: filteredStats, statFilter: tag ?? state.statFilter);
  }

  List<TeamPoint> _calculatePointsTable(TournamentModel tournament) {
    List<TeamPoint> teamPoints = [];

    final finishedMatches = _filterFinishedMatches(tournament.matches);

    if (finishedMatches.isEmpty) return [];

    for (final team in tournament.teams) {
      final matches = finishedMatches
          .where((element) => element.team_ids.contains(team.id))
          .toList();
      final teamStat = _teamStat(team.id, matches);
      //If team has won then add 2 points and tie then add 1 point
      final points = teamStat.status.win * 2 + teamStat.status.tie;
      teamPoints.add(TeamPoint(
        team: team,
        stat: teamStat,
        points: points,
        matchCount: matches.length,
      ));
    }
    return teamPoints..sort((a, b) => b.points.compareTo(a.points));
  }

  TeamStat _teamStat(String teamId, List<MatchModel> matches) {
    if (matches.isEmpty) return const TeamStat();
    return TeamStat(
      played: matches.length,
      status: _teamMatchStatus(teamId, matches),
      run_rate: _runRate(teamId, matches),
    );
  }

  List<MatchModel> _filterFinishedMatches(List<MatchModel> matches) {
    return matches
        .where((match) => match.match_status == MatchStatus.finish)
        .toList();
  }

  double _runRate(String teamId, List<MatchModel> finishedMatches) {
    final runs = finishedMatches
        .map((match) => _getTeam(match, teamId))
        .fold<int>(0, (totalRuns, team) => totalRuns + team.run);

    final totalOvers = finishedMatches
        .map((match) => _getTeam(match, teamId))
        .fold<double>(0.0, (total, team) => total + team.over);

    return totalOvers > 0 ? runs / totalOvers : 0;
  }

  MatchTeamModel _getTeam(MatchModel match, String teamId) =>
      match.teams.firstWhere((team) => team.team.id == teamId);

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

  @override
  void dispose() {
    _tournamentSubscription?.cancel();
    super.dispose();
  }
}

@freezed
class TournamentDetailState with _$TournamentDetailState {
  const factory TournamentDetailState({
    @Default(null) TournamentModel? tournament,
    @Default(false) bool loading,
    @Default(0) int selectedTab,
    Object? error,
    Object? actionError,
    @Default(null) String? matchFilter,
    @Default([]) List<MatchModel> filteredMatches,
    @Default(KeyStatTag.mostRuns) KeyStatTag statFilter,
    @Default([]) List<PlayerKeyStat> filteredStats,
    @Default([]) List<TeamPoint> teamPoints,
  }) = _TournamentDetailState;
}
