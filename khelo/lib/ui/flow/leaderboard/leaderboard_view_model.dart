import 'dart:async';

import 'package:data/api/leaderboard/leaderboard_model.dart';
import 'package:data/service/leaderboard/leaderboard_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_view_model.freezed.dart';

final leaderboardStateProvider = StateNotifierProvider.autoDispose<
    LeaderboardViewNotifier, LeaderboardViewState>((ref) {
  return LeaderboardViewNotifier(ref.read(leaderboardServiceProvider));
});

class LeaderboardViewNotifier extends StateNotifier<LeaderboardViewState> {
  final LeaderboardService _leaderboardService;
  StreamSubscription? _streamSubscription;

  LeaderboardViewNotifier(this._leaderboardService)
      : super(LeaderboardViewState()) {
    loadLeaderboard();
  }

  void onTabChange(int tab) {
    if (state.selectedTab != tab) {
      state = state.copyWith(selectedTab: tab);
    }
  }

  void loadLeaderboard() {
    _streamSubscription?.cancel();
    state = state.copyWith(loading: state.leaderboard.isEmpty);

    _streamSubscription =
        _leaderboardService.streamLeaderboard().listen(
      (results) {
        state = state.copyWith(
          leaderboard: results,
          loading: false,
          error: null,
        );
      },
      onError: (e) {
        state = state.copyWith(error: e, loading: false);
        debugPrint("LeaderboardViewNotifier: error while loading leaderboard -> $e");
      },
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}

@freezed
class LeaderboardViewState with _$LeaderboardViewState {
  const factory LeaderboardViewState({
    Object? error,
    @Default([]) List<LeaderboardModel> leaderboard,
    @Default(false) bool loading,
    @Default(0) int selectedTab,
  }) = _LeaderboardViewState;
}
