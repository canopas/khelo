import 'dart:async';

import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/service/tournament/tournament_service.dart';
import 'package:data/service/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_view_model.freezed.dart';

final searchHomeViewProvider = StateNotifierProvider.autoDispose<
        SearchHomeViewNotifier, SearchHomeViewState>(
    (ref) => SearchHomeViewNotifier(
        ref.read(matchServiceProvider),
        ref.read(teamServiceProvider),
        ref.read(tournamentServiceProvider),
        ref.read(userServiceProvider)));

class SearchHomeViewNotifier extends StateNotifier<SearchHomeViewState> {
  static const int _limit = 20;
  final MatchService _matchService;
  final TeamService _teamService;
  final TournamentService _tournamentService;
  final UserService _userService;

  Timer? _debounce;

  String _searchKey = "";

  bool _maxTeamLoaded = false;
  bool _maxUserLoaded = false;
  bool _maxTournamentLoaded = false;
  bool _maxMatchLoaded = false;
  String? _lastTeamId;
  String? _lastUserId;
  String? _lastTournamentId;
  String? _lastMatchId;

  SearchHomeViewNotifier(
    this._matchService,
    this._teamService,
    this._tournamentService,
    this._userService,
  ) : super(SearchHomeViewState(searchController: TextEditingController()));

  Future<void> _search(String searchKey) async {
    try {
      state = state.copyWith(loading: true);
      _maxTeamLoaded = false;
      _maxUserLoaded = false;
      _maxTournamentLoaded = false;
      _maxMatchLoaded = false;
      _lastTeamId = null;
      _lastUserId = null;
      _lastTournamentId = null;
      _lastMatchId = null;

      _searchKey = searchKey;
      await Future.wait([
        searchTeam(),
        searchUser(),
        searchTournament(),
      ]);
      await searchMatches();
      state = state.copyWith(error: null, loading: false);
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint("SearchHomeViewNotifier: error while search teams -> $e");
    }
  }

  Future<void> searchTeam() async {
    try {
      if (_maxTeamLoaded || _searchKey.isEmpty) return;
      final teams = await _teamService.searchTeam(
        _searchKey,
        limit: _limit,
        lastTeamId: _lastTeamId,
      );
      state = state.copyWith(teams: {...state.teams, ...teams}.toList());

      _lastTeamId = teams.lastOrNull?.id;
      _maxTeamLoaded = teams.length < _limit;
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint("SearchHomeViewNotifier: error while search teams -> $e");
    }
  }

  Future<void> searchUser() async {
    try {
      if (_maxUserLoaded || _searchKey.isEmpty) return;

      state = state.copyWith(loading: true);

      final users = await _userService.searchUser(
        _searchKey,
        limit: _limit,
        lastUserId: _lastUserId,
      );

      state = state.copyWith(users: {...state.users, ...users}.toList());

      _lastUserId = users.lastOrNull?.id;
      _maxUserLoaded = users.length < _limit;
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint("SearchHomeViewNotifier: error while search users -> $e");
    }
  }

  Future<void> searchTournament() async {
    try {
      if (_maxTournamentLoaded || _searchKey.isEmpty) return;

      final tournaments = await _tournamentService.searchTournament(
        _searchKey,
        limit: _limit,
        lastTournamentId: _lastTournamentId,
      );
      state = state.copyWith(
        tournaments: {...state.tournaments, ...tournaments}.toList(),
      );

      _lastTournamentId = tournaments.lastOrNull?.id;
      _maxTournamentLoaded = tournaments.length < _limit;
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "SearchHomeViewNotifier: error while search tournaments -> $e");
    }
  }

  Future<void> searchMatches() async {
    try {
      if (_maxMatchLoaded || state.teams.isEmpty) return;

      final matches = await _matchService.getMatchByTeamIds(
          teamIds: state.teams.map((e) => e.id).toList(),
          limit: _limit,
          lastMatchId: _lastMatchId);
      state = state.copyWith(matches: {...state.matches, ...matches}.toList());

      _lastMatchId = matches.lastOrNull?.id;
      _maxMatchLoaded = matches.length < _limit;
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint("SearchHomeViewNotifier: error while search matches -> $e");
    }
  }

  void onTabChange(int tab) {
    state = state.copyWith(selectedTab: tab);
  }

  void onChange() {
    final searchKey = state.searchController.text.toLowerCase().trim();
    if (searchKey.isEmpty) {
      state =
          state.copyWith(matches: [], teams: [], tournaments: [], users: []);
      return;
    }
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _search(searchKey);
    });
  }

  void onClear() {
    state.searchController.clear();
    state = state.copyWith(matches: [], teams: [], tournaments: [], users: []);
  }

  @override
  void dispose() {
    state.searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}

@freezed
class SearchHomeViewState with _$SearchHomeViewState {
  const factory SearchHomeViewState({
    required TextEditingController searchController,
    Object? error,
    @Default(false) bool loading,
    @Default([]) List<MatchModel> matches,
    @Default([]) List<TeamModel> teams,
    @Default([]) List<TournamentModel> tournaments,
    @Default([]) List<UserModel> users,
    @Default(0) int selectedTab,
  }) = _SearchHomeViewState;
}
