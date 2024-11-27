import 'dart:async';

import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
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
    ref.read(userServiceProvider),
    ref.read(teamServiceProvider),
  );

  return notifier;
});

class UserDetailViewNotifier extends StateNotifier<UserDetailViewState> {
  final UserService _userService;
  final TeamService _teamService;
  StreamSubscription? _subscription;
  String? _userId;

  UserDetailViewNotifier(
    this._userService,
    this._teamService,
  ) : super(const UserDetailViewState());

  void setUserId(String id) {
    _userId = id;
    loadData();
  }

  void loadData() {
    if (_userId == null) {
      return;
    }
    _subscription?.cancel();
    state = state.copyWith(loading: true);
    final matchData = combineLatest3(
        _userService.streamUserById(_userId!),
        _teamService.streamUserRelatedTeamsByUserId(_userId!),
        _userService.streamUserStats(_userId!));

    _subscription = matchData.listen((event) async {
      state = state.copyWith(
        user: event.$1,
        teams: event.$2,
        userStats: event.$3,
        loading: false,
      );
    }, onError: (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint("UserDetailViewNotifier: error while loading data -> $e");
    });
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
class UserDetailViewState with _$UserDetailViewState {
  const factory UserDetailViewState({
    Object? error,
    UserModel? user,
    @Default(0) int selectedTab,
    @Default(false) bool loading,
    @Default([]) List<TeamModel> teams,
    @Default(null) List<UserStat>? userStats,
  }) = _UserDetailViewState;
}
