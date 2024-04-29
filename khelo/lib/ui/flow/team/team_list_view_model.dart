import 'package:data/api/team/team_model.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_list_view_model.freezed.dart';

final teamListViewStateProvider =
    StateNotifierProvider.autoDispose<TeamListViewNotifier, TeamListViewState>(
        (ref) {
  final notifier = TeamListViewNotifier(
    ref.read(teamServiceProvider),
    ref.read(currentUserPod)?.id,
  );
  ref.listen(currentUserPod, (previous, next) {
    notifier.setUserId(next?.id);
  });
  return notifier;
});

class TeamListViewNotifier extends StateNotifier<TeamListViewState> {
  final TeamService _teamService;

  TeamListViewNotifier(this._teamService, String? userId)
      : super(TeamListViewState(currentUserId: userId)) {
    loadTeamList();
  }

  void setUserId(String? userId) {
    state = state.copyWith(currentUserId: userId);
  }

  Future<void> loadTeamList() async {
    state = state.copyWith(loading: state.teams.isEmpty);
    try {
      final res =
          await _teamService.getUserRelatedTeams(option: state.selectedFilter);
      state = state.copyWith(teams: res, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint("TeamListViewNotifier: error while loading team list -> $e");
    }
  }

  void onFilterOptionSelect(TeamFilterOption filter) {
    if (filter != state.selectedFilter) {
      state = state.copyWith(selectedFilter: filter);
      loadTeamList();
    }
  }

  void onFilterButtonTap() {
    state = state.copyWith(showFilterOptionSheet: DateTime.now());
  }
}

@freezed
class TeamListViewState with _$TeamListViewState {
  const factory TeamListViewState({
    Object? error,
    DateTime? showFilterOptionSheet,
    String? currentUserId,
    @Default([]) List<TeamModel> teams,
    @Default(true) bool loading,
    @Default(TeamFilterOption.all) TeamFilterOption selectedFilter,
  }) = _TeamListViewState;
}
