import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/team/team_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_detail_view_model.freezed.dart';

final teamDetailStateProvider =
    StateNotifierProvider.autoDispose<TeamDetailViewNotifier, TeamDetailState>(
        (ref) => TeamDetailViewNotifier(
              ref.read(teamServiceProvider),
              ref.read(matchServiceProvider),
            ));

class TeamDetailViewNotifier extends StateNotifier<TeamDetailState> {
  final TeamService _teamService;
  final MatchService _matchService;
  String? teamId;

  TeamDetailViewNotifier(this._teamService, this._matchService)
      : super(const TeamDetailState());

  void setData(String teamId) {
    this.teamId = teamId;
    loadTeamById();
  }

  Future<void> loadTeamById() async {
    if (teamId == null) {
      return;
    }

    try {
      state = state.copyWith(loading: true);

      final team = await _teamService.getTeamById(teamId!);
      state = state.copyWith(team: team, loading: false);
      loadTeamMatches();
    } catch (e) {
      state = state.copyWith(loading: false);
      debugPrint(
          "TeamDetailViewNotifier: error while loading team by id -> $e");
    }
  }

  Future<void> loadTeamMatches() async {
    if (state.team == null) {
      return;
    }
    try {
      final matches = await _matchService
          .getMatchesByTeamIdV1(state.team!.id ?? "INVALID ID");
      state = state.copyWith(matches: matches);
    } catch (e) {
      debugPrint(
          "TeamDetailViewNotifier: error while loading team matches -> $e");
    }
  }

  void onTabChange(int tab) {
    if (state.selectedTab != tab) {
      state = state.copyWith(selectedTab: tab);
    }
  }
}

@freezed
class TeamDetailState with _$TeamDetailState {
  const factory TeamDetailState({
    Object? error,
    TeamModel? team,
    List<MatchModel>? matches,
    @Default(0) int selectedTab,
    @Default(false) bool loading,
  }) = _TeamDetailState;
}
