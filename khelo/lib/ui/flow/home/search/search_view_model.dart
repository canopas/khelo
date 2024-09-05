import 'package:data/api/match/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_view_model.freezed.dart';

final searchHomeViewProvider = StateNotifierProvider.autoDispose<
    SearchHomeViewNotifier,
    SearchHomeViewState>((ref) => SearchHomeViewNotifier());

class SearchHomeViewNotifier extends StateNotifier<SearchHomeViewState> {
  SearchHomeViewNotifier()
      : super(SearchHomeViewState(searchController: TextEditingController()));

  late List<MatchModel> _matches;

  void setData(List<MatchModel> matches) {
    _matches = matches;
  }

  void onChange() {
    final searchKey = state.searchController.text.trim();
    if (searchKey.isEmpty) {
      state = state.copyWith(searchedMatches: []);
      return;
    }

    final filteredMatches = _matches.where((match) {
      return match.teams.any((team) {
        return team.team.name.toLowerCase().contains(searchKey);
      });
    }).toList();
    state = state.copyWith(searchedMatches: filteredMatches);
  }

  void onClear() {
    state.searchController.clear();
    state = state.copyWith(searchedMatches: []);
  }
}

@freezed
class SearchHomeViewState with _$SearchHomeViewState {
  const factory SearchHomeViewState({
    required TextEditingController searchController,
    @Default([]) List<MatchModel> searchedMatches,
  }) = _SearchHomeViewState;
}
