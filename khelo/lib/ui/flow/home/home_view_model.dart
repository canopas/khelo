import 'dart:async';
import 'package:data/api/match/match_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_view_model.freezed.dart';

final homeViewStateProvider =
    StateNotifierProvider.autoDispose<HomeViewNotifier, HomeViewState>(
  (ref) {
    final notifier = HomeViewNotifier(ref.read(matchServiceProvider));
    ref.listen(
        hasUserSession, (_, next) => notifier._onUserSessionUpdate(next));
    return notifier;
  },
);

class HomeViewNotifier extends StateNotifier<HomeViewState> {
  final MatchService _matchService;
  late StreamSubscription _streamSubscription;

  HomeViewNotifier(this._matchService) : super(const HomeViewState()) {
    _loadMatches();
  }

  void _onUserSessionUpdate(bool hasSession) {
    if (!hasSession) {
      _streamSubscription.cancel();
    }
  }

  void _loadMatches() async {
    state = state.copyWith(loading: state.matches.isEmpty);

    _streamSubscription = _matchService.getRunningMatches().listen(
      (matches) {
        state = state.copyWith(matches: matches, loading: false, error: null);
      },
      onError: (e) {
        state = state.copyWith(error: e, loading: false);
        debugPrint("HomeViewNotifier: error while load matches -> $e");
      },
    );
  }

  onResume() {
    _streamSubscription.cancel();
    _loadMatches();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}

@freezed
class HomeViewState with _$HomeViewState {
  const factory HomeViewState({
    Object? error,
    @Default(false) bool loading,
    @Default([]) List<MatchModel> matches,
  }) = _HomeViewState;
}
