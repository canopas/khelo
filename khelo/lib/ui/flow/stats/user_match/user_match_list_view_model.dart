import 'dart:async';
import 'package:data/api/match/match_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_match_list_view_model.freezed.dart';

final userMatchListStateProvider =
    StateNotifierProvider<UserMatchListViewNotifier, UserMatchListState>((ref) {
  final notifier = UserMatchListViewNotifier(ref.read(matchServiceProvider));
  ref.listen(hasUserSession, (_, next) => notifier._onUserSessionUpdate(next));
  return notifier;
});

class UserMatchListViewNotifier extends StateNotifier<UserMatchListState> {
  final MatchService _matchService;
  late StreamSubscription _matchesStreamSubscription;

  UserMatchListViewNotifier(this._matchService)
      : super(const UserMatchListState()) {
    _loadUserMatches();
  }

  void _onUserSessionUpdate(bool hasSession) {
    if (!hasSession) {
      _cancelStreamSubscription();
    }
  }

  Future<void> _loadUserMatches() async {
    state = state.copyWith(loading: true);
    try {
      _matchesStreamSubscription =
          _matchService.getCurrentUserPlayedMatches().listen((matches) {
        state = state.copyWith(matches: matches, loading: false, error: null);
      }, onError: (e) {
        state = state.copyWith(error: e, loading: false);
        debugPrint(
            "UserMatchListViewNotifier: error while loading user matches -> $e");
      });
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "UserMatchListViewNotifier: error while loading user matches -> $e");
    }
  }

  _cancelStreamSubscription() async {
    await _matchesStreamSubscription.cancel();
  }

  onResume() {
    _cancelStreamSubscription();
    _loadUserMatches();
  }

  @override
  Future<void> dispose() async {
    _cancelStreamSubscription();
    super.dispose();
  }
}

@freezed
class UserMatchListState with _$UserMatchListState {
  const factory UserMatchListState({
    Object? error,
    @Default(false) bool loading,
    @Default([]) List<MatchModel> matches,
  }) = _UserMatchListState;
}
