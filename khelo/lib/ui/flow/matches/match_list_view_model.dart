import 'dart:async';

import 'package:data/api/match/match_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_list_view_model.freezed.dart';

final matchListStateProvider =
    StateNotifierProvider<MatchListViewNotifier, MatchListViewState>((ref) {
  final notifier = MatchListViewNotifier(
    ref.read(matchServiceProvider),
    ref.read(currentUserPod)?.id,
  );
  ref.listen(currentUserPod, (previous, next) {
    notifier._setUserId(next?.id);
  });
  return notifier;
});

class MatchListViewNotifier extends StateNotifier<MatchListViewState> {
  final MatchService _matchService;
  StreamSubscription? _matchesStreamSubscription;

  MatchListViewNotifier(this._matchService, String? userId)
      : super(MatchListViewState(currentUserId: userId)) {
    loadMatches();
  }

  void _setUserId(String? userId) {
    if (userId == null) {
      _matchesStreamSubscription?.cancel();
    }
    state = state.copyWith(currentUserId: userId);
    loadMatches();
  }

  Future<void> loadMatches() async {
    if (state.currentUserId == null) {
      return;
    }
    _matchesStreamSubscription?.cancel();
    state = state.copyWith(loading: true);
    try {
      _matchesStreamSubscription = _matchService
          .streamUserRelatedMatches(state.currentUserId ?? '')
          .listen((matches) {
        state = state.copyWith(matches: matches, loading: false, error: null);
      }, onError: (e) {
        state = state.copyWith(loading: false, error: e);
        debugPrint("MatchListViewNotifier: error while load matches -> $e");
      });
    } catch (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint("MatchListViewNotifier: error while load matches -> $e");
    }
  }

  @override
  void dispose() {
    _matchesStreamSubscription?.cancel();
    super.dispose();
  }
}

@freezed
class MatchListViewState with _$MatchListViewState {
  const factory MatchListViewState({
    Object? error,
    String? currentUserId,
    List<MatchModel>? matches,
    @Default(false) bool loading,
  }) = _MatchListViewState;
}
