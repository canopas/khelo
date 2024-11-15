import 'package:collection/collection.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/tournament/tournament_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/add_match_officials_view_model.dart';

part 'add_match_view_model.freezed.dart';

final addMatchViewStateProvider =
    StateNotifierProvider.autoDispose<AddMatchViewNotifier, AddMatchViewState>(
        (ref) {
  final notifier = AddMatchViewNotifier(
    ref.read(matchServiceProvider),
    ref.read(tournamentServiceProvider),
    ref.read(currentUserPod)?.id,
  );
  ref.listen(currentUserPod, (previous, next) {
    notifier._setUserId(next?.id);
  });
  return notifier;
});

class AddMatchViewNotifier extends StateNotifier<AddMatchViewState> {
  final MatchService _matchService;
  final TournamentService _tournamentService;
  String? matchId;
  MatchModel? editMatch;
  String? tournamentId;
  bool? isForTournament;
  MatchGroup? group;
  int? groupNumber;
  String? _currentUserId;

  AddMatchViewNotifier(
      this._matchService, this._tournamentService, this._currentUserId)
      : super(AddMatchViewState(
          totalOverController: TextEditingController(text: "10"),
          overPerBowlerController: TextEditingController(text: "2"),
          cityController: TextEditingController(),
          groundController: TextEditingController(),
          matchTime: DateTime.now(),
        ));

  void setData(
    String? matchId,
    TeamModel? defaultTeam,
    TeamModel? defaultOpponent,
    String? tournamentId,
    MatchGroup? group,
    int? groupNumber,
  ) {
    this.matchId = matchId;
    this.tournamentId = tournamentId;
    this.groupNumber = groupNumber;
    this.group = group;

    if (matchId != null) {
      getMatchById();
    } else if (defaultTeam != null) {
      onTeamSelect(defaultTeam, TeamType.a);
      if (defaultOpponent != null) {
        onTeamSelect(defaultOpponent, TeamType.b);
      }
    } else {
      onTextChange();
    }
  }

  void _setUserId(String? userId) {
    _currentUserId = userId;
  }

  Future<void> getMatchById() async {
    if (matchId == null) {
      return;
    }

    state = state.copyWith(loading: true);
    try {
      final match = await _matchService.getMatchById(matchId!);
      final umpire = match.umpires
              ?.map((e) => Officials(MatchOfficials.umpires, e))
              .toList() ??
          [];
      final scorer = match.scorers
              ?.map((e) => Officials(MatchOfficials.scorers, e))
              .toList() ??
          [];
      final commentator = match.commentators
              ?.map((e) => Officials(MatchOfficials.commentator, e))
              .toList() ??
          [];
      final referee = match.referee != null
          ? Officials(MatchOfficials.referee, match.referee!)
          : null;

      editMatch = match;
      tournamentId = match.tournament_id;
      group = match.match_group;
      groupNumber = match.match_group_number;

      state.totalOverController.text = match.number_of_over.toString();
      state.overPerBowlerController.text = match.over_per_bowler.toString();
      state.cityController.text = match.city.toString();
      state.groundController.text = match.ground.toString();
      state = state.copyWith(
          matchTime: match.start_at ?? match.start_time ?? DateTime.now(),
          teamA: match.teams.first.team,
          teamACaptainId: match.teams.first.captain_id,
          teamAAdminId: match.teams.first.admin_id,
          squadA: match.teams.first.squad,
          teamB: match.teams.last.team,
          teamBCaptainId: match.teams.last.captain_id,
          teamBAdminId: match.teams.last.admin_id,
          squadB: match.teams.last.squad,
          firstPowerPlay: match.power_play_overs1,
          secondPowerPlay: match.power_play_overs2,
          thirdPowerPlay: match.power_play_overs3,
          isPowerPlayButtonEnable: match.number_of_over > 0,
          pitchType: match.pitch_type,
          matchType: match.match_type,
          ballType: match.ball_type,
          officials: referee != null
              ? [...umpire, ...commentator, ...scorer, referee]
              : [
                  ...umpire,
                  ...commentator,
                  ...scorer,
                ],
          loading: false);
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint("AddMatchViewNotifier: error while get Match By id -> $e");
    }
  }

  Future<void> addMatch({bool startMatch = false}) async {
    try {
      state = state.copyWith(actionError: null);

      final totalOvers = state.totalOverController.text.trim();
      final overPerBowler = state.overPerBowlerController.text.trim();
      final city = state.cityController.text.trim();
      final ground = state.groundController.text.trim();

      final umpireIds = state.officials
          .where((element) => element.type == MatchOfficials.umpires)
          .map((e) => e.user.id)
          .toList();
      final scorerIds = state.officials
          .where((element) => element.type == MatchOfficials.scorers)
          .map((e) => e.user.id)
          .toList();
      final commentatorIds = state.officials
          .where((element) => element.type == MatchOfficials.commentator)
          .map((e) => e.user.id)
          .toList();
      final refereeId = state.officials
          .firstWhereOrNull((element) => element.type == MatchOfficials.referee)
          ?.user
          .id;

      final firstSquad = state.squadA
              ?.map((e) => MatchPlayer(
                    id: e.player.id,
                    performance: e.performance,
                  ))
              .toList() ??
          [];
      final secondSquad = state.squadB
              ?.map((e) => MatchPlayer(
                    id: e.player.id,
                    performance: e.performance,
                  ))
              .toList() ??
          [];
      final allPlayers = firstSquad.map((e) => e.id).toList();
      allPlayers.addAll(secondSquad.map((e) => e.id).toList());

      final match = MatchModel(
          id: matchId ?? _matchService.generateMatchId,
          players: allPlayers.toSet().toList(),
          team_ids: [state.teamA!.id, state.teamB!.id],
          team_creator_ids:
              {state.teamA!.created_by!, state.teamB!.created_by!}.toList(),
          teams: [
            MatchTeamModel(
              team_id: state.teamA!.id,
              squad: firstSquad,
              captain_id: state.teamACaptainId,
              admin_id: state.teamAAdminId,
            ),
            MatchTeamModel(
              team_id: state.teamB!.id,
              squad: secondSquad,
              captain_id: state.teamBCaptainId,
              admin_id: state.teamBAdminId,
            )
          ],
          match_type: state.matchType,
          number_of_over: int.parse(totalOvers),
          over_per_bowler: int.parse(overPerBowler),
          power_play_overs1: state.firstPowerPlay ?? [],
          power_play_overs2: state.secondPowerPlay ?? [],
          power_play_overs3: state.thirdPowerPlay ?? [],
          city: city,
          ground: ground,
          match_group_number: groupNumber,
          match_group: group,
          tournament_id: tournamentId,
          start_time: state.matchTime,
          start_at: state.matchTime,
          updated_at: DateTime.now(),
          created_by: _currentUserId ?? state.teamA?.created_by ?? "INVALID ID",
          ball_type: state.ballType,
          pitch_type: state.pitchType,
          umpire_ids: umpireIds,
          scorer_ids: scorerIds,
          commentator_ids: commentatorIds,
          toss_decision: editMatch?.toss_decision,
          toss_winner_id: editMatch?.toss_winner_id,
          referee_id: refereeId,
          current_playing_team_id: editMatch?.current_playing_team_id,
          match_status:
              startMatch ? MatchStatus.running : MatchStatus.yetToStart);

      matchId = await _matchService.updateMatch(match);

      if (tournamentId != null && editMatch == null && matchId != null) {
        await _tournamentService.addMatchInTournament(tournamentId!, matchId!);
      }

      state = state.copyWith(
          isAddMatchInProgress: false,
          pushTossDetailScreen:
              startMatch ? editMatch?.toss_winner_id == null : null,
          match: !startMatch ? match : null);
    } catch (e) {
      state = state.copyWith(actionError: e);
      debugPrint("AddMatchViewNotifier: error while adding match -> $e");
    }
  }

  void onDateSelect({required DateTime selectedDate}) {
    state = state.copyWith(matchTime: selectedDate);
    onTextChange();
  }

  void onPitchTypeSelection(PitchType type) {
    state = state.copyWith(pitchType: type);
    onTextChange();
  }

  void onMatchTypeSelection(MatchType type) {
    state = state.copyWith(matchType: type);
    onTextChange();
  }

  void onBallTypeSelection(BallType type) {
    state = state.copyWith(ballType: type);
    onTextChange();
  }

  void onTeamSelect(TeamModel team, TeamType type) {
    final matchPlayer = team.players
        .where((element) => element.user.isActive)
        .take(11)
        .map((e) => MatchPlayer(id: e.user.id, player: e.user))
        .toList();

    final captainAndAdminId = matchPlayer.firstOrNull?.player.id;
    switch (type) {
      case TeamType.a:
        state = state.copyWith(
            teamA: team,
            squadA: matchPlayer,
            teamACaptainId: captainAndAdminId,
            teamAAdminId: captainAndAdminId);
      case TeamType.b:
        state = state.copyWith(
            teamB: team,
            squadB: matchPlayer,
            teamBCaptainId: captainAndAdminId,
            teamBAdminId: captainAndAdminId);
    }
    onTextChange();
  }

  void onStepperActionTap({
    required bool isForTotalOverCount,
    required bool isAdd,
  }) {
    final countString = isForTotalOverCount
        ? state.totalOverController.text
        : state.overPerBowlerController.text;
    int overCount = int.tryParse(countString) ?? 0;

    if (isAdd && overCount < 999) {
      overCount++;
    } else if (!isAdd && overCount > 1) {
      overCount--;
    }
    if (isForTotalOverCount) {
      state.totalOverController.text = overCount.toString();
    } else {
      state.overPerBowlerController.text = overCount.toString();
    }
    onTextChange();
  }

  void setOfficials(List<Officials> officials) {
    state = state.copyWith(officials: officials);
    onTextChange();
  }

  void onSquadSelect(TeamType type, Map<String, dynamic> squadDetail) {
    if (type == TeamType.a) {
      state = state.copyWith(
          squadA: squadDetail['squad'],
          teamACaptainId: squadDetail['captain_id'],
          teamAAdminId: squadDetail['admin_id']);
    } else {
      state = state.copyWith(
          squadB: squadDetail['squad'],
          teamBCaptainId: squadDetail['captain_id'],
          teamBAdminId: squadDetail['admin_id']);
    }
    onTextChange();
  }

  void onTextChange() {
    final totalOvers = state.totalOverController.text.trim();
    final overPerBowler = state.overPerBowlerController.text.trim();
    final city = state.cityController.text.trim();
    final ground = state.groundController.text.trim();

    AddMatchErrorType? error;
    final overCount = int.tryParse(totalOvers);

    if (city.isEmpty || ground.isEmpty || overPerBowler.isEmpty) {
      error = AddMatchErrorType.emptyFields;
    } else if ((overCount ?? 0) < 1) {
      error = AddMatchErrorType.invalidOverCount;
    } else if (state.teamA == null || state.teamB == null) {
      error = AddMatchErrorType.unSelectedTeam;
    } else if ((state.squadA?.length ?? 0) < 2 ||
        (state.squadB?.length ?? 0) < 2) {
      error = AddMatchErrorType.invalidSquad;
    }

    state = state.copyWith(
        isPowerPlayButtonEnable:
            totalOvers.isNotEmpty && (int.tryParse(totalOvers) ?? 0) > 0,
        saveBtnError: error,
        startBtnError: error);
  }

  void onPowerPlayChange(List<List<int>> powerPlay) {
    state = state.copyWith(
        firstPowerPlay: powerPlay.elementAtOrNull(0),
        secondPowerPlay: powerPlay.elementAtOrNull(1),
        thirdPowerPlay: powerPlay.elementAtOrNull(2));

    onTextChange();
  }

  Future<void> deleteMatch() async {
    if (matchId == null) {
      return;
    }
    state = state.copyWith(actionError: null);
    try {
      await _matchService.deleteMatch(matchId!);
      if (tournamentId != null) {
        await _tournamentService.removeMatchFromTournament(
            tournamentId!, matchId!);
      }
      state = state.copyWith(match: editMatch);
    } catch (e) {
      state = state.copyWith(actionError: e);
      debugPrint("AddMatchViewNotifier: error while delete Match -> $e");
    }
  }

  @override
  void dispose() {
    state.totalOverController.dispose();
    state.overPerBowlerController.dispose();
    state.cityController.dispose();
    state.groundController.dispose();
    super.dispose();
  }
}

@freezed
class AddMatchViewState with _$AddMatchViewState {
  const factory AddMatchViewState({
    required DateTime matchTime,
    required TextEditingController totalOverController,
    required TextEditingController overPerBowlerController,
    required TextEditingController cityController,
    required TextEditingController groundController,
    Object? error,
    Object? actionError,
    TeamModel? teamA,
    TeamModel? teamB,
    List<MatchPlayer>? squadA,
    List<MatchPlayer>? squadB,
    String? teamACaptainId,
    String? teamBCaptainId,
    String? teamAAdminId,
    String? teamBAdminId,
    @Default([]) List<Officials> officials,
    @Default([]) List<int>? firstPowerPlay,
    @Default([]) List<int>? secondPowerPlay,
    @Default([]) List<int>? thirdPowerPlay,
    @Default(PitchType.rough) PitchType pitchType,
    @Default(MatchType.limitedOvers) MatchType matchType,
    @Default(BallType.leather) BallType ballType,
    @Default(false) bool loading,
    @Default(false) bool isPowerPlayButtonEnable,
    AddMatchErrorType? saveBtnError,
    AddMatchErrorType? startBtnError,
    @Default(false) bool isAddMatchInProgress,
    @Default(null) bool? pushTossDetailScreen,
    @Default(null) MatchModel? match,
  }) = _AddMatchViewState;
}

enum TeamType {
  a,
  b;

  String getString(BuildContext context) {
    switch (this) {
      case TeamType.a:
        return context.l10n.common_a_title;
      case TeamType.b:
        return context.l10n.add_match_team_b_title;
    }
  }
}

enum AddMatchErrorType {
  invalidOverCount,
  emptyFields,
  unSelectedTeam,
  invalidSquad;

  String getString(BuildContext context) {
    switch (this) {
      case AddMatchErrorType.invalidOverCount:
        return context.l10n.add_match_invalid_over_count_error;
      case AddMatchErrorType.emptyFields:
        return context.l10n.add_match_empty_fields_error;
      case AddMatchErrorType.unSelectedTeam:
        return context.l10n.add_match_unselected_team_error;
      case AddMatchErrorType.invalidSquad:
        return context.l10n.add_match_invalid_squad_error;
    }
  }
}
