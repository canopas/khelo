import 'dart:async';

import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/service/ball_score/ball_score_service.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stat_view_model.freezed.dart';

final userStatViewStateProvider =
    StateNotifierProvider<UserStatViewNotifier, UserStatViewState>((ref) {
  final notifier = UserStatViewNotifier(
    ref.read(matchServiceProvider),
    ref.read(ballScoreServiceProvider),
    ref.read(currentUserPod)?.id,
  );
  ref.listen(currentUserPod, (previous, next) {
    notifier._setUserId(next?.id);
  });
  return notifier;
});

class UserStatViewNotifier extends StateNotifier<UserStatViewState> {
  final MatchService _matchService;
  final BallScoreService _ballScoreService;
  StreamSubscription? _subscription;
  String? _currentUserId;

  UserStatViewNotifier(
      this._matchService, this._ballScoreService, this._currentUserId)
      : super(const UserStatViewState()) {
    loadData();
  }

  void _setUserId(String? userId) {
    if (userId == null) {
      _subscription?.cancel();
    }
    _currentUserId = userId;
    loadData();
  }

  void loadData() {
    if (_currentUserId == null) {
      return;
    }
    _subscription?.cancel();
    state = state.copyWith(loading: true);

    _subscription = _matchService.streamUserMatches(_currentUserId!).listen(
        (matches) async {
      final (testMatchCount, testStat, otherMatchCount, otherStats) =
          await _loadMatchData(matches);
      state = state.copyWith(
        testStats: testStat,
        otherStats: otherStats,
        testMatchesCount: testMatchCount,
        otherMatchesCount: otherMatchCount,
        loading: false,
      );
    }, onError: (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint("UserDetailViewNotifier: error while loading data -> $e");
    });
  }

  Future<(int, UserStat, int, UserStat)> _loadMatchData(
      List<MatchModel> matches) async {
    try {
      final testMatches = matches
          .where((element) => element.match_type == MatchType.testMatch)
          .map((e) => e.id);
      final otherMatches = matches
          .where((element) => element.match_type != MatchType.testMatch)
          .map((e) => e.id);
      final ballScore = await _ballScoreService
          .getBallScoresByMatchIds(matches.map((e) => e.id).toList());

      final testStats = ballScore
          .where((element) => testMatches.contains(element.match_id))
          .toList()
          .calculateUserStats(_currentUserId ?? '');
      final otherStats = ballScore
          .where((element) => otherMatches.contains(element.match_id))
          .toList()
          .calculateUserStats(_currentUserId ?? '');

      return (testMatches.length, testStats, otherMatches.length, otherStats);
    } catch (e) {
      debugPrint(
          "UserDetailViewNotifier: error while loading match data -> $e");
      rethrow;
    }
  }

  void onTabChange(int tab) {
    if (state.selectedTab != tab) {
      state = state.copyWith(selectedTab: tab);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

@freezed
class UserStatViewState with _$UserStatViewState {
  const factory UserStatViewState({
    Object? error,
    @Default(0) int selectedTab,
    @Default(0) int testMatchesCount,
    @Default(0) int otherMatchesCount,
    @Default(UserStat()) UserStat testStats,
    @Default(UserStat()) UserStat otherStats,
    @Default(false) bool loading,
  }) = _UserStatViewState;
}
