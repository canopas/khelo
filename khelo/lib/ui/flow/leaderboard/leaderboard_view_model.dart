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
  static const int _limit = 20;

  final LeaderboardService _leaderboardService;
  bool _maxBattingLoaded = false;
  bool _maxBowlingLoaded = false;
  bool _maxFieldingLoaded = false;
  LeaderboardPlayer? _lastBattingUser;
  LeaderboardPlayer? _lastBowlingUser;
  LeaderboardPlayer? _lastFieldingUser;

  LeaderboardViewNotifier(this._leaderboardService)
      : super(LeaderboardViewState());

  void onTabChange(int tab) {
    if (state.selectedTab != tab) {
      state = state.copyWith(selectedTab: tab);
    }

    final selectedTab = LeaderboardField.values.elementAt(state.selectedTab);
    if ((selectedTab == LeaderboardField.batting &&
            state.battingLeaderboard.isEmpty) ||
        (selectedTab == LeaderboardField.bowling &&
            state.bowlingLeaderboard.isEmpty) ||
        (selectedTab == LeaderboardField.fielding &&
            state.fieldingLeaderboard.isEmpty)) {
      loadLeaderboard();
    }
  }

  Future<void> loadLeaderboard() async {
    try {
      final selectedTab = LeaderboardField.values.elementAt(state.selectedTab);

      switch (selectedTab) {
        case LeaderboardField.batting:
          if (state.loading || _maxBattingLoaded) return;
        case LeaderboardField.bowling:
          if (state.loading || _maxBowlingLoaded) return;
        case LeaderboardField.fielding:
          if (state.loading || _maxFieldingLoaded) return;
      }

      state = state.copyWith(loading: true);

      final players = await _leaderboardService.getLeaderboardByField(
          limit: _limit,
          field: selectedTab,
          lastPlayer: selectedTab == LeaderboardField.batting
              ? _lastBattingUser
              : selectedTab == LeaderboardField.bowling
                  ? _lastBowlingUser
                  : _lastFieldingUser);
      state = state.copyWith(
        battingLeaderboard: selectedTab == LeaderboardField.batting
            ? {...state.battingLeaderboard, ...players}.toList()
            : state.battingLeaderboard,
        bowlingLeaderboard: selectedTab == LeaderboardField.bowling
            ? {...state.bowlingLeaderboard, ...players}.toList()
            : state.bowlingLeaderboard,
        fieldingLeaderboard: selectedTab == LeaderboardField.fielding
            ? {...state.fieldingLeaderboard, ...players}.toList()
            : state.fieldingLeaderboard,
        loading: false,
        error: null,
      );

      final lastPlayer = players.lastOrNull;
      switch (selectedTab) {
        case LeaderboardField.batting:
          _lastBattingUser = lastPlayer;
          _maxBattingLoaded = players.length < _limit;
        case LeaderboardField.bowling:
          _lastBowlingUser = lastPlayer;
          _maxBowlingLoaded = players.length < _limit;
        case LeaderboardField.fielding:
          _lastFieldingUser = lastPlayer;
          _maxFieldingLoaded = players.length < _limit;
      }
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "LeaderboardViewNotifier: error while loading leaderboard -> $e");
    }
  }
}

@freezed
class LeaderboardViewState with _$LeaderboardViewState {
  const factory LeaderboardViewState({
    Object? error,
    @Default([]) List<LeaderboardPlayer> battingLeaderboard,
    @Default([]) List<LeaderboardPlayer> bowlingLeaderboard,
    @Default([]) List<LeaderboardPlayer> fieldingLeaderboard,
    @Default(false) bool loading,
    @Default(0) int selectedTab,
  }) = _LeaderboardViewState;
}
