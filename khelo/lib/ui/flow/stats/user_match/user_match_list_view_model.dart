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

  UserMatchListViewNotifier(this._matchService)
      : super(const UserMatchListState()) {
    loadUserMatches();
  }

  Future<void> loadUserMatches() async {
    state = state.copyWith(loading: true);
    try {
      final matches = await _matchService.getCurrentUserMatches();
      state = state.copyWith(matches: matches, loading: false);
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "UserMatchListViewNotifier: error while loading user matches -> $e");
    }
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
