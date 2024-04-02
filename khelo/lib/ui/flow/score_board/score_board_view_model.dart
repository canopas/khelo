import 'package:data/api/match/match_model.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/innings/inning_service.dart';
import 'package:data/service/ball_score/ball_score_service.dart';
import 'package:data/extensions/list_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

part 'score_board_view_model.freezed.dart';

final scoreBoardStateProvider = StateNotifierProvider.autoDispose<
    ScoreBoardViewNotifier, ScoreBoardViewState>((ref) {
  return ScoreBoardViewNotifier(
    ref.read(matchServiceProvider),
    ref.read(inningServiceProvider),
    ref.read(ballScoreServiceProvider),
  );
});

class ScoreBoardViewNotifier extends StateNotifier<ScoreBoardViewState> {
  final MatchService _matchService;
  final InningsService _inningService;
  final BallScoreService _ballScoreService;
  String? matchId;

  ScoreBoardViewNotifier(
    this._matchService,
    this._inningService,
    this._ballScoreService,
  ) : super(const ScoreBoardViewState());

  void setData(String matchId) {
    this.matchId = matchId;
    getMatchById();
  }

  Future<void> getMatchById() async {
    if (matchId == null) {
      return;
    }

    state = state.copyWith(loading: true);
    try {
      final match = await _matchService.getMatchById(matchId!);
      state = state.copyWith(match: match);

      getInningsForTheMatch();
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint("ScoreBoardViewNotifier: error while get Match By id -> $e");
    }
  }

  Future<void> getInningsForTheMatch() async {
    if (state.match == null) {
      return;
    }
    try {
      final innings = await _inningService.getInningsByMatchId(
          matchId: state.match!.id ?? "INVALID ID");

      if (innings.isEmpty) {
        await createInnings();
        return;
      }

      final inningFirst = innings
          .where((element) => element.innings_status == InningStatus.running)
          .firstOrNull;

      final inningSecond = innings
          .where((element) => element.innings_status != InningStatus.running)
          .firstOrNull;

      state =
          state.copyWith(currentInning: inningFirst, otherInning: inningSecond);

      getScoresList();
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "ScoreBoardViewNotifier: error while get innings for the match -> $e");
    }
  }

  Future<void> getScoresList() async {
    if (state.currentInning == null || state.otherInning == null) {
      return;
    }

    try {
      final currentScore = await _ballScoreService
          .getBallScoreListByInningId(state.currentInning!.id ?? "INVALID ID");

      final previousScore = state.otherInning == null
          ? null
          : await _ballScoreService.getBallScoreListByInningId(
              state.otherInning!.id ?? "INVALID ID");

      state = state.copyWith(
          currentScoresList: currentScore,
          previousScoresList: previousScore ?? [],
          loading: false);
      _configureScoringDetails();
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint("ScoreBoardViewNotifier: error while get scoresList -> $e");
    }
  }

  void _configureScoringDetails() {
    if (state.match == null ||
        state.currentInning == null ||
        state.otherInning == null) {
      return;
    }
    final battingTeamSquad = state.match!.teams
        .firstWhere(
            (element) => state.currentInning!.team_id == element.team.id)
        .squad;
    final currentPlayingBatsMan = battingTeamSquad
        .where((element) => element.status == PlayerStatus.playing)
        .toList();

    int lastPlayerIndex = battingTeamSquad.map((e) => e.index).reduce(
            (value, element) =>
                (value ?? 0) > (element ?? 0) ? value ?? 0 : element ?? 0) ??
        0;

    final lastBall = state.currentScoresList.lastOrNull;

    final bowlerId = lastBall?.ball_number != 6 ? lastBall?.bowler_id : null;
    final bowler = bowlerId != null
        ? state.match!.teams
            .firstWhere(
                (element) => state.otherInning?.team_id == element.team.id)
            .squad
            .where((element) => element.player.id == bowlerId)
            .firstOrNull
        : null;

    bool showSelectAllPlayerSheet =
        bowler == null && (currentPlayingBatsMan.isEmpty);
    int overCount = int.parse(
        (state.currentInning!.overs == 0 ? 1 : state.currentInning!.overs ?? 1)
            .toStringAsFixed(0));

    state = state.copyWith(
      batsMans: currentPlayingBatsMan,
      bowler: bowler,
      lastAssignedIndex: lastPlayerIndex,
      overCount: overCount,
      totalRuns: state.currentInning!.total_runs ?? 0,
      wicketCount: state.otherInning!.total_wickets ?? 0,
      showSelectPlayerSheet: showSelectAllPlayerSheet ? DateTime.now() : null,
      showSelectBowlerSheet: bowler == null &&
              !showSelectAllPlayerSheet &&
              currentPlayingBatsMan.length == 2
          ? DateTime.now()
          : null,
      showSelectBowlerAndBatsManSheet: bowler == null &&
              !showSelectAllPlayerSheet &&
              currentPlayingBatsMan.length == 1
          ? DateTime.now()
          : null,
      showSelectBatsManSheet: bowler != null &&
              currentPlayingBatsMan.length == 1 &&
              !showSelectAllPlayerSheet
          ? DateTime.now()
          : null,
      ballCount: lastBall?.ball_number ?? 0,
    );
  }

  Future<void> createInnings() async {
    if (state.match == null) {
      return;
    }

    try {
      final firstInning = InningModel(
        match_id: state.match!.id ?? "INVALID ID",
        team_id: state.match!.toss_winner_id ?? "INVALID ID",
        innings_status: state.match!.toss_decision == TossDecision.bat
            ? InningStatus.running
            : InningStatus.yetToStart,
        overs: 0,
        total_runs: 0,
        total_wickets: 0,
      );
      final secondInning = InningModel(
        match_id: state.match!.id ?? "INVALID ID",
        team_id: state.match!.teams
                .firstWhere(
                    (element) => element.team.id != state.match?.toss_winner_id)
                .team
                .id ??
            "INVALID ID",
        innings_status: state.match!.toss_decision == TossDecision.bat
            ? InningStatus.yetToStart
            : InningStatus.running,
        overs: 0,
        total_runs: 0,
        total_wickets: 0,
      );
      final firstId = await _inningService.updateInning(firstInning);
      final secondId = await _inningService.updateInning(secondInning);

      await _matchService.updateCurrentPlayingTeam(
          state.match!.id ?? "INVALID ID",
          state.match!.toss_decision == TossDecision.bat
              ? firstInning.team_id
              : secondInning.team_id);

      state = state.copyWith(
          currentInning: state.match!.toss_decision == TossDecision.bat
              ? firstInning.copyWith(id: firstId)
              : secondInning.copyWith(id: secondId),
          otherInning: state.match!.toss_decision == TossDecision.bat
              ? secondInning.copyWith(id: secondId)
              : firstInning.copyWith(id: firstId),
          match: state.match!.copyWith(
              current_playing_team_id:
                  state.match!.toss_decision == TossDecision.bat
                      ? firstInning.team_id
                      : secondInning.team_id),
          showSelectPlayerSheet: DateTime.now(),
          loading: false);
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint("ScoreBoardViewNotifier: error while create innings -> $e");
    }
  }

  void onScoreButtonTap(ScoreButton btn) {
    switch (btn) {
      case ScoreButton.zero:
        addBall(run: 0);
      case ScoreButton.one:
        addBall(run: 1, switchStrike: true);
      case ScoreButton.two:
        addBall(run: 2);
      case ScoreButton.three:
        addBall(run: 3, switchStrike: true);
      case ScoreButton.four:
        state = state.copyWith(showBoundaryDialogForFour: DateTime.now());
      case ScoreButton.six:
        state = state.copyWith(showBoundaryDialogForSix: DateTime.now());
      case ScoreButton.fiveOrSeven:
        state = state.copyWith(showAddExtraDialogForFiveSeven: DateTime.now());
      case ScoreButton.undo:
        final lastBall = state.currentScoresList.lastOrNull;
        if (lastBall?.over_number != state.overCount) {
          state = state.copyWith(invalidUndoToast: DateTime.now());
          return;
        } else {
          state =
              state.copyWith(showUndoBallConfirmationDialog: DateTime.now());
        }
      case ScoreButton.out:
        state = state.copyWith(showSelectWicketTypeSheet: DateTime.now());
      case ScoreButton.noBall:
        state = state.copyWith(showAddExtraDialogForNoBall: DateTime.now());
      case ScoreButton.wideBall:
        addBall(
          run: 0,
          extrasType: ExtrasType.wide,
          extra: 1,
        );
      case ScoreButton.bye:
        state = state.copyWith(showAddExtraDialogForBye: DateTime.now());
      case ScoreButton.legBye:
        state = state.copyWith(showAddExtraDialogForLegBye: DateTime.now());
    }
  }

  Future<void> addBall({
    required int run,
    String? inningId,
    bool switchStrike = false,
    int? extra,
    ExtrasType? extrasType,
    bool isFour = false,
    bool isSix = false,
    String? playerOutId,
    String? wicketTakerId,
    WicketType? wicketType,
  }) async {
    int ballCount = state.ballCount;
    if ((extrasType == null ||
            extrasType == ExtrasType.legBye ||
            extrasType == ExtrasType.bye) &&
        wicketType != WicketType.retired &&
        wicketType != WicketType.retiredHurt &&
        wicketType != WicketType.timedOut) {
      ballCount = state.ballCount + 1;
    }

    final ball = BallScoreModel(
        inning_id: inningId ?? state.currentInning?.id ?? "INVALID ID",
        over_number: state.overCount,
        ball_number: ballCount,
        bowler_id: state.bowler?.player.id ?? "INVALID ID",
        batsman_id: state.strikerId ?? "INVALID ID",
        is_four: isFour,
        is_six: isSix,
        extras_awarded: extra,
        extras_type: extrasType,
        player_out_id: playerOutId,
        runs_scored: run,
        wicket_taker_id: wicketTakerId,
        wicket_type: wicketType,
        time: DateTime.now());

    String id = await _ballScoreService.updateBallScore(ball);

    state = state.copyWith(
        ballCount: ballCount,
        totalRuns: state.totalRuns +
            run +
            (ball.inning_id != state.currentInning?.id &&
                    extrasType == ExtrasType.penaltyRun
                ? 0
                : extra ?? 0));

    if (wicketType != null) {
      await onWicket(wicketType, playerOutId);
    }

    if (ball.inning_id != state.currentInning?.id &&
        extrasType == ExtrasType.penaltyRun) {
      state = state.copyWith(
          previousScoresList: [
            ...state.previousScoresList,
            ball.copyWith(id: id)
          ],
          otherInning: state.otherInning?.copyWith(
              total_runs: (state.otherInning?.total_runs ?? 0) +
                  (ball.extras_awarded ?? 0)));
    } else {
      state = state.copyWith(currentScoresList: [
        ...state.currentScoresList,
        ball.copyWith(id: id)
      ]);
    }
    _updateInningScoreDetails();

    if (switchStrike) {
      setOrSwitchStriker();
    }

    checkIfInningComplete(wicket: wicketType);
  }

  Future<void> onWicket(
    WicketType wicketType,
    String? playerOutId,
  ) async {
    final outPlayer = state.batsMans
        ?.where((element) => element.player.id == playerOutId)
        .firstOrNull;

    final batsMans = state.batsMans?.toList();
    batsMans?.removeWhere((element) => element.player.id == playerOutId);
    state = state.copyWith(batsMans: batsMans);

    if (outPlayer == null) {
      return;
    }

    final updatedPlayer = outPlayer.copyWith(
        status: wicketType == WicketType.retiredHurt
            ? PlayerStatus.injured
            : PlayerStatus.played);
    updateMatchPlayerStatus((
      teamId: state.currentInning?.team_id ?? "INVALID ID",
      players: [updatedPlayer]
    ));

    if (wicketType != WicketType.retiredHurt) {
      state = state.copyWith(wicketCount: state.wicketCount + 1);
    }
  }

  void checkIfInningComplete({WicketType? wicket}) {
    final battingSquad = state.match?.teams
        .where((element) => element.team.id == state.currentInning?.team_id)
        .firstOrNull
        ?.squad
        .where((element) =>
            element.status == PlayerStatus.yetToPlay ||
            element.status == PlayerStatus.playing ||
            element.status == PlayerStatus.injured)
        .toList();

    final playing = battingSquad
        ?.where((element) => element.status == PlayerStatus.playing)
        .toList();

    final yetToPlay = battingSquad
        ?.where((element) => element.status == PlayerStatus.yetToPlay)
        .toList();

    final injured = battingSquad
        ?.where((element) => element.status == PlayerStatus.injured)
        .toList();

    final totalBalls = (state.match?.number_of_over ?? 0) * 6;
    final playedBalls = ((state.overCount - 1) * 6) + state.ballCount;

    final remainingBall = totalBalls - playedBalls;

    if (state.otherInning?.innings_status == InningStatus.finish &&
        (state.totalRuns > (state.otherInning?.total_runs ?? 0))) {
      state = state.copyWith(showMatchCompleteDialog: DateTime.now());
    } else if (((playing?.length == 1) &&
            (yetToPlay?.isEmpty ?? true) &&
            (state.continueWithInjuredPlayers
                ? injured?.isEmpty ?? true
                : true)) ||
        remainingBall <= 0) {
      // TODO: playWithInjuredPlayer
      // all-out(inc. injured) OR all-overs-complete
      if (state.otherInning?.innings_status == InningStatus.finish) {
        state = state.copyWith(showMatchCompleteDialog: DateTime.now());
      } else {
        state = state.copyWith(showInningCompleteDialog: DateTime.now());
      }
    } else if ((playing?.length == 1) &&
        (yetToPlay?.isEmpty ?? true) &&
        (injured?.isNotEmpty ?? true) &&
        state.continueWithInjuredPlayers) {
      // only injured player remaining
      // TODO: injured player remaining flow
      // ask user to continue with injured player
      // if yes then select one of them
      // if no complete the inning
    } else {
      List<BallScoreModel> fairDeliveries = state.currentScoresList
          .where((element) => (element.over_number == state.overCount &&
              element.extras_type != ExtrasType.noBall &&
              element.extras_type != ExtrasType.wide &&
              element.extras_type != ExtrasType.penaltyRun &&
              element.wicket_type != WicketType.retired &&
              element.wicket_type != WicketType.retiredHurt &&
              element.wicket_type != WicketType.timedOut))
          .toList();
      if (fairDeliveries.length == 6) {
        state = state.copyWith(showOverCompleteDialog: DateTime.now());
      } else {
        if (wicket != null) {
          state = state.copyWith(showSelectBatsManSheet: DateTime.now());
        }
      }
    }
  }

  Future<void> _updateInningScoreDetails() async {
    try {
      await _inningService.updateInningScoreDetail(
          battingTeamInningId: state.currentInning?.id ?? "INVALID ID",
          over: double.parse("${state.overCount}.${state.ballCount}"),
          totalRun: state.totalRuns,
          bowlingTeamInningId: state.otherInning?.id ?? "INVALID ID",
          wicketCount: state.wicketCount,
          runs: state.otherInning?.total_runs);

      await _matchService.updateTeamScore(
          matchId: state.match?.id ?? "INVALID ID",
          battingTeamId: state.currentInning?.team_id ?? "INVALID ID",
          totalRun: state.totalRuns,
          over: double.parse("${state.overCount}.${state.ballCount}"),
          bowlingTeamId: state.otherInning?.team_id ?? "INVALID ID",
          wicket: state.wicketCount,
          runs: state.otherInning?.total_runs);

      final teams = state.match?.teams.toList();
      teams?.map((e) {
        if (e.team.id == state.currentInning?.team_id) {
          return e.copyWith(
              over: double.parse("${state.overCount}.${state.ballCount}"),
              run: state.totalRuns);
        } else {
          return e.copyWith(
              wicket: state.wicketCount, run: state.otherInning?.total_runs);
        }
      }).toList();

      state = state.copyWith(
          match:
              state.match?.copyWith(teams: teams ?? state.match?.teams ?? []),
          currentInning: state.currentInning?.copyWith(
              overs: double.parse("${state.overCount}.${state.ballCount}"),
              total_runs: state.totalRuns),
          otherInning:
              state.otherInning?.copyWith(total_wickets: state.wicketCount));
    } catch (e) {
      debugPrint(
          "ScoreBoardViewNotifier: error while update inning score details -> $e");
    }
  }

  void setOrSwitchStriker({UserModel? batsMan}) {
    final player = batsMan ??
        state.batsMans
            ?.firstWhere((element) => element.player.id != state.strikerId)
            .player;
    state = state.copyWith(strikerId: player?.id);
  }

  Future<void> undoLastBall() async {
    try {
      final lastBall = state.currentScoresList.lastOrNull;
      if (lastBall?.over_number != state.overCount) {
        return;
      }
      await _ballScoreService.deleteBall(lastBall?.id ?? "INVALID ID");
      if (lastBall?.wicket_type != null) {
        final battingTeam = state.match?.teams
            .where((element) => element.team.id == state.currentInning?.team_id)
            .firstOrNull
            ?.squad;

        final outPlayer = battingTeam?.firstWhere(
            (element) => element.player.id == lastBall?.player_out_id);

        final newBatsMan = state.batsMans?.elementAtOrNull(1);
        if (newBatsMan != null && outPlayer != null) {
          final updateList = [
            outPlayer.copyWith(status: PlayerStatus.playing),
            newBatsMan.copyWith(
                status: newBatsMan.index == state.lastAssignedIndex
                    ? PlayerStatus.yetToPlay
                    : PlayerStatus.injured,
                index: newBatsMan.index == state.lastAssignedIndex
                    ? null
                    : newBatsMan.index)
          ];

          updateMatchPlayerStatus((
            teamId: state.currentInning?.team_id ?? "INVALID_ID",
            players: updateList
          ));

          final updatedBatsManList = state.batsMans?.toList();

          updatedBatsManList?.updateWhere(
            where: (element) => element.player.id == newBatsMan.player.id,
            updated: (oldElement) => outPlayer,
          );

          state = state.copyWith(batsMans: updatedBatsManList);
        }
      }

      final updateList = state.currentScoresList.toList();
      updateList.removeWhere((element) => element.id == lastBall?.id);

      final (ballCount, overCount) =
          (lastBall?.extras_type == ExtrasType.noBall ||
                  lastBall?.extras_type == ExtrasType.wide)
              ? (state.ballCount, state.overCount)
              : state.ballCount == 0
                  ? (5, state.overCount - 1)
                  : (state.ballCount - 1, state.overCount);
      state = state.copyWith(
        currentScoresList: updateList,
        ballCount: ballCount,
        overCount: overCount,
        wicketCount: lastBall?.wicket_type != null &&
                lastBall?.wicket_type != WicketType.retiredHurt
            ? state.wicketCount - 1
            : state.wicketCount,
        lastAssignedIndex: lastBall?.wicket_type != null
            ? state.lastAssignedIndex - 1
            : state.lastAssignedIndex,
        totalRuns: state.totalRuns -
            ((lastBall?.extras_awarded ?? 0) + (lastBall?.runs_scored ?? 0)),
      );
    } catch (e) {
      debugPrint("ScoreBoardViewNotifier: error while undo last ball -> $e");
    }
  }

  Future<void> updateMatchPlayerStatus(
      ({String teamId, List<MatchPlayer> players}) team) async {
    final teamRequest = AddMatchTeamRequest(
        team_id: team.teamId,
        squad: team.players
            .map((e) => MatchPlayerRequest(
                id: e.player.id,
                status: e.status ?? PlayerStatus.yetToPlay,
                index: e.index))
            .toList());

    await _matchService.updateTeamsSquad(
      state.match?.id ?? "INVALID ID",
      teamRequest,
    );

    final matchTeams = state.match!.teams.toList();

    matchTeams.updateWhere(
      where: (element) => team.teamId == element.team.id,
      updated: (oldElement) {
        final teamSquadList = oldElement.squad.toList();
        final newSquadList = team.players;
        teamSquadList.updateWhere(
          where: (element) =>
              newSquadList.map((e) => e.player.id).contains(element.player.id),
          updated: (oldElement) {
            return newSquadList.firstWhere(
                (element) => element.player.id == oldElement.player.id);
          },
        );

        return oldElement.copyWith(squad: teamSquadList);
      },
    );

    state = state.copyWith(match: state.match?.copyWith(teams: matchTeams));
  }

  void _showStrikerSelectionDialog() {
    state = state.copyWith(showStrikerSelectionDialog: DateTime.now());
  }

  Future<void> startNextOver() async {
    final lastBall = state.currentScoresList.last;
    bool showSelectBatsManAndBowlerSheet =
        lastBall.wicket_type != null && (state.batsMans?.length ?? 0) == 1;

    state = state.copyWith(
        overCount: state.overCount + 1,
        ballCount: 0,
        showSelectBowlerAndBatsManSheet:
            showSelectBatsManAndBowlerSheet ? DateTime.now() : null,
        showSelectBowlerSheet:
            showSelectBatsManAndBowlerSheet ? null : DateTime.now());
  }

  Future<void> startNextInning() async {
    final batsMan = state.batsMans!
        .map((e) => e.copyWith(status: PlayerStatus.played))
        .toList();
    updateMatchPlayerStatus((
      teamId: state.currentInning?.team_id ?? "INVALID ID",
      players: batsMan
    ));

    await _inningService.updateInningStatus(
        inningId: state.currentInning?.id ?? "INVALID ID",
        status: InningStatus.finish);
    await _inningService.updateInningStatus(
        inningId: state.otherInning?.id ?? "INVALID ID",
        status: InningStatus.running);

    await _matchService.updateCurrentPlayingTeam(
        state.match?.id ?? "INVALID ID", state.otherInning?.team_id);

    final swappedCurrentInning =
        state.otherInning?.copyWith(innings_status: InningStatus.running);
    final swappedOtherInning =
        state.currentInning?.copyWith(innings_status: InningStatus.finish);
    state = state.copyWith(
        lastAssignedIndex: 0,
        wicketCount: 0,
        totalRuns: state.otherInning?.total_runs ?? 0,
        overCount: 1,
        ballCount: 0,
        bowler: null,
        batsMans: List.empty(),
        previousScoresList: state.currentScoresList,
        currentScoresList: List.empty(),
        otherInning: swappedOtherInning,
        currentInning: swappedCurrentInning,
        match: state.match
            ?.copyWith(current_playing_team_id: swappedCurrentInning?.team_id),
        showSelectPlayerSheet: DateTime.now());
  }

  Future<void> endMatch() async {
    if (state.batsMans?.isNotEmpty ?? false) {
      var batsMan = state.batsMans!
          .map((e) => e.copyWith(status: PlayerStatus.played))
          .toList();
      await updateMatchPlayerStatus((
        teamId: state.currentInning?.team_id ?? "INVALID ID",
        players: batsMan
      ));
    }

    await _inningService.updateInningStatus(
        inningId: state.currentInning?.id ?? "INVALID ID",
        status: InningStatus.finish);

    await _matchService.updateMatchStatus(
        state.match?.id ?? "INVALID ID", MatchStatus.finish);

    state = state.copyWith(
        currentInning:
            state.currentInning?.copyWith(innings_status: InningStatus.finish),
        match: state.match?.copyWith(match_status: MatchStatus.finish),
        pop: true);
  }

  void onMatchOptionSelect(MatchOption option) {
    switch (option) {
      case MatchOption.changeStriker:
        _showStrikerSelectionDialog();
      case MatchOption.pauseScoring:
        state = state.copyWith(showPauseScoringDialog: DateTime.now());
      case MatchOption.penaltyRun:
        state = state.copyWith(showAddPenaltyRunDialog: DateTime.now());
    }
  }

  Future<void> onPauseScoring() async {
    await _updateInningScoreDetails();
    state = state.copyWith(pop: true);
  }

  void handlePenaltyRun(({int runs, String teamId}) penalty) {
    addBall(
      run: 0,
      inningId: state.otherInning?.team_id == penalty.teamId
          ? state.otherInning?.team_id
          : null,
      extra: penalty.runs,
      extrasType: ExtrasType.penaltyRun,
    );
  }

  void setPlayers(
      List<({String teamId, List<MatchPlayer> players})> currentPlayers) {
    MatchPlayer? bowler;
    List<MatchPlayer>? batsMans;
    var battingPlayer = currentPlayers
        .toList()
        .where((element) => element.teamId == state.currentInning?.team_id)
        .firstOrNull;

    bowler = currentPlayers
        .toList()
        .where((element) => element.teamId == state.otherInning?.team_id)
        .firstOrNull
        ?.players
        .firstOrNull;

    if (battingPlayer != null) {
      final statusUpdatedSquad = battingPlayer.players;
      for (int j = 0; j < statusUpdatedSquad.length; j++) {
        var batsManIndex = state.lastAssignedIndex + 1;
        if (statusUpdatedSquad.elementAt(j).index == null ||
            statusUpdatedSquad.elementAt(j).index == 0) {
          statusUpdatedSquad[j] = statusUpdatedSquad
              .elementAt(j)
              .copyWith(index: batsManIndex, status: PlayerStatus.playing);
          state = state.copyWith(
            lastAssignedIndex: batsManIndex,
          );
        }
      }
      batsMans = statusUpdatedSquad;
      battingPlayer =
          (teamId: battingPlayer.teamId, players: statusUpdatedSquad);
    }
    state = state.copyWith(
        bowler: bowler ?? state.bowler,
        batsMans: batsMans != null
            ? batsMans.length == 1
                ? [...?state.batsMans, batsMans.first]
                : batsMans
            : state.batsMans);

    if (!(state.batsMans?.map((e) => e.player.id).contains(state.strikerId) ??
        false)) {
      _showStrikerSelectionDialog();
    }

    if (battingPlayer != null) {
      updateMatchPlayerStatus(battingPlayer);
    }
  }
}

@freezed
class ScoreBoardViewState with _$ScoreBoardViewState {
  const factory ScoreBoardViewState({
    Object? error,
    MatchModel? match,
    InningModel? currentInning,
    InningModel? otherInning,
    MatchPlayer? bowler,
    String? strikerId,
    List<MatchPlayer>? batsMans,
    DateTime? showSelectBatsManSheet,
    DateTime? showSelectBowlerSheet,
    DateTime? showSelectBowlerAndBatsManSheet,
    DateTime? showSelectPlayerSheet,
    DateTime? showSelectWicketTypeSheet,
    DateTime? showStrikerSelectionDialog,
    DateTime? showUndoBallConfirmationDialog,
    DateTime? showOverCompleteDialog,
    DateTime? showInningCompleteDialog,
    DateTime? showMatchCompleteDialog,
    DateTime? showBoundaryDialogForSix,
    DateTime? showBoundaryDialogForFour,
    DateTime? showAddExtraDialogForNoBall,
    DateTime? showAddExtraDialogForLegBye,
    DateTime? showAddExtraDialogForBye,
    DateTime? showAddExtraDialogForFiveSeven,
    DateTime? showPauseScoringDialog,
    DateTime? showAddPenaltyRunDialog,
    DateTime? invalidUndoToast,
    @Default([]) List<BallScoreModel> currentScoresList,
    @Default([]) List<BallScoreModel> previousScoresList,
    @Default(false) bool loading,
    @Default(false) bool pop,
    @Default(false) bool continueWithInjuredPlayers,
    @Default(0) int ballCount,
    @Default(1) int overCount,
    @Default(0) int totalRuns,
    @Default(0) int wicketCount,
    @Default(0) int lastAssignedIndex,
  }) = _ScoreBoardViewState;
}

enum ScoreButton {
  zero,
  one,
  two,
  three,
  four,
  six,
  fiveOrSeven,
  undo,
  out,
  noBall,
  wideBall,
  bye,
  legBye;

  String getTitle(BuildContext context) {
    switch (this) {
      case ScoreButton.zero:
        return context.l10n.score_board_zero_text;
      case ScoreButton.one:
        return context.l10n.score_board_one_text;
      case ScoreButton.two:
        return context.l10n.score_board_two_text;
      case ScoreButton.three:
        return context.l10n.score_board_three_text;
      case ScoreButton.four:
        return context.l10n.score_board_four_text;
      case ScoreButton.six:
        return context.l10n.score_board_six_text;
      case ScoreButton.fiveOrSeven:
        return context.l10n.score_board_five_or_seven_text;
      case ScoreButton.undo:
        return context.l10n.score_board_undo_title.toString().toUpperCase();
      case ScoreButton.out:
        return context.l10n.score_board_out_text;
      case ScoreButton.noBall:
        return context.l10n.score_board_no_ball_short_text;
      case ScoreButton.wideBall:
        return context.l10n.score_board_wide_ball_short_text;
      case ScoreButton.bye:
        return context.l10n.score_board_bye_text;
      case ScoreButton.legBye:
        return context.l10n.score_board_leg_bye_text;
    }
  }
}

enum MatchOption {
  changeStriker,
  penaltyRun,
  pauseScoring;

  String getTitle(BuildContext context) {
    switch (this) {
      case MatchOption.changeStriker:
        return context.l10n.score_board_change_striker_title;
      case MatchOption.penaltyRun:
        return context.l10n.score_board_penalty_run_title;
      case MatchOption.pauseScoring:
        return context.l10n.score_board_pause_scoring_title;
    }
  }
}
