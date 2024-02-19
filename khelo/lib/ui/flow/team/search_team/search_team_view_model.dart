import 'dart:async';
import 'package:data/api/team/team_model.dart';
import 'package:data/service/team/team_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_team_view_model.freezed.dart';

final searchTeamViewStateProvider =
    StateNotifierProvider.autoDispose<SearchTeamViewNotifier, SearchTeamState>(
        (ref) {
  return SearchTeamViewNotifier(ref.read(teamServiceProvider));
});

class SearchTeamViewNotifier extends StateNotifier<SearchTeamState> {
  final TeamService _teamService;
  Timer? _debounce;
  List<String> excludedIds = [];

  SearchTeamViewNotifier(this._teamService)
      : super(SearchTeamState(searchController: TextEditingController())) {
    loadTeamList();
  }

  void setData(List<String>? ids) {
    excludedIds = ids ?? [];
  }

  Future<void> loadTeamList() async {
    state = state.copyWith(loading: true);
    try {
      final res = await _teamService.getTeams();

      final filteredResult =
          res.where((element) => !excludedIds.contains(element.id)).toList();

      state = state.copyWith(userTeams: filteredResult, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false);
      debugPrint("SearchTeamViewNotifier: error while loading team list");
    }
  }

  Future<void> search(String searchKey) async {
    final teams = await _teamService.searchTeam(searchKey);
    final filteredResult =
        teams.where((element) => !excludedIds.contains(element.id)).toList();
    state = state.copyWith(searchResults: filteredResult);
  }

  void onSearchChanged(String value) {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (state.searchController.text.isNotEmpty) {
        search(state.searchController.text.trim());
      }
    });
  }

  void onTeamCellTap(TeamModel team) {
    state = state.copyWith(selectedTeam: team);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

@freezed
class SearchTeamState with _$SearchTeamState {
  const factory SearchTeamState({
    required TextEditingController searchController,
    @Default([]) List<TeamModel> searchResults,
    @Default([]) List<TeamModel> userTeams,
    TeamModel? selectedTeam,
    @Default(false) bool loading,
    Object? error,
  }) = _SearchTeamState;
}
