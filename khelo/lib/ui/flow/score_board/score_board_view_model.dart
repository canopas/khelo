import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/innings/inning_service.dart';
import 'package:data/service/ball_score/ball_score_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/select_player_sheet.dart';
import 'package:rxdart/rxdart.dart';

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
  late StreamSubscription<MatchModel?> _matchStreamSubscription;
  late StreamSubscription<List<BallScoreChange>> _ballScoreStreamSubscription;
  final StreamController<MatchModel> _matchStreamController =
      StreamController<MatchModel>();
  String? matchId;

  ScoreBoardViewNotifier(
    this._matchService,
    this._inningService,
    this._ballScoreService,
  ) : super(const ScoreBoardViewState());

  void setData(String matchId) {
    this.matchId = matchId;
    _loadMatchesAndInning();
  }

  Stream<List<BallScoreChange>> _loadBallScoresStream(
    String currentInningId,
    String otherInningId,
  ) {
    return _ballScoreService.getBallScoresStreamByInningIds(
        [currentInningId, otherInningId]).handleError((e) {
      throw AppError.fromError(e);
    });
  }

  void _loadMatchesAndInning() {
    try {
      state = state.copyWith(loading: true);
      final matchInningStream = Rx.combineLatest2(
        _matchService.getMatchStreamById(matchId!),
        _inningService.getInningsStreamByMatchId(matchId: matchId!),
        (match, innings) => {'match': match, 'innings': innings},
      ).asyncMap((data) async {
        try {
          MatchModel match = data['match'] as MatchModel;
          List<InningModel> innings = data['innings'] as List<InningModel>;
          final previousMatch = state.match;
          final isMatchChanged = state.match != match;
          state = state.copyWith(match: match, error: null);
          if (innings.isEmpty) {
            await _createInnings();
          } else {
            final inningFirst = innings
                .where(
                    (element) => element.innings_status == InningStatus.running)
                .firstOrNull;

            final inningSecond = innings
                .where(
                    (element) => element.innings_status != InningStatus.running)
                .firstOrNull;
            if (inningFirst != state.currentInning ||
                inningSecond != state.otherInning) {
              state = state.copyWith(
                  currentInning: inningFirst,
                  otherInning: inningSecond,
                  error: null);
            }
          }

          if (isMatchChanged) {
            final previousIsMatchUpdatedState = state.isMatchUpdated;
            _configureCurrentBatsmen();
            if (!previousIsMatchUpdatedState || previousMatch == null) {
              // return match only if first time loading or change occur due to add or undo
              return match;
            }
          }
        } catch (e) {
          throw AppError.fromError(e);
        }
      });
      _matchStreamSubscription = matchInningStream.listen((matchStream) {
        if (!state.ballScoreQueryListenerSet) {
          _loadBallScore();
        }
        if (matchStream is MatchModel) {
          _matchStreamController.add(matchStream);
        }
      }, onError: (e) {
        debugPrint(
            "ScoreBoardViewNotifier: error while loading match and inning -> $e");
        _matchStreamController.addError(e);
        state = state.copyWith(
            error: AppError.fromError(e),
            loading: false,
            isActionInProgress: false);
      });
    } catch (e) {
      debugPrint(
          "ScoreBoardViewNotifier: error while loading match and inning -> $e");
      state = state.copyWith(
          error: AppError.fromError(e),
          loading: false,
          isActionInProgress: false);
    }
  }

  void _loadBallScore() {
    final currentInningId = state.currentInning?.id;
    final otherInningId = state.otherInning?.id;
    if (currentInningId == null || otherInningId == null) {
      return;
    }
    try {
      state = state.copyWith(ballScoreQueryListenerSet: true);
      final ballScoreStream = Rx.combineLatest2(
        _matchStreamController.stream,
        _loadBallScoresStream(currentInningId, otherInningId),
        (match, scores) {
          List<BallScoreModel> currentScoreList =
              state.currentScoresList.toList();
          List<BallScoreModel> previousScoreList =
              state.currentScoresList.toList();

          for (var score in scores) {
            if (score.type == DocumentChangeType.added) {
              if (score.ballScore.inning_id == state.currentInning?.id &&
                  !currentScoreList
                      .map((e) => e.id)
                      .contains(score.ballScore.id)) {
                currentScoreList.add(score.ballScore);
              } else if (score.ballScore.inning_id == state.otherInning?.id &&
                  !previousScoreList
                      .map((e) => e.id)
                      .contains(score.ballScore.id)) {
                previousScoreList.add(score.ballScore);
              }
            } else if (score.type == DocumentChangeType.removed) {
              if (score.ballScore.inning_id == state.currentInning?.id &&
                  currentScoreList
                      .map((e) => e.id)
                      .contains(score.ballScore.id)) {
                currentScoreList
                    .removeWhere((element) => element.id == score.ballScore.id);
              } else if (score.ballScore.inning_id == state.otherInning?.id &&
                  previousScoreList
                      .map((e) => e.id)
                      .contains(score.ballScore.id)) {
                previousScoreList
                    .removeWhere((element) => element.id == score.ballScore.id);
              }
            }
          }

          currentScoreList.sort(
            (a, b) => a.time.compareTo(b.time),
          );

          previousScoreList.sort(
            (a, b) => a.time.compareTo(b.time),
          );
          state = state.copyWith(
              currentScoresList: currentScoreList,
              previousScoresList: previousScoreList,
              ballScoreQueryListenerSet: true,
              loading: false,
              error: null);
          return scores;
        },
      );

      _ballScoreStreamSubscription = ballScoreStream.listen((scores) {
        if (state.isMatchUpdated) {
          _configureScoringDetails(
              isAfterUndo: scores.length == 1 &&
                  scores.elementAt(0).type == DocumentChangeType.removed);
        }
      }, onError: (e) {
        debugPrint(
            "ScoreBoardViewNotifier: error while loading ball score -> $e");
        state = state.copyWith(
            error: AppError.fromError(e),
            loading: false,
            isActionInProgress: false);
      });
    } catch (e) {
      debugPrint(
          "ScoreBoardViewNotifier: error while loading ball score -> $e");
      state = state.copyWith(
          error: AppError.fromError(e),
          loading: false,
          isActionInProgress: false);
    }
  }

  void _configureCurrentBatsmen() {
    if (state.match == null) {
      return;
    }

    final battingTeamSquad = state.match!.teams
        .where((element) =>
            state.match!.current_playing_team_id == element.team.id)
        .firstOrNull
        ?.squad;
    final currentPlayingBatsMan = battingTeamSquad
        ?.where((element) => element.status == PlayerStatus.playing)
        .toList();

    int lastPlayerIndex = battingTeamSquad?.map((e) => e.index).reduce(
            (value, element) =>
                (value ?? 0) > (element ?? 0) ? value ?? 0 : element ?? 0) ??
        0;
    state = state.copyWith(
      batsMans: currentPlayingBatsMan,
      lastAssignedIndex: lastPlayerIndex,
      isMatchUpdated: true,
    );
  }

  void _configureScoringDetails({required bool isAfterUndo}) {
    if (state.match == null ||
        state.currentInning == null ||
        state.otherInning == null) {
      return;
    }
    BallScoreModel? lastBall;
    lastBall = _getLastBallExceptPenaltyBall();

    // last_ball is not over's last ball or if last_ball_of_over then is_illegal_delivery ? bowler_id : null
    final bowlerId = lastBall?.bowler_id;
    final bowler = bowlerId != null
        ? state.match!.teams
            .firstWhere(
                (element) => state.otherInning?.team_id == element.team.id)
            .squad
            .where((element) => element.player.id == bowlerId)
            .firstOrNull
        : null;

    state = state.copyWith(
      bowler: bowler,
      overCount: isAfterUndo ? state.overCount : lastBall?.over_number ?? 1,
      ballCount: isAfterUndo && lastBall?.ball_number == 6
          ? 0
          : lastBall?.ball_number ?? 0,
    );

    if (lastBall != null) {
      // handle over complete and batsman out, or over complete case.
      _checkIfInningComplete(playerOutId: lastBall.player_out_id);
    } else {
      bool showSelectAllPlayerSheet =
          bowler == null && (state.batsMans?.isEmpty ?? true);
      state = state.copyWith(
        showSelectPlayerSheet: showSelectAllPlayerSheet ? DateTime.now() : null,
        showSelectBowlerSheet: bowler == null &&
                !showSelectAllPlayerSheet &&
                state.batsMans?.length == 2
            ? DateTime.now()
            : null,
        showSelectBowlerAndBatsManSheet: bowler == null &&
                !showSelectAllPlayerSheet &&
                state.batsMans?.length == 1
            ? DateTime.now()
            : null,
        showSelectBatsManSheet: bowler != null &&
                state.batsMans?.length == 1 &&
                !showSelectAllPlayerSheet
            ? DateTime.now()
            : null,
      );
      state = state.copyWith(isActionInProgress: false);
    }
  }

  void _configureStrikerId() {
    final lastBall = _getLastBallExceptPenaltyBall();
    if (lastBall == null) {
      _showStrikerSelectionSheet();
      return;
    }

    String? strikerId = lastBall.batsman_id;
    if (lastBall.wicket_type == null &&
        lastBall.extras_type == null &&
        lastBall.runs_scored % 2 != 0) {
      strikerId = lastBall.non_striker_id;
    } else if (lastBall.extras_type == ExtrasType.noBall) {
      final isBoundary = lastBall.is_six || lastBall.is_four;
      if (!isBoundary && lastBall.runs_scored % 2 != 0) {
        strikerId = lastBall.non_striker_id;
      }
    } else if (lastBall.wicket_type != null) {
      String? striker = strikerId;
      if ((lastBall.extras_awarded ?? 0) % 2 != 0) {
        striker = lastBall.non_striker_id;
      }
      if (striker == lastBall.player_out_id) {
        // new BatsmanId
        final newBatsmanId = state.batsMans
            ?.where((element) =>
                element.player.id != lastBall.batsman_id &&
                element.player.id != lastBall.non_striker_id)
            .firstOrNull
            ?.player
            .id;
        if (newBatsmanId != null) {
          striker = newBatsmanId;
        } else {
          _showStrikerSelectionSheet();
          return;
        }
      }
      strikerId = striker;
    }
    setOrSwitchStriker(batsManId: strikerId);
    if (lastBall.ball_number == 6 && (lastBall.isLegalDelivery() ?? false)) {
      setOrSwitchStriker();
    }
  }

  Future<void> _createInnings() async {
    final matchId = state.match?.id;
    final tossWinnerId = state.match?.toss_winner_id;
    final tossDecision = state.match?.toss_decision;
    final opponentTeamId = state.match?.teams
        .where((element) => element.team.id != state.match?.toss_winner_id)
        .firstOrNull
        ?.team
        .id;
    if (matchId == null ||
        tossWinnerId == null ||
        tossDecision == null ||
        opponentTeamId == null) {
      return;
    }

    try {
      await _inningService.createInnings(
          matchId: matchId,
          teamId: tossWinnerId,
          firstInningStatus: tossDecision == TossDecision.bat
              ? InningStatus.running
              : InningStatus.yetToStart,
          opponentTeamId: opponentTeamId,
          secondInningStatus: tossDecision == TossDecision.bat
              ? InningStatus.yetToStart
              : InningStatus.running);
    } catch (e) {
      debugPrint("ScoreBoardViewNotifier: error while create innings -> $e");
      state = state.copyWith(error: e, loading: false);
    }
  }

  void onMatchOptionSelect(MatchOption option, bool contWithInjPlayer) {
    switch (option) {
      case MatchOption.changeStriker:
        _showStrikerSelectionSheet();
      case MatchOption.pauseScoring:
        state = state.copyWith(showPauseScoringSheet: DateTime.now());
      case MatchOption.penaltyRun:
        state = state.copyWith(showAddPenaltyRunSheet: DateTime.now());
      case MatchOption.endMatch:
        state = state.copyWith(showEndMatchSheet: DateTime.now());
      default:
        return;
    }
  }

  void _showStrikerSelectionSheet() {
    state = state.copyWith(showStrikerSelectionSheet: DateTime.now());
  }

  void onScoreButtonTap(ScoreButton btn) {
    if (state.isActionInProgress) {
      return;
    }
    switch (btn) {
      case ScoreButton.zero:
        addBall(run: 0);
      case ScoreButton.one:
        addBall(run: 1);
      case ScoreButton.two:
        addBall(run: 2);
      case ScoreButton.three:
        addBall(run: 3);
      case ScoreButton.four:
        state = state.copyWith(
            showBoundaryConfirmationDialogForFour: DateTime.now());
      case ScoreButton.six:
        state = state.copyWith(
            showBoundaryConfirmationDialogForSix: DateTime.now());
      case ScoreButton.fiveOrSeven:
        state = state.copyWith(showAddExtraSheetForFiveSeven: DateTime.now());
      case ScoreButton.undo:
        final lastBall = _getLastBallExceptPenaltyBall();
        if (lastBall == null || lastBall.over_number != state.overCount) {
          state = state.copyWith(invalidUndoToast: DateTime.now());
        } else {
          state =
              state.copyWith(showUndoBallConfirmationDialog: DateTime.now());
        }
      case ScoreButton.out:
        state = state.copyWith(showSelectWicketTypeSheet: DateTime.now());
      case ScoreButton.noBall:
        state = state.copyWith(showAddExtraSheetForNoBall: DateTime.now());
      case ScoreButton.wideBall:
        addBall(
          run: 0,
          extrasType: ExtrasType.wide,
          extra: 1,
        );
      case ScoreButton.bye:
        state = state.copyWith(showAddExtraSheetForBye: DateTime.now());
      case ScoreButton.legBye:
        state = state.copyWith(showAddExtraSheetForLegBye: DateTime.now());
    }
  }

  Future<void> addBall({
    required int run,
    String? inningId,
    int? extra,
    ExtrasType? extrasType,
    bool isFour = false,
    bool isSix = false,
    String? playerOutId,
    String? wicketTakerId,
    WicketType? wicketType,
  }) async {
    state = state.copyWith(actionError: null, isActionInProgress: true);
    try {
      final ballInningId = inningId ?? state.currentInning?.id;
      final bowlerId = state.bowler?.player.id;
      final strikerId = state.strikerId;
      final nonStrikerId = state.batsMans
          ?.where((element) => element.player.id != state.strikerId)
          .firstOrNull
          ?.player
          .id;
      final matchId = state.match?.id;
      final battingTeamId = state.currentInning?.team_id;
      final battingTeamInningId = state.currentInning?.id;
      final bowlingTeamId = state.otherInning?.team_id;
      final bowlingTeamInningId = state.otherInning?.id;
      if (ballInningId == null ||
          bowlerId == null ||
          strikerId == null ||
          nonStrikerId == null ||
          matchId == null ||
          battingTeamId == null ||
          battingTeamInningId == null ||
          bowlingTeamId == null ||
          bowlingTeamInningId == null) {
        return;
      }

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
          inning_id: ballInningId,
          over_number: state.overCount,
          ball_number: ballCount,
          bowler_id: bowlerId,
          batsman_id: strikerId,
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
      int wicketCount = state.otherInning!.total_wickets;
      if (wicketType != WicketType.retiredHurt && wicketType != null) {
        wicketCount = wicketCount + 1;
      }
      final totalRuns = state.currentInning!.total_runs +
          run +
          (ball.inning_id != state.currentInning?.id &&
                  extrasType == ExtrasType.penaltyRun
              ? 0
              : extra ?? 0);
      int? bowlingTeamRuns = state.otherInning?.total_runs;
      if (ball.inning_id != state.currentInning?.id &&
          extrasType == ExtrasType.penaltyRun) {
        bowlingTeamRuns = (bowlingTeamRuns ?? 0) + (ball.extras_awarded ?? 0);
      }

      final updatedPlayer = _getUpdatedOutPlayerStatus(wicketType, playerOutId);
      state = state.copyWith(isMatchUpdated: false);
      await _ballScoreService.addBallScoreAndUpdateTeamDetails(
        score: ball,
        matchId: matchId,
        battingTeamId: battingTeamId,
        battingTeamInningId: battingTeamInningId,
        totalRuns: totalRuns,
        bowlingTeamId: bowlingTeamId,
        bowlingTeamInningId: bowlingTeamInningId,
        totalWicketTaken: wicketCount,
        totalBowlingTeamRuns: bowlingTeamRuns,
        updatedPlayer: updatedPlayer,
      );
    } catch (e) {
      debugPrint("ScoreBoardViewNotifier: error while adding ball -> $e");
      state = state.copyWith(
          actionError: e, isMatchUpdated: true, isActionInProgress: false);
    }
  }

  MatchPlayerRequest? _getUpdatedOutPlayerStatus(
    WicketType? wicketType,
    String? playerOutId,
  ) {
    if (wicketType == null) {
      return null;
    }

    final outPlayer = state.batsMans
        ?.where((element) => element.player.id == playerOutId)
        .firstOrNull;

    if (outPlayer == null) {
      return null;
    }

    final updatedPlayer = outPlayer.copyWith(
        status: wicketType == WicketType.retiredHurt
            ? PlayerStatus.injured
            : PlayerStatus.played);

    return MatchPlayerRequest(
        id: updatedPlayer.player.id,
        status: updatedPlayer.status ?? PlayerStatus.played,
        index: updatedPlayer.index);
  }

  void setOrSwitchStriker({String? batsManId}) {
    final striker = batsManId ??
        state.batsMans
            ?.where((element) => element.player.id != state.strikerId)
            .firstOrNull
            ?.player
            .id;
    state = state.copyWith(
      strikerId: striker,
    );
  }

  void _checkIfInningComplete({String? playerOutId}) {
    final allOut = _isAllOut();
    final allDeliveryDelivered = _isAllDeliveryDelivered();
    final targetAchieved = _isTargetAchieved();

    if (allOut || allDeliveryDelivered || targetAchieved) {
      // match or inning complete
      if (_isMatchTied()) {
        state = state.copyWith(showMatchCompleteSheet: DateTime.now());
      } else {
        if (state.otherInning?.innings_status == InningStatus.finish) {
          state = state.copyWith(showMatchCompleteSheet: DateTime.now());
        } else {
          state = state.copyWith(showInningCompleteSheet: DateTime.now());
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
        state = state.copyWith(showOverCompleteSheet: DateTime.now());
      } else {
        if (playerOutId != null &&
            (state.batsMans?.map((e) => e.player.id).contains(playerOutId) ??
                false)) {
          // wicket on current_ball if current_ball is not last_ball_of_over
          state = state.copyWith(showSelectBatsManSheet: DateTime.now());
        } else if (state.batsMans?.length == 1) {
          state = state.copyWith(showSelectBatsManSheet: DateTime.now());
        } else {
          _configureStrikerId();
        }
      }
    }
    state = state.copyWith(isActionInProgress: false);
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
        state.otherInning!.total_wickets == totalWicket - 1 &&
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
        state.otherInning == null ||
        state.currentInning == null) {
      return false;
    }

    final targetRun = (state.otherInning!.total_runs) + 1;
    return state.currentInning!.total_runs >= targetRun;
  }

  bool _isMatchTied() {
    // inning_complete and run == other_teams_run
    final isInningComplete = _isAllOut() || _isAllDeliveryDelivered();
    if (state.otherInning?.innings_status == InningStatus.yetToStart ||
        state.otherInning == null) {
      return false;
    }

    return isInningComplete &&
        state.currentInning?.total_runs == state.otherInning?.total_runs;
  }

  Future<void> undoLastBall() async {
    state = state.copyWith(actionError: null, isActionInProgress: true);
    try {
      final lastBall = _getLastBallExceptPenaltyBall();
      final matchId = state.match?.id;
      final battingTeamId = state.currentInning?.team_id;
      final battingTeamInningId = state.currentInning?.id;
      final bowlingTeamId = state.otherInning?.team_id;
      final bowlingTeamInningId = state.otherInning?.id;
      if (lastBall == null ||
          lastBall.id == null ||
          lastBall.over_number != state.overCount ||
          matchId == null ||
          battingTeamId == null ||
          battingTeamInningId == null ||
          bowlingTeamId == null ||
          bowlingTeamInningId == null) {
        return;
      }

      final totalRuns = (state.currentInning?.total_runs ?? 0) -
          ((lastBall.extras_awarded ?? 0) + lastBall.runs_scored);
      final wicketCount = lastBall.wicket_type != null &&
              lastBall.wicket_type != WicketType.retiredHurt
          ? state.otherInning!.total_wickets - 1
          : state.otherInning!.total_wickets;
      // if legal delivery then change else keep as it is.
      double? overCount;
      if (lastBall.isLegalDelivery() ?? false) {
        final inningOverCount =
            lastBall.ball_number == 1 && lastBall.over_number != 1
                ? lastBall.over_number - 2
                : lastBall.over_number - 1;
        final inningBallCount =
            lastBall.ball_number == 1 && lastBall.over_number != 1
                ? 6
                : lastBall.ball_number - 1;
        overCount = double.parse("$inningOverCount.$inningBallCount");
      }

      final updatedPlayers = _getUndoPlayerStatus(lastBall);
      state = state.copyWith(isMatchUpdated: false);
      await _ballScoreService.deleteBallAndUpdateTeamDetails(
          ballId: lastBall.id!,
          matchId: matchId,
          battingTeamId: battingTeamId,
          battingTeamInningId: battingTeamInningId,
          overCount: overCount,
          totalRuns: totalRuns,
          bowlingTeamId: bowlingTeamId,
          bowlingTeamInningId: bowlingTeamInningId,
          totalWicketTaken: wicketCount,
          updatedPlayer: updatedPlayers);
    } catch (e) {
      debugPrint("ScoreBoardViewNotifier: error while undo last ball -> $e");
      state = state.copyWith(
          actionError: e, isMatchUpdated: true, isActionInProgress: false);
    }
  }

  List<MatchPlayerRequest>? _getUndoPlayerStatus(BallScoreModel lastBall) {
    if (lastBall.wicket_type == null) {
      return null;
    }
    final battingTeam = state.match?.teams
        .where((element) => element.team.id == state.currentInning?.team_id)
        .firstOrNull
        ?.squad;

    final outPlayer = battingTeam
        ?.where((element) => element.player.id == lastBall.player_out_id)
        .firstOrNull;

    if (outPlayer == null) {
      return null;
    }
    final newBatsMan = state.batsMans
        ?.where((element) =>
            element.player.id != lastBall.batsman_id &&
            element.player.id != lastBall.non_striker_id)
        .firstOrNull;

    List<MatchPlayerRequest> updateList = [
      MatchPlayerRequest(
          id: outPlayer.player.id,
          status: PlayerStatus.playing,
          index: outPlayer.index)
    ];
    if (newBatsMan != null) {
      final newBatsmanRequest = MatchPlayerRequest(
          id: newBatsMan.player.id,
          status: newBatsMan.index == state.lastAssignedIndex
              ? PlayerStatus.yetToPlay
              : PlayerStatus.injured,
          index: newBatsMan.index == state.lastAssignedIndex
              ? null
              : newBatsMan.index);
      updateList.add(newBatsmanRequest);
    }

    return updateList;
  }

  BallScoreModel? _getLastBallExceptPenaltyBall() {
    // last_ball excluding penalty-run
    try {
      return state.currentScoresList
          .lastWhere((ball) => ball.extras_type != ExtrasType.penaltyRun);
    } catch (e) {
      return null;
    }
  }

  Future<void> _updateMatchPlayerStatus(
    ({String teamId, List<MatchPlayer> players}) team,
  ) async {
    final matchId = state.match?.id;
    if (matchId == null) {
      return;
    }
    try {
      final teamRequest = AddMatchTeamRequest(
          team_id: team.teamId,
          squad: team.players
              .map((e) => MatchPlayerRequest(
                  id: e.player.id,
                  status: e.status ?? PlayerStatus.yetToPlay,
                  index: e.index))
              .toList());

      await _matchService.updateTeamsSquad(
        matchId,
        teamRequest,
      );
    } catch (e) {
      debugPrint(
          "ScoreBoardViewNotifier: error while update match player status -> $e");
      rethrow;
    }
  }

  Future<void> startNextOver() async {
    state = state.copyWith(isActionInProgress: true);
    final lastBall = state.currentScoresList.last;
    bool showSelectBatsManAndBowlerSheet =
        lastBall.wicket_type != null && (state.batsMans?.length ?? 0) == 1;

    state = state.copyWith(
        overCount: state.overCount + 1,
        ballCount: 0,
        showSelectBowlerAndBatsManSheet:
            showSelectBatsManAndBowlerSheet ? DateTime.now() : null,
        showSelectBowlerSheet:
            showSelectBatsManAndBowlerSheet ? null : DateTime.now(),
        isActionInProgress: false);
  }

  Future<void> startNextInning() async {
    final currentInningId = state.currentInning?.id;
    final currentInningTeamId = state.currentInning?.team_id;
    final otherInningId = state.otherInning?.id;
    final otherInningTeamId = state.otherInning?.team_id;
    final matchId = state.match?.id;
    if (currentInningId == null ||
        currentInningTeamId == null ||
        otherInningId == null ||
        otherInningTeamId == null ||
        matchId == null) {
      return;
    }
    try {
      state = state.copyWith(actionError: null, isActionInProgress: true);
      final batsMan = state.batsMans!
          .map((e) => e.copyWith(status: PlayerStatus.played))
          .toList();
      await _updateMatchPlayerStatus(
          (teamId: currentInningTeamId, players: batsMan));

      await _inningService.updateInningStatus(
          inningId: currentInningId, status: InningStatus.finish);
      await _inningService.updateInningStatus(
          inningId: otherInningId, status: InningStatus.running);

      await _matchService.updateCurrentPlayingTeam(
          matchId: matchId, teamId: otherInningTeamId);

      state = state.copyWith(
          lastAssignedIndex: 0,
          overCount: 1,
          ballCount: 0,
          bowler: null,
          batsMans: List.empty(),
          previousScoresList: state.currentScoresList,
          currentScoresList: List.empty(),
          continueWithInjuredPlayers: true,
          showSelectPlayerSheet: DateTime.now(),
          isActionInProgress: false);
    } catch (e) {
      state = state.copyWith(actionError: e, isActionInProgress: false);
    }
  }

  Future<void> abandonMatch() async {
    final matchId = state.match?.id;
    if (matchId == null) {
      return;
    }
    try {
      state = state.copyWith(actionError: null, isActionInProgress: true);
      await _matchService.updateMatchStatus(matchId, MatchStatus.abandoned);
      state = state.copyWith(pop: true, isActionInProgress: false);
    } catch (e) {
      debugPrint("ScoreBoardViewNotifier: error while abandon match -> $e");
      state = state.copyWith(actionError: e, isActionInProgress: false);
    }
  }

  Future<void> endMatch() async {
    final matchId = state.match?.id;
    final currentInningTeamId = state.currentInning?.team_id;
    final currentInningId = state.currentInning?.id;
    if (matchId == null ||
        currentInningTeamId == null ||
        currentInningId == null) {
      return;
    }
    try {
      state = state.copyWith(actionError: null, isActionInProgress: true);
      List<MatchPlayer> batsMan = [];
      if (state.batsMans?.isNotEmpty ?? false) {
        batsMan = state.batsMans!
            .map((e) => e.copyWith(status: PlayerStatus.played))
            .toList();

        await _updateMatchPlayerStatus((
          teamId: currentInningTeamId,
          players: batsMan,
        ));
      }

      await _inningService.updateInningStatus(
          inningId: currentInningId, status: InningStatus.finish);

      await _matchService.updateMatchStatus(matchId, MatchStatus.finish);

      state = state.copyWith(pop: true, isActionInProgress: false);
    } catch (e) {
      debugPrint("ScoreBoardViewNotifier: error while end match -> $e");
      state = state.copyWith(actionError: e, isActionInProgress: false);
    }
  }

  Future<void> onPauseScoring() async {
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
    if (state.otherInning?.innings_status == InningStatus.finish) {
      state = state.copyWith(showMatchCompleteSheet: DateTime.now());
    } else {
      state = state.copyWith(showInningCompleteSheet: DateTime.now());
    }
  }

  void onContinueWithInjuredPlayersChange(bool isContinue) {
    state = state.copyWith(continueWithInjuredPlayers: isContinue);
  }

  Future<void> setPlayers({
    required List<({List<MatchPlayer> players, String teamId})> currentPlayers,
    required bool contWithInjPlayer,
  }) async {
    try {
      state = state.copyWith(actionError: null, isActionInProgress: true);

      MatchPlayer? bowler;
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
              statusUpdatedSquad.elementAt(index).index == 0 ||
              statusUpdatedSquad.elementAt(index).status ==
                  PlayerStatus.injured) {
            statusUpdatedSquad[index] = statusUpdatedSquad
                .elementAt(index)
                .copyWith(index: batsManIndex, status: PlayerStatus.playing);
            state = state.copyWith(lastAssignedIndex: batsManIndex);
          }
        }
        battingPlayer =
            (teamId: battingPlayer.teamId, players: statusUpdatedSquad);
        await _updateMatchPlayerStatus(battingPlayer);
      }

      state = state.copyWith(
          bowler: bowler ?? state.bowler, isActionInProgress: false);

      _configureStrikerId();
    } catch (e) {
      state = state.copyWith(actionError: e, isActionInProgress: false);
    }
  }

  OverStatModel getCurrentOverStatics() {
    final scoresList = state.currentScoresList
        .where((element) => element.over_number == state.overCount);

    int run = scoresList
        .where((element) => (element.extras_type == ExtrasType.noBall ||
            element.extras_type == null))
        .fold(0, (runCount, element) => runCount + element.runs_scored);

    final wicket = scoresList
        .where((element) => (element.wicket_type != null &&
            element.wicket_type != WicketType.retiredHurt))
        .length;

    final extras = scoresList
        .where((element) => (element.extras_type != null))
        .fold(
            0,
            (extraCount, element) =>
                extraCount + (element.extras_awarded ?? 0));

    return OverStatModel(run: run, wicket: wicket, extra: extras);
  }

  TeamRunStat getTeamRunDetails(bool isFirstInning) {
    final teamInning = isFirstInning ? state.currentInning : state.otherInning;

    final teamName = state.match?.teams
        .where((element) => element.team.id == teamInning?.team_id)
        .firstOrNull
        ?.team
        .name;

    return TeamRunStat(
        teamName: teamName ?? "",
        run: teamInning?.total_runs ?? 0,
        wicket: teamInning?.total_wickets ?? 0,
        over: teamInning?.overs ?? 0);
  }

  String getOverCount() {
    return state.currentInning?.overs.toString() ??
        "${state.overCount - 1}.${state.ballCount}";
  }

  String? getTeamName({bool isBattingTeam = true}) {
    final teamId = isBattingTeam
        ? state.currentInning?.team_id
        : state.otherInning?.team_id;
    final teamName = state.match?.teams
        .where((element) => element.team.id == teamId)
        .firstOrNull
        ?.team
        .name;
    return teamName;
  }

  int getExtras() {
    final extras = state.currentScoresList
        .where((element) => (element.extras_type != null))
        .fold(
            0,
            (extraCount, element) =>
                extraCount + (element.extras_awarded ?? 0));
    return extras;
  }

  List<MatchPlayer> getFilteredPlayerList(PlayerSelectionType type) {
    if (state.match == null) {
      return [];
    }

    final teamId = (type == PlayerSelectionType.batsMan
            ? state.currentInning?.team_id
            : state.otherInning?.team_id) ??
        "INVALID ID";
    final teamPlayers = state.match?.teams
        .where((element) => element.team.id == teamId)
        .firstOrNull
        ?.squad;

    if (type == PlayerSelectionType.bowler) {
      return teamPlayers ?? [];
    } else {
      return teamPlayers
              ?.where((element) => _isPlayerEligibleForBatsman(element.status))
              .toList() ??
          [];
    }
  }

  bool _isPlayerEligibleForBatsman(PlayerStatus? status) {
    return status != PlayerStatus.played &&
        status != PlayerStatus.playing &&
        status != PlayerStatus.suspended;
  }

  List<MatchPlayer> getFielderList() {
    if (state.match == null) {
      return [];
    }

    final teamId = state.otherInning?.team_id ?? "INVALID ID";
    final teamPlayers = state.match?.teams
        .firstWhere((element) => element.team.id == teamId)
        .squad;

    return teamPlayers ?? [];
  }

  List<BallScoreModel> getCurrentOverBall() {
    final list = state.currentScoresList
        .where((element) =>
            element.over_number == state.overCount &&
            element.extras_type != ExtrasType.penaltyRun)
        .toList();
    return list;
  }

  _cancelStreamSubscription() async {
    await _matchStreamSubscription.cancel();
    await _ballScoreStreamSubscription.cancel();
    await _matchStreamController.close();
  }

  onResume() {
    _cancelStreamSubscription();
    _loadMatchesAndInning();
  }

  @override
  Future<void> dispose() async {
    await _cancelStreamSubscription();
    super.dispose();
  }
}

@freezed
class ScoreBoardViewState with _$ScoreBoardViewState {
  const factory ScoreBoardViewState({
    Object? error,
    Object? actionError,
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
    DateTime? showStrikerSelectionSheet,
    DateTime? showUndoBallConfirmationDialog,
    DateTime? showOverCompleteSheet,
    DateTime? showInningCompleteSheet,
    DateTime? showMatchCompleteSheet,
    DateTime? showBoundaryConfirmationDialogForSix,
    DateTime? showBoundaryConfirmationDialogForFour,
    DateTime? showAddExtraSheetForNoBall,
    DateTime? showAddExtraSheetForLegBye,
    DateTime? showAddExtraSheetForBye,
    DateTime? showAddExtraSheetForFiveSeven,
    DateTime? showPauseScoringSheet,
    DateTime? showAddPenaltyRunSheet,
    DateTime? showEndMatchSheet,
    DateTime? invalidUndoToast,
    @Default([]) List<BallScoreModel> currentScoresList,
    @Default([]) List<BallScoreModel> previousScoresList,
    @Default(false) bool loading,
    @Default(false) bool pop,
    @Default(true) bool continueWithInjuredPlayers,
    @Default(false) bool ballScoreQueryListenerSet,
    @Default(true) bool isMatchUpdated,
    @Default(false) bool isActionInProgress,
    @Default(0) int ballCount,
    @Default(1) int overCount,
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
  continueWithInjuredPlayer,
  endMatch;

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
      case MatchOption.endMatch:
        return context.l10n.common_end_match_title;
    }
  }
}
