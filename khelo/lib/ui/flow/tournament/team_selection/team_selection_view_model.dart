import 'dart:async';

import 'package:data/api/team/team_model.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_selection_view_model.freezed.dart';

final teamSelectionViewStateProvider = StateNotifierProvider.autoDispose<
    TeamSelectionViewNotifier, TeamSelectionViewState>(
  (ref) {
    final notifier = TeamSelectionViewNotifier(
      ref.read(teamServiceProvider),
      ref.read(currentUserPod)?.id,
    );
    ref.listen(currentUserPod, (previous, next) {
      notifier._setUserId(next?.id);
    });
    return notifier;
  },
);

class TeamSelectionViewNotifier extends StateNotifier<TeamSelectionViewState> {
  final TeamService _teamService;
  StreamSubscription? _streamSubscription;
  String? _currentUserId;
  Timer? _debounce;

  List<String> selectedIds = [];

  TeamSelectionViewNotifier(this._teamService, this._currentUserId)
      : super(
            TeamSelectionViewState(searchController: TextEditingController())) {
    _loadTeamList();
  }

  void _setUserId(String? userId) {
    if (userId == null) {
      _streamSubscription?.cancel();
    }
    _currentUserId = userId;
    _loadTeamList();
  }

  void setData(List<TeamModel>? teams) {
    state = state.copyWith(selectedTeams: teams ?? []);
    selectedIds = teams?.map((e) => e.id).toList() ?? [];
  }

  Future<void> _loadTeamList() async {
    if (_currentUserId == null) return;
    _streamSubscription?.cancel();
    state = state.copyWith(loading: true);
    _streamSubscription =
        _teamService.streamUserOwnedTeams(_currentUserId!).listen((teams) {
      state = state.copyWith(userTeams: teams, loading: false, error: null);
    }, onError: (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint(
          "TeamSelectionViewNotifier: error while loading team list -> $e");
    });
  }

  Future<void> _search(String searchKey) async {
    state = state.copyWith(searchInProgress: true);

    try {
      final teams = await _teamService.searchTeam(searchKey);
      final selectedTeam = state.selectedTeams.map((e) => e.id);
      final filteredTeam =
          teams.where((e) => !selectedTeam.contains(e.id)).toList();

      state = state.copyWith(
        searchResults: filteredTeam,
        error: null,
        searchInProgress: false,
      );
    } catch (e) {
      state = state.copyWith(
        searchInProgress: false,
        error: e,
      );
      debugPrint("TeamSelectionViewNotifier: error while searching team -> $e");
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
        state = state.copyWith(searchResults: []);
      }
    });
  }

  void onTeamCellTap(TeamModel team) {
    state = state.copyWith(showSelectionError: false);

    final isAlreadySelected =
        state.selectedTeams.map((e) => e.id).contains(team.id);

    final teams = state.selectedTeams.toList();
    if (isAlreadySelected) {
      teams.removeWhere((e) => e.id == team.id);
    } else {
      final playersCount =
          team.players.where((player) => player.user.isActive).length;

      if (playersCount >= 2) {
        teams.add(team);
      } else {
        state = state.copyWith(showSelectionError: true);
      }
    }
    state = state.copyWith(selectedTeams: teams);
  }

  List<TeamModel> getSelectedTeamOfOtherUser() {
    final userTeams = state.userTeams.map((e) => e.id);
    final searchedTeam = state.searchResults.map((e) => e.id);
    return state.selectedTeams
        .where((e) => !userTeams.contains(e.id) && !searchedTeam.contains(e.id))
        .toList();
  }

  @override
  void dispose() {
    state.searchController.dispose();
    _debounce?.cancel();
    _streamSubscription?.cancel();
    super.dispose();
  }
}

@freezed
class TeamSelectionViewState with _$TeamSelectionViewState {
  const factory TeamSelectionViewState({
    required TextEditingController searchController,
    Object? error,
    @Default([]) List<TeamModel> selectedTeams,
    @Default([]) List<TeamModel> searchResults,
    @Default([]) List<TeamModel> userTeams,
    @Default(false) bool loading,
    @Default(false) bool showSelectionError,
    @Default(false) bool searchInProgress,
  }) = _TeamSelectionViewState;
}
