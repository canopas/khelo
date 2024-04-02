import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/service/match/match_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/add_match_officials_view_model.dart';

part 'add_match_view_model.freezed.dart';

final addMatchViewStateProvider =
    StateNotifierProvider.autoDispose<AddMatchViewNotifier, AddMatchViewState>(
        (ref) {
  return AddMatchViewNotifier(ref.read(matchServiceProvider));
});

class AddMatchViewNotifier extends StateNotifier<AddMatchViewState> {
  final MatchService _matchService;
  String? matchId;

  AddMatchViewNotifier(this._matchService)
      : super(AddMatchViewState(
          totalOverController: TextEditingController(),
          overPerBowlerController: TextEditingController(),
          cityController: TextEditingController(),
          groundController: TextEditingController(),
          matchTime: DateTime.now(),
        ));

  void setData(String? matchId) {
    this.matchId = matchId;
    if (matchId != null) {
      getMatchById();
    }
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

      state.totalOverController.text = match.number_of_over.toString();
      state.overPerBowlerController.text = match.over_per_bowler.toString();
      state.cityController.text = match.city.toString();
      state.groundController.text = match.ground.toString();
      state = state.copyWith(
          match: match,
          matchTime: match.start_time,
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
          isStartBtnEnable: true,
          loading: false);
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint("AddMatchViewNotifier: error while get Match By id -> $e");
    }
  }

  Future<void> addMatch({bool startMatch = false}) async {
    try {
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
          .where((element) => element.type == MatchOfficials.referee)
          .map((e) => e.user.id)
          .firstOrNull;

      final firstSquad = state.squadA
              ?.map((e) => MatchPlayerRequest(
                  id: e.player.id,
                  status: e.status ?? PlayerStatus.yetToPlay,
                  index: e.index))
              .toList() ??
          [];
      final secondSquad = state.squadB
              ?.map((e) => MatchPlayerRequest(
                  id: e.player.id,
                  status: e.status ?? PlayerStatus.yetToPlay,
                  index: e.index))
              .toList() ??
          [];

      final match = AddEditMatchRequest(
          id: matchId,
          teams: [
            AddMatchTeamRequest(
              team_id: state.teamA!.id!,
              squad: firstSquad,
              captain_id: state.teamACaptainId,
              admin_id: state.teamAAdminId,
            ),
            AddMatchTeamRequest(
              team_id: state.teamB!.id!,
              squad: secondSquad,
              captain_id: state.teamBCaptainId,
              admin_id: state.teamBAdminId,
            )
          ],
          match_type: state.matchType,
          number_of_over: int.parse(totalOvers),
          over_per_bowler: int.parse(overPerBowler),
          power_play_overs1: state.firstPowerPlay,
          power_play_overs2: state.secondPowerPlay,
          power_play_overs3: state.thirdPowerPlay,
          city: city,
          ground: ground,
          start_time: state.matchTime,
          ball_type: state.ballType,
          pitch_type: state.pitchType,
          umpire_ids: umpireIds,
          scorer_ids: scorerIds,
          commentator_ids: commentatorIds,
          toss_decision: state.match?.toss_decision,
          toss_winner_id: state.match?.toss_winner_id,
          referee_id: refereeId,
          current_playing_team_id: state.match?.current_playing_team_id,
          match_status: startMatch
              ? state.match?.match_status ?? MatchStatus.running
              : MatchStatus.yetToStart);

      matchId = await _matchService.updateMatch(match);

      state = state.copyWith(
          isAddMatchInProgress: false,
          pushTossDetailScreen:
              startMatch ? state.match?.toss_winner_id == null : null,
          pop: !startMatch);
    } catch (e) {
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
    switch (type) {
      case TeamType.a:
        state = state.copyWith(teamA: team);
      case TeamType.b:
        state = state.copyWith(teamB: team);
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

    final isBtnEnable = totalOvers.isNotEmpty &&
        overPerBowler.isNotEmpty &&
        city.isNotEmpty &&
        ground.isNotEmpty &&
        state.teamA != null &&
        state.teamB != null &&
        (state.squadA?.length ?? 0) >= 2 &&
        (state.squadB?.length ?? 0) >= 2;

    state = state.copyWith(
        isPowerPlayButtonEnable:
            totalOvers.isNotEmpty && (int.tryParse(totalOvers) ?? 0) > 0,
        isSaveBtnEnable: isBtnEnable,
        isStartBtnEnable: isBtnEnable);
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
    try {
      await _matchService.deleteMatch(matchId!);
      state = state.copyWith(pop: true);
    } catch (e) {
      debugPrint("AddMatchViewNotifier: error while delete Match -> $e");
    }
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
    MatchModel? match,
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
    @Default(false) bool isSaveBtnEnable,
    @Default(false) bool isStartBtnEnable,
    @Default(false) bool isAddMatchInProgress,
    @Default(null) bool? pushTossDetailScreen,
    @Default(null) bool? pop,
  }) = _AddMatchViewState;
}

enum TeamType {
  a,
  b;

  String getString(BuildContext context) {
    switch (this) {
      case TeamType.a:
        return context.l10n.add_match_team_a_title;
      case TeamType.b:
        return context.l10n.add_match_team_b_title;
    }
  }
}
