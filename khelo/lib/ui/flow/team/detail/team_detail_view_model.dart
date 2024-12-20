import 'dart:async';

import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:data/utils/combine_latest.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_detail_view_model.freezed.dart';

final teamDetailStateProvider =
    StateNotifierProvider.autoDispose<TeamDetailViewNotifier, TeamDetailState>(
        (ref) => TeamDetailViewNotifier(
              ref.read(teamServiceProvider),
              ref.read(matchServiceProvider),
              ref.read(currentUserPod)?.id,
            ));

class TeamDetailViewNotifier extends StateNotifier<TeamDetailState> {
  StreamSubscription? _teamStreamSubscription;
  final TeamService _teamService;
  final MatchService _matchService;
  String? _teamId;

  TeamDetailViewNotifier(this._teamService, this._matchService, String? userId)
      : super(TeamDetailState(currentUserId: userId));

  void setData(String teamId) {
    _teamId = teamId;
    loadData();
  }

  void loadData() {
    if (_teamId == null) return;
    if (state.loading) return;
    _teamStreamSubscription?.cancel();
    state =
        state.copyWith(loading: state.team == null || state.matches.isEmpty);
    final teamCombiner = combineLatest2(
      _teamService.streamTeamById(_teamId!),
      _matchService.streamMatchesByTeamId(
        teamId: _teamId!,
        limit: state.matches.length + 10,
      ),
    );
    _teamStreamSubscription = teamCombiner.listen((data) {
      state = state.copyWith(
        team: data.$1,
        matches: data.$2,
        loading: false,
      );
    }, onError: (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint(
          "TeamDetailViewNotifier: error while loading team and matches by id -> $e");
    });
  }

  void onTabChange(int tab) {
    if (state.selectedTab != tab) {
      state = state.copyWith(selectedTab: tab);
    }
  }

  @override
  void dispose() {
    _teamStreamSubscription?.cancel();
    super.dispose();
  }
}

@freezed
class TeamDetailState with _$TeamDetailState {
  const factory TeamDetailState({
    Object? error,
    TeamModel? team,
    String? currentUserId,
    @Default([]) List<MatchModel> matches,
    @Default(0) int selectedTab,
    @Default(false) bool loading,
  }) = _TeamDetailState;
}
