import 'package:data/api/match/match_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_list_view_model.freezed.dart';

final matchListStateProvider = StateNotifierProvider.autoDispose<
    MatchListViewNotifier, MatchListViewState>((ref) {
  return MatchListViewNotifier(ref.read(matchServiceProvider));
});

class MatchListViewNotifier extends StateNotifier<MatchListViewState> {
  final MatchService _matchService;

  MatchListViewNotifier(this._matchService)
      : super(const MatchListViewState()) {
    loadMatches();
  }

  Future<void> loadMatches() async {
    state = state.copyWith(loading: true);
    try {
      final matches = await _matchService.getMatches();
      state = state.copyWith(matches: matches, loading: false);
    } catch (e, stack) {
      state = state.copyWith(loading: false, error: e);
      debugPrint("MatchListViewNotifier: error while load matches -> $e ,\nstack: $stack");
    }
  }
}

@freezed
class MatchListViewState with _$MatchListViewState {
  const factory MatchListViewState({
    Object? error,
    @Default(false) bool loading,
    List<MatchModel>? matches,
  }) = _MatchListViewState;
}
