import 'dart:async';
import 'dart:collection';

import 'package:data/api/match/match_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/extensions/string_extensions.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/tournament/tournament_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/ui/flow/tournament/match_selection/match_scheduler.dart';

part 'match_selection_view_model.freezed.dart';

typedef GroupedMatchMap = Map<MatchGroup, Map<int, List<MatchModel>>>;

final matchSelectionStateProvider = StateNotifierProvider.autoDispose<
        MatchSelectionViewNotifier, MatchSelectionState>(
    (ref) => MatchSelectionViewNotifier(
        ref.read(tournamentServiceProvider), ref.read(matchServiceProvider)));

class MatchSelectionViewNotifier extends StateNotifier<MatchSelectionState> {
  final TournamentService _tournamentService;
  final MatchService _matchService;
  late MatchScheduler _scheduler;

  StreamSubscription? _tournamentSubscription;
  StreamSubscription? _matchSubscription;
  String? _tournamentId;
  Timer? _debounce;

  MatchSelectionViewNotifier(this._tournamentService, this._matchService)
      : super(MatchSelectionState(searchController: TextEditingController()));

  void setData(String tournamentId) {
    _tournamentId = tournamentId;
    loadTournament();
  }

  void loadTournament() async {
    if (_tournamentId == null) return;
    _tournamentSubscription?.cancel();

    state = state.copyWith(loading: true);

    _tournamentSubscription = _tournamentService
        .streamTournamentById(_tournamentId!)
        .listen((tournament) async {
      _matchSubscription?.cancel();
      _matchSubscription = _matchService
          .streamMatchesByIds(tournament.match_ids)
          .listen((matches) {
        _scheduler = MatchScheduler(tournament.teams, matches, tournament.type);
        final scheduledMatches = _scheduler.scheduleMatchesByType();
        final sorted =
            SplayTreeMap<MatchGroup, Map<int, List<MatchModel>>>.from(
                scheduledMatches, (a, b) => a.index.compareTo(b.index));
        if (mounted) {
          state = state.copyWith(
            tournament: tournament,
            matches: sorted,
            loading: false,
          );
        }
      });
    }, onError: (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "MatchSelectionViewNotifier: error while loading tournament -> $e");
    });
  }

  Future<void> _search(String searchKey) async {
    state = state.copyWith(searchInProgress: true);

    try {
      final filter = filterMatches(state.matches, searchKey);
      state = state.copyWith(
        searchResults: filter,
        error: null,
        searchInProgress: false,
      );
    } catch (e) {
      state = state.copyWith(
        searchInProgress: false,
        error: e,
      );
      debugPrint(
          "MatchSelectionViewNotifier: error while searching team -> $e");
    }
  }

  void onSearchChanged() {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (state.searchController.text.isNotEmpty) {
        _search(state.searchController.text.trim());
      } else {
        state = state.copyWith(searchResults: {});
      }
    });
  }

  void addGroup(MatchGroup group) {
    final matches = GroupedMatchMap.of(state.matches);
    final groupEntry = Map<int, List<MatchModel>>.of(matches[group] ?? {});
    final nextRound = groupEntry.isEmpty ? 1 : groupEntry.keys.last + 1;

    groupEntry[nextRound] = [];
    matches[group] = groupEntry;
    final sorted = SplayTreeMap<MatchGroup, Map<int, List<MatchModel>>>.from(
        matches, (a, b) => a.index.compareTo(b.index));

    state = state.copyWith(matches: sorted);
  }

  GroupedMatchMap filterMatches(GroupedMatchMap matches, String searchedWord) {
    String normalizedWord = searchedWord.caseAndSpaceInsensitive;

    GroupedMatchMap filteredMatches = {};

    for (var matchGroupEntry in matches.entries) {
      MatchGroup matchGroup = matchGroupEntry.key;
      Map<int, List<MatchModel>> innerMap = matchGroupEntry.value;

      Map<int, List<MatchModel>> filteredInnerMap = {};

      for (var innerEntry in innerMap.entries) {
        int key = innerEntry.key;
        List<MatchModel> matchList = innerEntry.value;

        List<MatchModel> filteredList = matchList.where((match) {
          return match.teams.first.team.name_lowercase
                  .contains(normalizedWord) ||
              match.teams.last.team.name_lowercase.contains(normalizedWord);
        }).toList();

        if (filteredList.isNotEmpty) {
          filteredInnerMap[key] = filteredList;
        }
      }

      if (filteredInnerMap.isNotEmpty) {
        filteredMatches[matchGroup] = filteredInnerMap;
      }
    }

    return filteredMatches;
  }

  List<MatchGroup> getMatchGroupOption() {
    final options = MatchGroup.values.toList();
    final tournamentType = state.tournament?.type;
    if (state.matches.containsKey(MatchGroup.round)) {
      if (tournamentType == TournamentType.miniRobin ||
          (tournamentType == TournamentType.doubleOut &&
              (state.matches[MatchGroup.round]?.entries.length ?? 0) > 1)) {
        options.remove(MatchGroup.round);
      }
    }

    void handleDoubleOutValidation(MatchGroup group) {
      if (tournamentType == TournamentType.doubleOut ||
          state.matches.containsKey(group)) {
        if (tournamentType == TournamentType.doubleOut ||
            tournamentType == TournamentType.miniRobin ||
            tournamentType == TournamentType.boxLeague ||
            tournamentType == TournamentType.custom ||
            tournamentType == TournamentType.knockOut) {
          options.remove(group);
        }
      }
    }

    handleDoubleOutValidation(MatchGroup.quarterfinal);
    handleDoubleOutValidation(MatchGroup.semifinal);

    if (state.matches.containsKey(MatchGroup.finals)) {
      options.remove(MatchGroup.finals);
    }

    return options;
  }

  @override
  void dispose() {
    _tournamentSubscription?.cancel();
    _matchSubscription?.cancel();
    state.searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}

@freezed
class MatchSelectionState with _$MatchSelectionState {
  const factory MatchSelectionState({
    required TextEditingController searchController,
    Object? error,
    Object? actionError,
    TournamentModel? tournament,
    @Default({}) GroupedMatchMap searchResults,
    @Default({}) GroupedMatchMap matches,
    @Default(false) bool loading,
    @Default(false) bool searchInProgress,
  }) = _MatchSelectionState;
}
