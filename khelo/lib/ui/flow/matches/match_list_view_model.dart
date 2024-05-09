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
    notifier.setUserId(next?.id);
  });
  return notifier;
});

class MatchListViewNotifier extends StateNotifier<MatchListViewState> {
  final MatchService _matchService;
  late StreamSubscription _matchesStreamSubscription;

  MatchListViewNotifier(this._matchService, String? userId)
      : super(MatchListViewState(
          currentUserId: userId,
        )) {
    _loadMatches();
  }

  void setUserId(String? userId) {
    state = state.copyWith(currentUserId: userId);
  }

  Future<void> _loadMatches() async {
    state = state.copyWith(loading: true);
    try {
      _matchesStreamSubscription =
          _matchService.getCurrentUserRelatedMatches().listen((matches) {
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

  _cancelStreamSubscription() async {
    await _matchesStreamSubscription.cancel();
  }

  onResume(){
    _cancelStreamSubscription();
    _loadMatches();
  }

  @override
  void dispose() {
    _cancelStreamSubscription();
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
