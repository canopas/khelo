import 'dart:async';
import 'package:data/api/match/match_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_match_list_view_model.freezed.dart';

final userMatchListStateProvider = StateNotifierProvider.autoDispose<
    UserMatchListViewNotifier, UserMatchListState>((ref) {
  return UserMatchListViewNotifier(
    ref.read(matchServiceProvider),
  );
});

class UserMatchListViewNotifier extends StateNotifier<UserMatchListState> {
  final MatchService _matchService;
  late StreamSubscription _matchesStreamSubscription;

  UserMatchListViewNotifier(this._matchService)
      : super(const UserMatchListState());

  Future<void> loadUserMatches() async {
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

  cancelStreamSubscription() async {
    await _matchesStreamSubscription.cancel();
  }

  @override
  Future<void> dispose() async {
    cancelStreamSubscription();
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
