import 'dart:async';

import 'package:collection/collection.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/ui/flow/tournament/match_selection/match_scheduler.dart';

part 'match_selection_view_model.freezed.dart';

final matchSelectionStateProvider =
    StateNotifierProvider<MatchSelectionViewNotifier, MatchSelectionState>(
        (ref) => MatchSelectionViewNotifier());

class MatchSelectionViewNotifier extends StateNotifier<MatchSelectionState> {
  Timer? _debounce;
  late MatchScheduler scheduler;

  MatchSelectionViewNotifier()
      : super(MatchSelectionState(searchController: TextEditingController()));

  void setData(
      String tournamentId, List<TeamModel> teams, List<MatchModel> matches) {
    scheduler = MatchScheduler(teams, {0: matches});

    final scheduledMatches = scheduler.scheduleKnockOutMatchV2();

    final list = scheduledMatches.entries
        .map((e) => e.value)
        .expand((element) => element);

    // Group by `MatchGroup` and `match_group_number` using MapEntry as key
    final groupedMatches = groupByTwoFields<MatchModel, MatchGroup, int>(
      list.toList(),
      primaryGroupByKey: (match) => match.match_group ?? MatchGroup.round,
      secondaryGroupByKey: (match) => match.match_group_number ?? 1,
    );

    state = state.copyWith(matches: groupedMatches, tournamentId: tournamentId);
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

  @override
  void dispose() {
    state.searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void addGroup(MatchGroup group) {
    // Get the current matches and create a mutable copy with the specified type
    final matches =
        Map<MatchGroup, Map<int, List<MatchModel>>>.of(state.matches);

    // Get the group entry or initialize an empty map if it doesn't exist
    final groupEntry = Map<int, List<MatchModel>>.of(matches[group] ?? {});

    // Determine the next round number
    final nextRound = groupEntry.isEmpty ? 1 : groupEntry.keys.last + 1;

    // Add the new round with an empty list
    groupEntry[nextRound] = [];

    // Update matches with the modified group entry
    matches[group] = groupEntry;

    // Update the state with the new matches map
    state = state.copyWith(matches: matches);
  }

  Map<MatchGroup, Map<int, List<MatchModel>>> filterMatches(
      Map<MatchGroup, Map<int, List<MatchModel>>> matches,
      String searchedWord) {
    // Normalize the searched word to lower case for case-insensitive search
    String normalizedWord = searchedWord.caseAndSpaceInsensitive;

    Map<MatchGroup, Map<int, List<MatchModel>>> filteredMatches = {};

    for (var matchGroupEntry in matches.entries) {
      MatchGroup matchGroup = matchGroupEntry.key;
      Map<int, List<MatchModel>> innerMap = matchGroupEntry.value;

      Map<int, List<MatchModel>> filteredInnerMap = {};

      for (var innerEntry in innerMap.entries) {
        int key = innerEntry.key;
        List<MatchModel> matchList = innerEntry.value;

        // Filter the matchList to only include matches where either team matches the searched word
        List<MatchModel> filteredList = matchList.where((match) {
          return match.teams.first.team.name_lowercase
                  .contains(normalizedWord) ||
              match.teams.last.team.name_lowercase.contains(normalizedWord);
        }).toList();

        // Only add to filteredInnerMap if there are matching teams
        if (filteredList.isNotEmpty) {
          filteredInnerMap[key] = filteredList;
        }
      }

      // Only add to filteredMatches if there's at least one filtered match group
      if (filteredInnerMap.isNotEmpty) {
        filteredMatches[matchGroup] = filteredInnerMap;
      }
    }

    return filteredMatches;
  }
}

Map<MapEntry<K1, K2>, List<T>> groupByTwoFieldsSingleLevel<T, K1, K2>(
  List<T> items, {
  required K1 Function(T item) primaryGroupByKey,
  required K2 Function(T item) secondaryGroupByKey,
}) {
  final result = <MapEntry<K1, K2>, List<T>>{};

  for (var item in items) {
    // Create a MapEntry to serve as a two-field key
    final key = MapEntry(primaryGroupByKey(item), secondaryGroupByKey(item));

    // Add the item to the correct list based on the key
    result.putIfAbsent(key, () => []).add(item);
  }

  return result;
}

/// Generic function to group a list by two fields.
Map<K1, Map<K2, List<T>>> groupByTwoFields<T, K1, K2>(
  List<T> items, {
  required K1 Function(T item) primaryGroupByKey,
  required K2 Function(T item) secondaryGroupByKey,
}) {
  // Group items by the primary key
  final primaryGroupedItems = groupBy(items, primaryGroupByKey);

  // For each primary group, further group by the secondary key
  final result = <K1, Map<K2, List<T>>>{};
  primaryGroupedItems.forEach((primaryKey, primaryGroup) {
    result[primaryKey] = groupBy(primaryGroup, secondaryGroupByKey);
  });

  return result;
}

@freezed
class MatchSelectionState with _$MatchSelectionState {
  const factory MatchSelectionState({
    required TextEditingController searchController,
    Object? error,
    String? tournamentId,
    @Default({
      MatchGroup.round: {0: []}
    })
    Map<MatchGroup, Map<int, List<MatchModel>>> searchResults,
    @Default({
      MatchGroup.round: {0: []}
    })
    Map<MatchGroup, Map<int, List<MatchModel>>> matches,
    @Default(false) bool loading,
    @Default(false) bool searchInProgress,
  }) = _MatchSelectionState;
}
