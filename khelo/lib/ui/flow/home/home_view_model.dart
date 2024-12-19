import 'dart:async';

import 'package:data/api/leaderboard/leaderboard_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/service/leaderboard/leaderboard_service.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/tournament/tournament_service.dart';
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
    final notifier = HomeViewNotifier(
      ref.read(matchServiceProvider),
      ref.read(tournamentServiceProvider),
      ref.read(leaderboardServiceProvider),
    );
    ref.listen(
        hasUserSession, (_, next) => notifier._onUserSessionUpdate(next));
    return notifier;
  },
);

class HomeViewNotifier extends StateNotifier<HomeViewState> {
  final MatchService _matchService;
  final TournamentService _tournamentService;
  final LeaderboardService _leaderboardService;
  StreamSubscription? _streamSubscription;

  HomeViewNotifier(
    this._matchService,
    this._tournamentService,
    this._leaderboardService,
  ) : super(const HomeViewState()) {
    loadData();
  }

  void _onUserSessionUpdate(bool hasSession) {
    if (!hasSession) {
      _streamSubscription?.cancel();
    }
  }

  void loadData() async {
    _streamSubscription?.cancel();
    state = state.copyWith(loading: state.matches.isEmpty);

    final combineFutures = combineLatest5(
      _matchService.streamActiveRunningMatches(),
      _matchService.streamUpcomingMatches(),
      _matchService.streamFinishedMatches(),
      _tournamentService.streamActiveTournaments(),
      _leaderboardService.streamLeaderboard(limit: 4),
    );

    _streamSubscription = combineFutures.listen(
      (results) {
        state = state.copyWith(
          matches: [...results.$1, ...results.$2, ...results.$3],
          groupMatches: {
            MatchStatusLabel.live: results.$1,
            MatchStatusLabel.upcoming: results.$2,
            MatchStatusLabel.finished: results.$3,
          },
          tournaments: results.$4,
          leaderboard: results.$5,
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
    @Default([]) List<TournamentModel> tournaments,
    @Default([]) List<LeaderboardModel> leaderboard,
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
