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
      state = state.copyWith(tournament: tournament, loading: false);
      onMatchFilter(null);
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
  }) = _TournamentDetailState;
}
