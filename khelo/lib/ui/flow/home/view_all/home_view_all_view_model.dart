import 'package:data/api/match/match_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/tournament/tournament_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_view_all_view_model.freezed.dart';

final homeViewAllViewProvider = StateNotifierProvider.autoDispose<
        HomeViewAllViewNotifier, HomeViewAllViewState>(
    (ref) => HomeViewAllViewNotifier(
          ref.read(matchServiceProvider),
          ref.read(tournamentServiceProvider),
        ));

class HomeViewAllViewNotifier extends StateNotifier<HomeViewAllViewState> {
  final MatchService _matchService;
  final TournamentService _tournamentService;

  HomeViewAllViewNotifier(this._matchService, this._tournamentService)
      : super(const HomeViewAllViewState()) {
    loadMatches();
    loadTournaments();
  }

  List<MatchStatus> _status = [];
  bool _isTournament = false;
  bool _maxLoaded = false;
  String? _lastId;

  void setData(List<MatchStatus> status, bool isTournament) {
    _status = status;
    _isTournament = isTournament;
  }

  void loadMatches() async {
    if (_status.isEmpty) return;
    if (state.loading || _maxLoaded) return;
    try {
      state = state.copyWith(loading: state.matches.isEmpty);
      final matches = await _matchService.getMatchesByStatus(
        status: _status,
        lastMatchId: _lastId,
        limit: 10,
      );
      _maxLoaded = matches.length < 10;

      if (matches.isNotEmpty) {
        _lastId = matches.last.id;
      }
      state = state.copyWith(
          matches: {...state.matches, ...matches}.toList(), loading: false);
    } catch (error) {
      state = state.copyWith(error: error, loading: false);
      debugPrint("HomeViewAllViewNotifier: error while load matches -> $error");
    }
  }

  void loadTournaments() async {
    if (!_isTournament) return;
    if (state.loading || _maxLoaded) return;
    try {
      state = state.copyWith(loading: state.tournaments.isEmpty);
      final tournaments = await _tournamentService.getTournaments(
        lastMatchId: _lastId,
        limit: 10,
      );
      _maxLoaded = tournaments.length < 10;

      if (tournaments.isNotEmpty) {
        _lastId = tournaments.last.id;
      }
      state = state.copyWith(
          tournaments: {...state.tournaments, ...tournaments}.toList(),
          loading: false);
    } catch (error) {
      state = state.copyWith(error: error, loading: false);
      debugPrint(
          "HomeViewAllViewNotifier: error while load tournaments -> $error");
    }
  }
}

@freezed
class HomeViewAllViewState with _$HomeViewAllViewState {
  const factory HomeViewAllViewState({
    Object? error,
    @Default(false) bool loading,
    @Default([]) List<TournamentModel> tournaments,
    @Default([]) List<MatchModel> matches,
  }) = _HomeViewAllViewState;
}
