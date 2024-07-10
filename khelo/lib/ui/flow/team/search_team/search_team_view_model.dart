import 'dart:async';
import 'package:data/api/team/team_model.dart';
import 'package:data/extensions/string_extensions.dart';
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
  late StreamSubscription _streamSubscription;
  final TeamService _teamService;
  Timer? _debounce;
  List<String> excludedIds = [];
  bool onlyUserTeams = false;

  SearchTeamViewNotifier(this._teamService)
      : super(SearchTeamState(searchController: TextEditingController())) {
    loadTeamList();
  }

  void setData(List<String>? ids, bool userTeams) {
    excludedIds = ids ?? [];
    onlyUserTeams = userTeams;
  }

  Future<void> loadTeamList() async {
    state = state.copyWith(loading: true);

    _streamSubscription = _teamService.getUserOwnedTeams().listen((teams) {
      final filteredResult =
          teams.where((element) => !excludedIds.contains(element.id)).toList();

      state = state.copyWith(
          userTeams: filteredResult, loading: false, error: null);
    }, onError: (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint("SearchTeamViewNotifier: error while loading team list -> $e");
    });
  }

  Future<void> search(String searchKey) async {
    state = state.copyWith(searchInProgress: true);

    try {
      List<TeamModel> filteredResult;
      if (onlyUserTeams) {
        filteredResult = state.userTeams
            .where((team) => team.name.caseAndSpaceInsensitive
                .startsWith(searchKey.caseAndSpaceInsensitive))
            .toList();
      } else {
        final teams = await _teamService.searchTeam(searchKey);
        filteredResult =
            teams.where((team) => !excludedIds.contains(team.id)).toList();
      }

      state = state.copyWith(
        searchResults: filteredResult,
        error: null,
        searchInProgress: false,
      );
    } catch (e) {
      state = state.copyWith(
        searchInProgress: false,
        error: e,
      );
      debugPrint("SearchTeamViewNotifier: error while searching team -> $e");
    }
  }

  void onSearchChanged() {
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
    state = state.copyWith(showSelectionError: false);
    final playersCount =
        (team.players?.where((player) => player.isActive).toList() ?? [])
            .length;
    if (playersCount >= 2) {
      final isAlreadySelected = state.selectedTeam?.id == team.id;
      state = state.copyWith(selectedTeam: isAlreadySelected ? null : team);
    } else {
      state = state.copyWith(showSelectionError: true);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _streamSubscription.cancel();
    super.dispose();
  }
}

@freezed
class SearchTeamState with _$SearchTeamState {
  const factory SearchTeamState({
    required TextEditingController searchController,
    Object? error,
    TeamModel? selectedTeam,
    @Default([]) List<TeamModel> searchResults,
    @Default([]) List<TeamModel> userTeams,
    @Default(false) bool loading,
    @Default(false) bool showSelectionError,
    @Default(false) bool searchInProgress,
  }) = _SearchTeamState;
}
