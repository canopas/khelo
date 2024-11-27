import 'dart:async';

import 'package:data/api/user/user_models.dart';
import 'package:data/service/user/user_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stat_view_model.freezed.dart';

final userStatViewStateProvider =
    StateNotifierProvider<UserStatViewNotifier, UserStatViewState>((ref) {
  final notifier = UserStatViewNotifier(
    ref.read(userServiceProvider),
    ref.read(currentUserPod)?.id,
  );
  ref.listen(currentUserPod, (previous, next) {
    notifier._setUserId(next?.id);
  });
  return notifier;
});

class UserStatViewNotifier extends StateNotifier<UserStatViewState> {
  final UserService _userService;
  StreamSubscription? _subscription;
  String? _currentUserId;

  UserStatViewNotifier(
    this._userService,
    this._currentUserId,
  ) : super(const UserStatViewState()) {
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

    _subscription =
        _userService.streamUserStats(_currentUserId!).listen((userStats) async {
      state = state.copyWith(userStats: userStats, loading: false);
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
class UserStatViewState with _$UserStatViewState {
  const factory UserStatViewState({
    Object? error,
    @Default(0) int selectedTab,
    @Default(null) List<UserStat>? userStats,
    @Default(false) bool loading,
  }) = _UserStatViewState;
}
