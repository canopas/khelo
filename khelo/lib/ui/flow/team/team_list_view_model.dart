import 'dart:async';
import 'package:data/api/team/team_model.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

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
  late StreamSubscription _teamsStreamSubscription;

  TeamListViewNotifier(this._teamService, String? userId)
      : super(TeamListViewState(currentUserId: userId));

  void setUserId(String? userId) {
    state = state.copyWith(currentUserId: userId);
  }

  Future<void> loadTeamList() async {
    state = state.copyWith(loading: state.teams.isEmpty);
    try {
      _teamsStreamSubscription =
          _teamService.getUserRelatedTeams().listen((teams) {
        state = state.copyWith(teams: teams, loading: false);
        _filterTeamList();
      }, onError: (e) {
        state = state.copyWith(loading: false); // TODO: handle error with merge
        debugPrint("TeamListViewNotifier: error while loading team list -> $e");
      });
    } catch (e) {
      state = state.copyWith(loading: false); // TODO: handle error with merge
      debugPrint("TeamListViewNotifier: error while loading team list -> $e");
    }
  }

  void _filterTeamList() {
    List<TeamModel> list = [];
    switch (state.selectedFilter) {
      case TeamFilterOption.createdByMe:
        list = state.teams
            .where((element) => element.created_by == state.currentUserId)
            .toList();
      case TeamFilterOption.memberMe:
        list = state.teams
            .where((element) =>
                element.created_by == state.currentUserId ||
                (element.players
                        ?.map((e) => e.id)
                        .contains(state.currentUserId) ??
                    false))
            .toList();
      default:
        list = state.teams;
    }

    state = state.copyWith(filteredTeams: list);
  }

  void onFilterOptionSelect(TeamFilterOption filter) {
    if (filter != state.selectedFilter) {
      state = state.copyWith(selectedFilter: filter);
      _filterTeamList();
    }
  }

  void onFilterButtonTap() {
    state = state.copyWith(showFilterOptionSheet: DateTime.now());
  }

  _cancelStreamSubscription() {
    _teamsStreamSubscription.cancel();
  }

  @override
  void dispose() {
    _cancelStreamSubscription();
    super.dispose();
  }
}

@freezed
class TeamListViewState with _$TeamListViewState {
  const factory TeamListViewState({
    Object? error,
    DateTime? showFilterOptionSheet,
    String? currentUserId,
    @Default([]) List<TeamModel> teams,
    @Default([]) List<TeamModel> filteredTeams,
    @Default(true) bool loading,
    @Default(TeamFilterOption.all) TeamFilterOption selectedFilter,
  }) = _TeamListViewState;
}

enum TeamFilterOption {
  all,
  createdByMe,
  memberMe;

  String getString(BuildContext context) {
    switch (this) {
      case TeamFilterOption.all:
        return context.l10n.team_list_all_teams_title;
      case TeamFilterOption.createdByMe:
        return context.l10n.team_list_created_by_me_title;
      case TeamFilterOption.memberMe:
        return context.l10n.team_list_me_as_member_title;
    }
  }
}
