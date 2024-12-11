import 'dart:async';

import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/tournament/tournament_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:data/utils/combine_latest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

part 'tournament_detail_view_model.freezed.dart';

final tournamentDetailStateProvider = StateNotifierProvider.autoDispose<
    TournamentDetailStateViewNotifier, TournamentDetailState>(
  (ref) => TournamentDetailStateViewNotifier(
    ref.read(tournamentServiceProvider),
    ref.read(matchServiceProvider),
    ref.read(currentUserPod)?.id,
  ),
);

class TournamentDetailStateViewNotifier
    extends StateNotifier<TournamentDetailState> {
  final TournamentService _tournamentService;
  final MatchService _matchService;
  StreamSubscription? _tournamentSubscription;
  StreamSubscription? _matchSubscription;

  TournamentDetailStateViewNotifier(
    this._tournamentService,
    this._matchService,
    String? userId,
  ) : super(TournamentDetailState(currentUserId: userId));

  String? _tournamentId;

  void setData(String tournamentId) {
    _tournamentId = tournamentId;
    loadTournament();
  }

  void loadTournament() async {
    if (_tournamentId == null) return;
    _tournamentSubscription?.cancel();

    state = state.copyWith(loading: true);

    final tournamentData = combineLatest3(
        _tournamentService.streamTournamentById(_tournamentId!),
        _tournamentService.streamTeamStats(_tournamentId!),
        _tournamentService.streamPlayerKeyStats(_tournamentId!));

    _tournamentSubscription = tournamentData.listen((data) async {
      final tournament = data.$1;
      final teamStats = data.$2;
      final keyStats = data.$3.getTopKeyStats();

      _matchSubscription?.cancel();
      _matchSubscription = _matchService
          .streamMatchesByIds(tournament.match_ids)
          .listen((matches) {
        state = state.copyWith(
          tournament: tournament,
          teamStats: teamStats,
          keyStats: keyStats,
          matches: matches,
          loading: false,
        );
        onMatchFilter(null);
        onStatFilter(state.selectedFilterTag);
      });
    }, onError: (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "TournamentDetailStateViewNotifier: error while loading tournament data -> $e");
    });
  }

  void onTabChange(int tab) {
    if (state.selectedTab != tab) {
      state = state.copyWith(selectedTab: tab);
    }
  }

  void onTeamsSelected(List<TeamModel> teams) async {
    if (state.tournament == null) return;
    try {
      final teamIds = teams.map((e) => e.id).toList();
      await _tournamentService.updateTeamIds(state.tournament!.id, teamIds);
    } catch (e) {
      state = state.copyWith(actionError: e);
      debugPrint(
          "TournamentDetailStateViewNotifier: error while selecting teams -> $e");
    }
  }

  void onMatchFilter(String? filter) {
    if (state.matches.isEmpty || state.tournament == null) return;

    final matches = state.matches.toList();

    if (filter == null) {
      state = state.copyWith(filteredMatches: matches);
      return;
    }
    final names = state.tournament!.teams.map((e) => e.name).toList();

    if (names.contains(filter)) {
      final filteredMatches = matches.where((match) {
        return match.teams.any((team) => team.team.name == filter);
      }).toList();

      state = state.copyWith(
        matchFilter: filter,
        filteredMatches: filteredMatches,
      );
    } else {
      state = state.copyWith(matchFilter: filter, filteredMatches: matches);
    }
  }

  void onStatFilter(KeyStatFilterTag tag) {
    if (state.tournament == null) return;

    var filteredStats = state.keyStats.toList();

    filteredStats = filteredStats.where((e) {
      switch (tag) {
        case KeyStatFilterTag.all:
          return true;
        case KeyStatFilterTag.runs:
          return e.stats.batting.run_scored > 0;
        case KeyStatFilterTag.wickets:
          return e.stats.bowling.wicket_taken > 0.0;
        case KeyStatFilterTag.battingAverage:
          return e.stats.batting.average > 0.0;
        case KeyStatFilterTag.bowlingAverage:
          return e.stats.bowling.average > 0.0;
        case KeyStatFilterTag.mostHundreds:
          return e.stats.batting.hundreds > 0;
        case KeyStatFilterTag.mostFifties:
          return e.stats.batting.fifties > 0;
        case KeyStatFilterTag.sixes:
          return e.stats.batting.sixes > 0;
        case KeyStatFilterTag.fours:
          return e.stats.batting.fours > 0;
        case KeyStatFilterTag.boundaries:
          return e.stats.batting.fours + e.stats.batting.sixes > 0;
      }
    }).toList();

    filteredStats.sort((a, b) {
      int compareByTag(PlayerKeyStat x, PlayerKeyStat y) {
        switch (tag) {
          case KeyStatFilterTag.mostHundreds:
            return y.stats.batting.hundreds.compareTo(x.stats.batting.hundreds);
          case KeyStatFilterTag.mostFifties:
            return y.stats.batting.fifties.compareTo(x.stats.batting.fifties);
          case KeyStatFilterTag.boundaries:
            return (y.stats.batting.fours + y.stats.batting.sixes)
                .compareTo(x.stats.batting.fours + x.stats.batting.sixes);
          default:
            return b.stats.batting.run_scored
                .compareTo(a.stats.batting.run_scored);
        }
      }

      return compareByTag(a, b);
    });

    filteredStats.sort((a, b) =>
        (b.stats.batting.run_scored).compareTo(a.stats.batting.run_scored));

    state = state.copyWith(
      filteredStats: filteredStats,
      selectedFilterTag: tag,
    );
  }

  @override
  void dispose() {
    _tournamentSubscription?.cancel();
    _matchSubscription?.cancel();
    super.dispose();
  }
}

@freezed
class TournamentDetailState with _$TournamentDetailState {
  const factory TournamentDetailState({
    @Default(null) TournamentModel? tournament,
    @Default(false) bool loading,
    @Default(0) int selectedTab,
    Object? error,
    Object? actionError,
    String? currentUserId,
    @Default(null) String? matchFilter,
    @Default([]) List<MatchModel> matches,
    @Default([]) List<TournamentTeamStat> teamStats,
    @Default([]) List<PlayerKeyStat> keyStats,
    @Default([]) List<MatchModel> filteredMatches,
    @Default(KeyStatFilterTag.all) KeyStatFilterTag selectedFilterTag,
    @Default([]) List<PlayerKeyStat> filteredStats,
  }) = _TournamentDetailState;
}

enum KeyStatFilterTag {
  all,
  runs,
  wickets,
  battingAverage,
  bowlingAverage,
  mostHundreds,
  mostFifties,
  sixes,
  fours,
  boundaries;

  String getString(BuildContext context) {
    switch (this) {
      case KeyStatFilterTag.all:
        return context.l10n.key_stat_all;
      case KeyStatFilterTag.runs:
        return context.l10n.key_stat_filter_runs;
      case KeyStatFilterTag.wickets:
        return context.l10n.key_stat_filter_wickets;
      case KeyStatFilterTag.battingAverage:
        return context.l10n.common_batting_average_title;
      case KeyStatFilterTag.bowlingAverage:
        return context.l10n.common_bowling_average_title;
      case KeyStatFilterTag.mostHundreds:
        return context.l10n.key_stat_filter_most_hundreds;
      case KeyStatFilterTag.mostFifties:
        return context.l10n.key_stat_filter_most_fifties;
      case KeyStatFilterTag.sixes:
        return context.l10n.key_stat_filter_sixes;
      case KeyStatFilterTag.fours:
        return context.l10n.key_stat_filter_fours;
      case KeyStatFilterTag.boundaries:
        return context.l10n.key_stat_filter_boundaries;
    }
  }
}
