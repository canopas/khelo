import 'package:data/api/match/match_model.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/innings/inning_service.dart';
import 'package:data/service/ball_score/ball_score_service.dart';
import 'package:data/extensions/list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/data_model_extensions/ball_score_model_extension.dart';

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
    _getMatchById();
  }

  Future<void> _getMatchById() async {
    if (matchId == null) {
      return;
    }

    state = state.copyWith(loading: true);
    try {
      final match = await _matchService.getMatchById(matchId!);
      state = state.copyWith(match: match);

      _getInningsForTheMatch();
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint("ScoreBoardViewNotifier: error while get Match By id -> $e");
    }
  }

  Future<void> _getInningsForTheMatch() async {
    if (state.match == null) {
      return;
    }
    try {
      final innings = await _inningService.getInningsByMatchId(
          matchId: state.match!.id ?? "INVALID ID");

      if (innings.isEmpty) {
        await _createInnings();
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

      _getScoresList();
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "ScoreBoardViewNotifier: error while get innings for the match -> $e");
    }
  }

  Future<void> _getScoresList() async {
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

    BallScoreModel? lastBall;

    try {
      lastBall = _getDeliveredLastBall();
    } on StateError {
      lastBall = null;
    }

    // last_ball is not over's last ball or if last_ball_of_over then is_illegal_delivery ? bowler_id : null
    final bowlerId = lastBall?.ball_number != 6 ||
            (lastBall?.ball_number == 6 &&
                !(lastBall?.isLegalDelivery() ?? true))
        ? lastBall?.bowler_id
        : null;
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
    int inningOverCount = ((state.currentInning!.overs ?? 0) + 1).truncate();

    state = state.copyWith(
      batsMans: currentPlayingBatsMan,
      bowler: bowler,
      lastAssignedIndex: lastPlayerIndex,
      overCount: inningOverCount,
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
      strikerId: currentPlayingBatsMan.firstOrNull?.player.id,
      showSelectBatsManSheet: bowler != null &&
              currentPlayingBatsMan.length == 1 &&
              !showSelectAllPlayerSheet
          ? DateTime.now()
          : null,
      ballCount: lastBall?.ball_number ?? 0,
    );
  }

  Future<void> _createInnings() async {
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
              teams: state.match!.teams
                  .map((e) => e.copyWith(
                        wicket: 0,
                        over: 0,
                        run: 0,
                      ))
                  .toList(),
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

  void onMatchOptionSelect(MatchOption option, bool contWithInjPlayer) {
    state = state.copyWith(continueWithInjuredPlayers: contWithInjPlayer);
    switch (option) {
      case MatchOption.changeStriker:
        _showStrikerSelectionDialog();
      case MatchOption.pauseScoring:
        state = state.copyWith(showPauseScoringDialog: DateTime.now());
      case MatchOption.penaltyRun:
        state = state.copyWith(showAddPenaltyRunDialog: DateTime.now());
      default:
        return;
    }
  }

  void _showStrikerSelectionDialog() {
    state = state.copyWith(showStrikerSelectionDialog: DateTime.now());
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
        final lastBall = state.currentScoresList.lastWhere((ball) =>
            ball.extras_type != ExtrasType.penaltyRun &&
            ball.wicket_type != WicketType.timedOut &&
            ball.wicket_type != WicketType.retired &&
            ball.wicket_type != WicketType.retiredHurt);
        if (lastBall.over_number != state.overCount) {
          state = state.copyWith(invalidUndoToast: DateTime.now());
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

    final nonStrikerId = state.batsMans
            ?.firstWhere((element) => element.player.id != state.strikerId)
            .player
            .id ??
        "INVALID ID";

    final ball = BallScoreModel(
        inning_id: inningId ?? state.currentInning?.id ?? "INVALID ID",
        over_number: state.overCount,
        ball_number: ballCount,
        bowler_id: state.bowler?.player.id ?? "INVALID ID",
        batsman_id: state.strikerId ?? "INVALID ID",
        non_striker_id: nonStrikerId,
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
      await _handleWicketAndOutPlayer(wicketType, playerOutId);
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
    await _updateInningAndTeamScore();

    if (switchStrike) {
      setOrSwitchStriker();
    }

    _checkIfInningComplete(wicket: wicketType);
  }

  Future<void> _handleWicketAndOutPlayer(
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

    await _updateMatchPlayerStatus((
      teamId: state.currentInning?.team_id ?? "INVALID ID",
      players: [updatedPlayer]
    ));

    if (wicketType != WicketType.retiredHurt) {
      state = state.copyWith(wicketCount: state.wicketCount + 1);
    }
  }

  Future<void> _updateInningAndTeamScore() async {
    try {
      final overCount =
          double.parse("${state.overCount - 1}.${state.ballCount}");

      await _inningService.updateInningScoreDetail(
          battingTeamInningId: state.currentInning?.id ?? "INVALID ID",
          over: overCount,
          totalRun: state.totalRuns,
          bowlingTeamInningId: state.otherInning?.id ?? "INVALID ID",
          wicketCount: state.wicketCount,
          runs: state.otherInning?.total_runs);

      await _matchService.updateTeamScore(
          matchId: state.match?.id ?? "INVALID ID",
          battingTeamId: state.currentInning?.team_id ?? "INVALID ID",
          totalRun: state.totalRuns,
          over: overCount,
          bowlingTeamId: state.otherInning?.team_id ?? "INVALID ID",
          wicket: state.wicketCount,
          runs: state.otherInning?.total_runs);

      final teams = state.match?.teams.toList();
      teams?.map((e) {
        if (e.team.id == state.currentInning?.team_id) {
          return e.copyWith(over: overCount, run: state.totalRuns);
        } else {
          return e.copyWith(
              wicket: state.wicketCount, run: state.otherInning?.total_runs);
        }
      }).toList();

      state = state.copyWith(
          match:
              state.match?.copyWith(teams: teams ?? state.match?.teams ?? []),
          currentInning: state.currentInning
              ?.copyWith(overs: overCount, total_runs: state.totalRuns),
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
            ?.where((element) => element.player.id != state.strikerId)
            .firstOrNull
            ?.player;
    state = state.copyWith(
      strikerId: player?.id,
    );
  }

  void _checkIfInningComplete({WicketType? wicket}) {
    final allOut = _isAllOut();
    final allDeliveryDelivered = _isAllDeliveryDelivered();
    final targetAchieved = _isTargetAchieved();

    if (allOut || allDeliveryDelivered || targetAchieved) {
      // match or inning complete
      if (_isMatchTied()) {
        state = state.copyWith(showMatchCompleteDialog: DateTime.now());
      } else {
        if (state.otherInning?.innings_status == InningStatus.finish) {
          state = state.copyWith(showMatchCompleteDialog: DateTime.now());
        } else {
          state = state.copyWith(showInningCompleteDialog: DateTime.now());
        }
      }
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
        // over complete
        state = state.copyWith(showOverCompleteDialog: DateTime.now());
      } else {
        if (wicket != null) {
          // wicket on current_ball if current_ball is not last_ball_of_over
          state = state.copyWith(showSelectBatsManSheet: DateTime.now());
        }
      }
    }
  }

  bool _isAllOut() {
    // yet_to_play == 0 && playing == 1 && (cont_with_inj ? injured == 0 : true) && wicket_count == (cont_with_inj ? total_wicket : total_wicket - injure_count) - 1
    final battingSquad = state.match?.teams
        .where((element) => element.team.id == state.currentInning?.team_id)
        .firstOrNull
        ?.squad;

    int yetToPlayCount = 0;
    int playingCount = 0;
    int injuredCount = 0;

    battingSquad?.forEach((element) {
      if (element.status == PlayerStatus.yetToPlay) {
        yetToPlayCount += 1;
      } else if (element.status == PlayerStatus.playing) {
        playingCount += 1;
      } else if (element.status == PlayerStatus.injured) {
        injuredCount += 1;
      }
    });

    final totalWicket = state.continueWithInjuredPlayers
        ? (battingSquad?.length ?? 0)
        : (battingSquad?.length ?? 0) - injuredCount;
    return yetToPlayCount == 0 &&
        playingCount == 1 &&
        state.wicketCount == totalWicket - 1 &&
        (state.continueWithInjuredPlayers ? injuredCount == 0 : true);
  }

  bool _isAllDeliveryDelivered() {
    // fair_deliveries / 6 == number_of_over_decided
    // number_of_total_ball == total_played_ball
    final totalBalls = (state.match?.number_of_over ?? 0) * 6;
    final playedBalls = ((state.overCount - 1) * 6) + state.ballCount;

    return playedBalls == totalBalls;
  }

  bool _isTargetAchieved() {
    // run >= target_run (other_teams_run + 1)
    if (state.otherInning?.innings_status == InningStatus.yetToStart ||
        state.otherInning == null) {
      return false;
    }

    final targetRun = (state.otherInning!.total_runs ?? 0) + 1;
    return state.totalRuns >= targetRun;
  }

  bool _isMatchTied() {
    // inning_complete and run == other_teams_run
    final isInningComplete = _isAllOut() || _isAllDeliveryDelivered();
    if (state.otherInning?.innings_status == InningStatus.yetToStart ||
        state.otherInning == null) {
      return false;
    }

    return isInningComplete &&
        state.totalRuns == (state.otherInning!.total_runs ?? 0);
  }

  Future<void> undoLastBall() async {
    try {
      final lastBall = _getDeliveredLastBall();
      if (lastBall.over_number != state.overCount) {
        return;
      }
      await _ballScoreService.deleteBall(lastBall.id ?? "INVALID ID");
      if (lastBall.wicket_type != null) {
        final battingTeam = state.match?.teams
            .where((element) => element.team.id == state.currentInning?.team_id)
            .firstOrNull
            ?.squad;

        final outPlayer = battingTeam?.firstWhere(
            (element) => element.player.id == lastBall.player_out_id);

        final newBatsMan = state.batsMans
            ?.where((element) =>
                element.player.id != lastBall.batsman_id &&
                element.player.id != lastBall.non_striker_id)
            .firstOrNull;
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

          await _updateMatchPlayerStatus((
            teamId: state.currentInning?.team_id ?? "INVALID_ID",
            players: updateList
          ));

          final updatedBatsManList = state.batsMans?.toList();

          final batsMen = updatedBatsManList?.updateWhere(
            where: (element) => element.player.id == newBatsMan.player.id,
            updated: (oldElement) => outPlayer,
          );

          state = state.copyWith(batsMans: batsMen);
        }
      }

      final updateList = state.currentScoresList.toList();
      updateList.removeWhere((element) => element.id == lastBall.id);

      state = state.copyWith(
          currentScoresList: updateList,
          ballCount: (lastBall.extras_type == ExtrasType.noBall ||
                  lastBall.extras_type == ExtrasType.wide)
              ? state.ballCount
              : state.ballCount - 1,
          wicketCount: lastBall.wicket_type != null &&
                  lastBall.wicket_type != WicketType.retiredHurt
              ? state.wicketCount - 1
              : state.wicketCount,
          lastAssignedIndex: lastBall.wicket_type != null
              ? state.lastAssignedIndex - 1
              : state.lastAssignedIndex,
          totalRuns: state.totalRuns -
              ((lastBall.extras_awarded ?? 0) + (lastBall.runs_scored ?? 0)),
          strikerId: lastBall.wicket_type == null
              ? lastBall.batsman_id
              : state.strikerId);

      await _updateInningAndTeamScore();

      if (!(state.batsMans?.map((e) => e.player.id).contains(state.strikerId) ??
          false)) {
        _showStrikerSelectionDialog();
      }
    } catch (e) {
      debugPrint("ScoreBoardViewNotifier: error while undo last ball -> $e");
    }
  }

  BallScoreModel _getDeliveredLastBall() {
    // last_ball that is delivered no matter legal or illegal, i.e exclude penalty-run, timed out, retired or retired hurt.
    return state.currentScoresList.lastWhere((ball) =>
        ball.extras_type != ExtrasType.penaltyRun &&
        ball.wicket_type != WicketType.timedOut &&
        ball.wicket_type != WicketType.retired &&
        ball.wicket_type != WicketType.retiredHurt);
  }

  Future<void> _updateMatchPlayerStatus(
    ({String teamId, List<MatchPlayer> players}) team,
  ) async {
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

    final updatedMatchTeams = matchTeams.updateWhere(
      where: (element) => team.teamId == element.team.id,
      updated: (oldElement) {
        final teamSquadList = oldElement.squad.toList();
        final newSquadList = team.players;
        final updatedTeamSquad = teamSquadList.updateWhere(
          where: (element) =>
              newSquadList.map((e) => e.player.id).contains(element.player.id),
          updated: (oldElement) {
            return newSquadList.firstWhere(
                (element) => element.player.id == oldElement.player.id);
          },
        );

        return oldElement.copyWith(squad: updatedTeamSquad);
      },
    );

    print("${updatedMatchTeams.map((e) => e.squad.map((e) => e.status))}");

    state =
        state.copyWith(match: state.match?.copyWith(teams: updatedMatchTeams));
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
    await _updateMatchPlayerStatus((
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
        continueWithInjuredPlayers: true,
        match: state.match
            ?.copyWith(current_playing_team_id: swappedCurrentInning?.team_id),
        showSelectPlayerSheet: DateTime.now());
  }

  Future<void> endMatch() async {
    if (state.batsMans?.isNotEmpty ?? false) {
      var batsMan = state.batsMans!
          .map((e) => e.copyWith(status: PlayerStatus.played))
          .toList();
      await _updateMatchPlayerStatus((
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

  Future<void> onPauseScoring() async {
    await _updateInningAndTeamScore();
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

  void onReviewMatchResult(bool contWithInjPlayer) {
    // func will be called only if injured player is remained and user disable that continue with injured player option
    state = state.copyWith(continueWithInjuredPlayers: contWithInjPlayer);

    if (_isAllOut()) {
      if (state.otherInning?.innings_status == InningStatus.finish) {
        state = state.copyWith(showMatchCompleteDialog: DateTime.now());
      } else {
        state = state.copyWith(showInningCompleteDialog: DateTime.now());
      }
    }

    _checkIfInningComplete();
  }

  Future<void> setPlayers({
    required List<({List<MatchPlayer> players, String teamId})> currentPlayers,
    required bool contWithInjPlayer,
  }) async {
    state = state.copyWith(continueWithInjuredPlayers: contWithInjPlayer);


    MatchPlayer? bowler;
    List<MatchPlayer>? batsMen;
    var battingPlayer = currentPlayers
        .where((element) => element.teamId == state.currentInning?.team_id)
        .firstOrNull;

    bowler = currentPlayers
        .where((element) => element.teamId == state.otherInning?.team_id)
        .firstOrNull
        ?.players
        .firstOrNull;

    if (battingPlayer != null) {
      final statusUpdatedSquad = battingPlayer.players;
      for (int index = 0; index < statusUpdatedSquad.length; index++) {
        int batsManIndex = state.lastAssignedIndex + 1;

        if (statusUpdatedSquad.elementAt(index).index == null ||
            statusUpdatedSquad.elementAt(index).index == 0||
            statusUpdatedSquad.elementAt(index).status == PlayerStatus.injured) {
          statusUpdatedSquad[index] = statusUpdatedSquad
              .elementAt(index)
              .copyWith(index: batsManIndex, status: PlayerStatus.playing);
          state = state.copyWith(lastAssignedIndex: batsManIndex);
        }
      }
      batsMen = statusUpdatedSquad;
      battingPlayer =
          (teamId: battingPlayer.teamId, players: statusUpdatedSquad);
      await _updateMatchPlayerStatus(battingPlayer);
    }


    state = state.copyWith(
        bowler: bowler ?? state.bowler,
        batsMans: batsMen != null
            ? batsMen.length == 1
                ? [...? state.batsMans, batsMen.first]
                : batsMen
            : state.batsMans);

    if(!(state.batsMans?.map((e) => e.player.id).contains(state.strikerId)?? false)){
      if(batsMen != null && batsMen.length == 1){
        setOrSwitchStriker(batsMan: batsMen.first.player);
        return;
      }else{
        _showStrikerSelectionDialog();
      }

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
    @Default(true) bool continueWithInjuredPlayers,
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
  pauseScoring,
  continueWithInjuredPlayer;

  String getTitle(BuildContext context) {
    switch (this) {
      case MatchOption.changeStriker:
        return context.l10n.score_board_change_striker_title;
      case MatchOption.penaltyRun:
        return context.l10n.score_board_penalty_run_title;
      case MatchOption.pauseScoring:
        return context.l10n.score_board_pause_scoring_title;
      case MatchOption.continueWithInjuredPlayer:
        return context.l10n.score_board_continue_with_injured_player_title;
    }
  }
}
