import 'dart:async';
import 'package:data/api/match/match_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_view_model.freezed.dart';

final homeViewStateProvider =
    StateNotifierProvider<HomeViewNotifier, HomeViewState>(
  (ref) => HomeViewNotifier(ref.read(matchServiceProvider)),
);

class HomeViewNotifier extends StateNotifier<HomeViewState> {
  final MatchService _matchService;
  late StreamSubscription _streamSubscription;

  HomeViewNotifier(this._matchService) : super(const HomeViewState()) {
    loadMatches();
  }

  void loadMatches() async {
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

  _cancelStreamSubscription() async {
    await _streamSubscription.cancel();
  }

  @override
  void dispose() {
    _cancelStreamSubscription();
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
