import 'dart:async';

import 'package:data/api/match/match_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:data/utils/combine_latest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

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
  StreamSubscription? _streamSubscription;

  HomeViewNotifier(this._matchService) : super(const HomeViewState()) {
    loadMatches();
  }

  void _onUserSessionUpdate(bool hasSession) {
    if (!hasSession) {
      _streamSubscription?.cancel();
    }
  }

  void loadMatches() async {
    _streamSubscription?.cancel();
    state = state.copyWith(loading: state.matches.isEmpty);

    final matchCombiner = combineLatest3(
        _matchService.streamActiveRunningMatches(),
        _matchService.streamUpcomingMatches(),
        _matchService.streamFinishedMatches());

    _streamSubscription = matchCombiner.listen(
      (allMatches) {
        state = state.copyWith(
          matches: [...allMatches.$1, ...allMatches.$2, ...allMatches.$3],
          groupMatches: {
            MatchStatusLabel.live: allMatches.$1,
            MatchStatusLabel.upcoming: allMatches.$2,
            MatchStatusLabel.finished: allMatches.$3,
          },
          loading: false,
          error: null,
        );
      },
      onError: (e) {
        state = state.copyWith(error: e, loading: false);
        debugPrint("HomeViewNotifier: error while load matches -> $e");
      },
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}

@freezed
class HomeViewState with _$HomeViewState {
  const factory HomeViewState({
    Object? error,
    @Default(false) bool loading,
    @Default([]) List<MatchModel> matches,
    @Default({}) Map<MatchStatusLabel, List<MatchModel>> groupMatches,
  }) = _HomeViewState;
}

enum MatchStatusLabel {
  live,
  upcoming,
  finished;

  String getString(BuildContext context) {
    switch (this) {
      case MatchStatusLabel.live:
        return context.l10n.home_screen_live_title;
      case MatchStatusLabel.upcoming:
        return context.l10n.home_screen_upcoming_title;
      case MatchStatusLabel.finished:
        return context.l10n.home_screen_finished_title;
    }
  }

  List<MatchStatus> convertStatus() {
    switch (this) {
      case MatchStatusLabel.live:
        return [MatchStatus.running];
      case MatchStatusLabel.upcoming:
        return [MatchStatus.yetToStart];
      case MatchStatusLabel.finished:
        return [MatchStatus.finish, MatchStatus.abandoned];
    }
  }
}
