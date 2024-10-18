import 'dart:async';

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
  }) = _TournamentDetailState;
}
