import 'dart:async';
import 'package:collection/collection.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/service/tournament/tournament_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:style/extensions/date_extensions.dart';

part 'tournament_list_view_model.freezed.dart';

final tournamentListViewStateProvider =
    StateNotifierProvider<TournamentListViewNotifier, TournamentListViewState>(
  (ref) => TournamentListViewNotifier(ref.read(tournamentServiceProvider)),
);

class TournamentListViewNotifier
    extends StateNotifier<TournamentListViewState> {
  final TournamentService _tournamentService;
  StreamSubscription? _tournamentStreamSubscription;

  TournamentListViewNotifier(this._tournamentService)
      : super(const TournamentListViewState()) {
    loadTournaments();
  }

  Future<void> loadTournaments() async {
    _tournamentStreamSubscription?.cancel();
    state = state.copyWith(loading: state.groupTournaments.isEmpty);
    try {
      _tournamentStreamSubscription = _tournamentService
          .streamCurrentUserRelatedMatches()
          .listen((tournaments) {
        final groupTournaments = _groupTournaments(tournaments);
        state = state.copyWith(
            groupTournaments: groupTournaments, loading: false, error: null);
      }, onError: (e) {
        state = state.copyWith(loading: false, error: e);
        debugPrint(
            "TournamentListViewNotifier: error while loading tournament list -> $e");
      });
    } catch (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint(
          "TournamentListViewNotifier: error while loading tournament list -> $e");
    }
  }

  Map<DateTime, List<TournamentModel>> _groupTournaments(
      List<TournamentModel> tournaments) {
    return groupBy(
      tournaments,
      (tournament) => tournament.start_date.startOfMonth,
    );
  }

  @override
  void dispose() {
    _tournamentStreamSubscription?.cancel();
    super.dispose();
  }
}

@freezed
class TournamentListViewState with _$TournamentListViewState {
  const factory TournamentListViewState({
    Object? error,
    @Default(true) bool loading,
    @Default({}) Map<DateTime, List<TournamentModel>> groupTournaments,
  }) = _TournamentListViewState;
}
