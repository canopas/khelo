import 'dart:async';

import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/service/ball_score/ball_score_service.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/service/user/user_service.dart';
import 'package:data/utils/combine_latest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_detail_view_model.freezed.dart';

final userDetailStateProvider = StateNotifierProvider.autoDispose<
    UserDetailViewNotifier, UserDetailViewState>((ref) {
  final notifier = UserDetailViewNotifier(
    ref.read(matchServiceProvider),
    ref.read(ballScoreServiceProvider),
    ref.read(userServiceProvider),
    ref.read(teamServiceProvider),
  );

  return notifier;
});

class UserDetailViewNotifier extends StateNotifier<UserDetailViewState> {
  final MatchService _matchService;
  final BallScoreService _ballScoreService;
  final UserService _userService;
  final TeamService _teamService;
  StreamSubscription? _subscription;
  String? userId;

  UserDetailViewNotifier(
    this._matchService,
    this._ballScoreService,
    this._userService,
    this._teamService,
  ) : super(const UserDetailViewState());

  void setUserId(String id) {
    userId = id;
    loadData();
  }

  void loadData() {
    if (userId == null) {
      return;
    }
    _subscription?.cancel();
    state = state.copyWith(loading: true);
    final matchData = combineLatest3(
        _userService.streamUserById(userId!),
        _teamService.streamUserRelatedTeamsByUserId(userId!),
        _matchService.streamUserMatches(userId!));

    _subscription = matchData.listen((event) async {
      final (testMatchCount, testStat, otherMatchCount, otherStats) =
          await loadMatchData(event.$3);
      state = state.copyWith(
        user: event.$1,
        teams: event.$2,
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

  Future<(int, UserStat, int, UserStat)> loadMatchData(
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
          .calculateUserStats(userId ?? '');
      final otherStats = ballScore
          .where((element) => otherMatches.contains(element.match_id))
          .toList()
          .calculateUserStats(userId ?? '');

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
}

@freezed
class UserDetailViewState with _$UserDetailViewState {
  const factory UserDetailViewState({
    Object? error,
    UserModel? user,
    @Default(0) int selectedTab,
    @Default(false) bool loading,
    @Default([]) List<TeamModel> teams,
    @Default(0) int testMatchesCount,
    @Default(0) int otherMatchesCount,
    @Default(UserStat()) UserStat testStats,
    @Default(UserStat()) UserStat otherStats,
  }) = _UserDetailViewState;
}
