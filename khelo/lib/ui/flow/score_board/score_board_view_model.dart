import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/extensions/list_extensions.dart';
import 'package:data/service/ball_score/ball_score_service.dart';
import 'package:data/service/innings/inning_service.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/utils/combine_latest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/select_player_sheet.dart';

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
  StreamSubscription<MatchModel?>? _matchStreamSubscription;
  StreamSubscription<List<BallScoreChange>>? _ballScoreStreamSubscription;
  final StreamController<MatchModel> _matchStreamController =
      StreamController<MatchModel>.broadcast();
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
    return _ballScoreService.streamBallScoresByInningIds(
        [currentInningId, otherInningId]).handleError((e) {
      throw AppError.fromError(e);
    });
  }

  void _loadMatchesAndInning() {
    try {
      state = state.copyWith(loading: true);
      final matchInningStream = combineLatest2(
        _matchService.streamMatchById(matchId!),
        _inningService.streamInningsByMatchId(matchId: matchId!),
      ).asyncMap((data) async {
        MatchModel match = data.$1;
        List<InningModel> innings = data.$2;
        final previousMatch = state.match;
        final isMatchChanged = state.match != match;
        final isInningChanged = state.allInnings.isEmpty && innings.isNotEmpty;
        state = state.copyWith(match: match, error: null);
        if (innings.isEmpty) {
          await _createInnings(
              isForTestMatch: match.match_type == MatchType.testMatch);
        } else {
          final inningFirst = innings.firstWhereOrNull(
              (element) => element.innings_status == InningStatus.running);
          InningModel? inningSecond;
          InningModel? nextInning;
          if (match.match_type == MatchType.testMatch) {
            final isIndexEven = (inningFirst?.index ?? 0) % 2 == 0;
            inningSecond = innings.firstWhereOrNull((inning) =>
                _isSelectInning(inning, isIndexEven, inningFirst?.index ?? 0));
          } else {
            inningSecond = innings.firstWhereOrNull(
                (element) => element.innings_status != InningStatus.running);
          }

          nextInning = innings.firstWhereOrNull(
            (inning) => inning.index == (inningFirst?.index ?? 0) + 1,
          );

          if (inningFirst != state.currentInning ||
              inningSecond != state.otherInning ||
              nextInning != state.nextInning) {
            state = state.copyWith(
                allInnings: innings,
                currentInning: inningFirst,
                otherInning: inningSecond,
                nextInning: nextInning,
                error: null);
          }
        }

        if (isMatchChanged || isInningChanged) {
          final previousIsMatchUpdatedState = state.isMatchUpdated;
          _configureCurrentBatsmen();
          if (!previousIsMatchUpdatedState ||
              previousMatch == null ||
              isInningChanged) {
            // return match only if first time loading or change occur due to add or undo or got innings
            return match;
          }
        }
      });
      _matchStreamSubscription = matchInningStream.listen((matchStream) {
        if (!state.ballScoreQueryListenerSet) {
          _loadBallScore();
        }
        if (matchStream is MatchModel) {
          _matchStreamController.add(matchStream);
        }
      }, onError: (e, stack) {
        debugPrint(
            "ScoreBoardViewNotifier: error while loading match and inning -> $e, \nstack: $stack");
        _matchStreamController.addError(AppError.fromError(e));
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

  bool _isSelectInning(
    InningModel inning,
    bool isIndexEven,
    int firstInningIndex,
  ) {
    final index = isIndexEven ? firstInningIndex - 1 : firstInningIndex + 1;
    return inning.innings_status != InningStatus.running &&
        index == inning.index;
  }

  void _loadBallScore() {
    final currentInningId = state.currentInning?.id;
    final otherInningId = state.otherInning?.id;
    if (currentInningId == null || otherInningId == null) {
      return;
    }

    _ballScoreStreamSubscription?.cancel();
    try {
      state = state.copyWith(ballScoreQueryListenerSet: true);
      final ballScoreStream = combineLatest2(_matchStreamController.stream,
              _loadBallScoresStream(currentInningId, otherInningId))
          .map((data) {
        final scores = data.$2;

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

        currentScoreList.sort((a, b) =>
            (a.score_time ?? a.time)
                ?.compareTo(b.score_time ?? b.time ?? DateTime.now()) ??
            0);

        previousScoreList.sort((a, b) =>
            (a.score_time ?? a.time)
                ?.compareTo(b.score_time ?? b.time ?? DateTime.now()) ??
            0);
        state = state.copyWith(
            currentScoresList: currentScoreList,
            previousScoresList: previousScoreList,
            ballScoreQueryListenerSet: true,
            loading: false,
            error: null);
        return scores;
      });
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

    final List<MatchPlayer>? battingTeamSquad = state.match!.teams
        .firstWhereOrNull((element) =>
            state.match!.current_playing_team_id == element.team.id)
        ?.squad;
    final currentPlayingBatsMan = battingTeamSquad
        ?.where((element) => element.performance.any((element) =>
            element.status == PlayerStatus.playing &&
            element.inning_id == state.currentInning?.id))
        .toList();

    int lastPlayerIndex = battingTeamSquad
            ?.map(
              (e) => e.performance
                  .firstWhereOrNull(
                      (element) => element.inning_id == state.currentInning?.id)
                  ?.index,
            )
            .reduce((value, element) =>
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
            .firstWhereOrNull((element) => element.player.id == bowlerId)
        : null;

    state = state.copyWith(
      bowler: bowler,
      overCount: isAfterUndo ? state.overCount : lastBall?.over_number ?? 1,
      position: null,
      tappedButton: null,
      isLongTap: null,
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
            ?.firstWhereOrNull((element) =>
                element.player.id != lastBall.batsman_id &&
                element.player.id != lastBall.non_striker_id)
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

  Future<void> _createInnings({
    bool isForTestMatch = false,
  }) async {
    final matchId = state.match?.id;
    final tossWinnerId = state.match?.toss_winner_id;
    final tossDecision = state.match?.toss_decision;
    final opponentTeamId = state.match?.teams
        .firstWhereOrNull(
            (element) => element.team.id != state.match?.toss_winner_id)
        ?.team
        .id;
    if (matchId == null ||
        tossWinnerId == null ||
        tossDecision == null ||
        opponentTeamId == null) {
      return;
    }

    try {
      final List<InningModel> innings = [];
      innings.add(InningModel(
        id: _inningService.generateInningId,
        match_id: matchId,
        team_id: tossWinnerId,
        index: tossDecision == TossDecision.bat ? 1 : 2,
        innings_status: tossDecision == TossDecision.bat
            ? InningStatus.running
            : InningStatus.yetToStart,
      ));
      innings.add(InningModel(
        id: _inningService.generateInningId,
        match_id: matchId,
        team_id: opponentTeamId,
        index: tossDecision == TossDecision.bat ? 2 : 1,
        innings_status: tossDecision == TossDecision.bat
            ? InningStatus.yetToStart
            : InningStatus.running,
      ));
      if (isForTestMatch) {
        innings.add(InningModel(
          id: _inningService.generateInningId,
          match_id: matchId,
          team_id: tossWinnerId,
          index: tossDecision == TossDecision.bat ? 3 : 4,
          innings_status: InningStatus.yetToStart,
        ));
        innings.add(InningModel(
          id: _inningService.generateInningId,
          match_id: matchId,
          team_id: opponentTeamId,
          index: tossDecision == TossDecision.bat ? 4 : 3,
          innings_status: InningStatus.yetToStart,
        ));
      }
      await _inningService.createInnings(innings: innings);
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
      case MatchOption.addSubstitute:
        state = state.copyWith(showAddSubstituteSheet: DateTime.now());
      case MatchOption.endMatch:
        state = state.copyWith(showEndMatchSheet: DateTime.now());
      case MatchOption.reviseTarget:
        state = state.copyWith(showReviseTargetSheet: DateTime.now());
      default:
        return;
    }
  }

  void _showStrikerSelectionSheet() {
    state = state.copyWith(showStrikerSelectionSheet: DateTime.now());
  }

  void onScoreButtonTap(ScoreButton btn, bool isLongTap) {
    if (state.isActionInProgress) return;
    state = state.copyWith(
      tappedButton: btn,
      isLongTap: isLongTap,
    );
    if (_showFieldingPositionSheet(btn)) {
      state = state.copyWith(showSelectFieldingPositionSheet: DateTime.now());
      return;
    }

    _handleAddingBall(btn, isLongTap);
  }

  void _handleAddingBall(ScoreButton btn, bool isLongTap) {
    switch (btn) {
      case ScoreButton.zero:
        addBall(run: 0, position: state.position);
      case ScoreButton.one:
        addBall(run: 1, position: state.position);
      case ScoreButton.two:
        addBall(run: 2, position: state.position);
      case ScoreButton.three:
        addBall(run: 3, position: state.position);
      case ScoreButton.four:
        addBall(run: 4, isFour: !isLongTap, position: state.position);
      case ScoreButton.six:
        addBall(run: 6, isSix: !isLongTap, position: state.position);
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
            position: state.position);
      case ScoreButton.bye:
        state = state.copyWith(showAddExtraSheetForBye: DateTime.now());
      case ScoreButton.legBye:
        state = state.copyWith(showAddExtraSheetForLegBye: DateTime.now());
    }
  }

  bool _showFieldingPositionSheet(ScoreButton tapped) {
    bool isDotBall = tapped == ScoreButton.zero;
    bool isLessRuns = tapped == ScoreButton.one ||
        tapped == ScoreButton.two ||
        tapped == ScoreButton.three;

    return (tapped != ScoreButton.undo &&
        ((isDotBall && state.showForDotBall) ||
            (isLessRuns && state.showForLessRun) ||
            (!isDotBall && !isLessRuns)));
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
    FieldingPositionType? position,
  }) async {
    state = state.copyWith(actionError: null, isActionInProgress: true);
    try {
      final ballInningId = inningId ?? state.currentInning?.id;
      final bowlerId = state.bowler?.player.id;
      final strikerId = state.strikerId;
      final nonStrikerId = state.batsMans
          ?.firstWhereOrNull((element) => element.player.id != state.strikerId)
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
        id: _ballScoreService.generateBallScoreId,
        inning_id: ballInningId,
        match_id: state.match?.id ?? matchId,
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
        fielding_position: position,
        time: DateTime.now(),
        score_time: DateTime.now(),
      );
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

      final otherBattingInning = state.allInnings.firstWhereOrNull((element) =>
          element.team_id == battingTeamId &&
          element.id != battingTeamInningId);
      final otherBowlingInning = state.allInnings.firstWhereOrNull((element) =>
          element.team_id == bowlingTeamId &&
          element.id != bowlingTeamInningId);
      await _ballScoreService.addBallScoreAndUpdateTeamDetails(
        score: ball,
        matchId: matchId,
        battingTeamId: battingTeamId,
        battingTeamInningId: battingTeamInningId,
        totalRuns: totalRuns,
        otherInningOver: otherBattingInning?.overs ?? 0,
        otherTotalRuns: otherBattingInning?.total_runs ?? 0,
        bowlingTeamId: bowlingTeamId,
        bowlingTeamInningId: bowlingTeamInningId,
        totalWicketTaken: wicketCount,
        totalBowlingTeamRuns: bowlingTeamRuns,
        otherTotalWicketTaken: otherBowlingInning?.total_wickets ?? 0,
        otherTotalBowlingTeamRuns: otherBowlingInning?.total_runs ?? 0,
        updatedPlayer: updatedPlayer,
      );
      state = state.copyWith(isActionInProgress: false);
    } catch (e) {
      debugPrint("ScoreBoardViewNotifier: error while adding ball -> $e");
      state = state.copyWith(
          actionError: e, isMatchUpdated: true, isActionInProgress: false);
    }
  }

  MatchPlayer? _getUpdatedOutPlayerStatus(
    WicketType? wicketType,
    String? playerOutId,
  ) {
    if (wicketType == null) {
      return null;
    }

    final outPlayer = state.batsMans
        ?.firstWhereOrNull((element) => element.player.id == playerOutId);

    if (outPlayer == null) {
      return null;
    }

    final outPlayerPerformance = outPlayer.performance.toList().updateWhere(
        where: (element) => element.inning_id == state.currentInning?.id,
        updated: (oldElement) => oldElement.copyWith(
            status: wicketType == WicketType.retiredHurt
                ? PlayerStatus.injured
                : PlayerStatus.played));

    final updatedPlayer = outPlayer.copyWith(
      performance: outPlayerPerformance,
    );

    return MatchPlayer(
      id: updatedPlayer.player.id,
      performance: updatedPlayer.performance,
    );
  }

  void setOrSwitchStriker({String? batsManId}) {
    final striker = batsManId ??
        state.batsMans
            ?.firstWhereOrNull(
                (element) => element.player.id != state.strikerId)
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
      _handleInningComplete();
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

  void _handleInningComplete() {
    // match or inning complete
    switch (state.match?.match_type) {
      case MatchType.testMatch:
        switch (state.currentInning?.index) {
          case 1 || 2:
            state = state.copyWith(showInningCompleteSheet: DateTime.now());
          case 3:
            if (_isTargetAchieved()) {
              state = state.copyWith(showMatchCompleteSheet: DateTime.now());
            } else {
              state = state.copyWith(showInningCompleteSheet: DateTime.now());
            }
          case 4:
            state = state.copyWith(showMatchCompleteSheet: DateTime.now());
        }
      default:
        if (state.otherInning?.innings_status == InningStatus.finish ||
            _isMatchTied()) {
          state = state.copyWith(showMatchCompleteSheet: DateTime.now());
        } else {
          state = state.copyWith(showInningCompleteSheet: DateTime.now());
        }
    }
  }

  bool _isAllOut() {
    // yet_to_play == 0 && playing == 1 && (cont_with_inj ? injured == 0 : true) && wicket_count == (cont_with_inj ? total_wicket : total_wicket - injure_count) - 1
    final teamId = state.currentInning?.team_id;
    final bowlingInningOfCurrentBattingTeam = state.allInnings
        .where((element) => element.team_id != teamId)
        .map((e) => e.id);

    final battingSquad = state.match?.teams
        .firstWhereOrNull((element) => element.team.id == teamId)
        ?.squad
        .where(
          (element) => !element.performance.any(
            (element) =>
                bowlingInningOfCurrentBattingTeam.contains(element.inning_id) &&
                element.status == PlayerStatus.substitute,
          ),
        );

    int yetToPlayCount = 0;
    int playingCount = 0;
    int injuredCount = 0;

    battingSquad?.forEach((element) {
      final currentPerformance = element.performance.firstWhereOrNull(
          (element) => element.inning_id == state.currentInning?.id);

      if (currentPerformance?.status == PlayerStatus.yetToPlay) {
        yetToPlayCount += 1;
      } else if (currentPerformance?.status == PlayerStatus.playing) {
        playingCount += 1;
      } else if (currentPerformance?.status == PlayerStatus.injured) {
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
    switch (state.match?.match_type) {
      case MatchType.testMatch:
        // it will always be false as there's not limited over
        return false;
      default:
        // fair_deliveries / 6 == number_of_over_decided
        // number_of_total_ball == total_played_ball
        final revisedOver = state.match?.revised_target?.overs;
        final totalBalls =
            (revisedOver ?? state.match?.number_of_over ?? 0) * 6;
        final playedBalls = ((state.overCount - 1) * 6) + state.ballCount;

        return playedBalls == totalBalls;
    }
  }

  bool _isTargetAchieved() {
    switch (state.match?.match_type) {
      case MatchType.testMatch:
        if (state.currentInning?.index == 3 ||
            state.currentInning?.index == 4) {
          final secondPlayingTeamId = state.currentInning?.index == 3
              ? state.otherInning?.team_id
              : state.currentInning?.team_id;

          final secondPlayingTeam = state.match?.teams.firstWhereOrNull(
            (element) => element.team.id == secondPlayingTeamId,
          );

          final firstPlayingTeam = state.match?.teams.firstWhereOrNull(
            (element) => element.team.id != secondPlayingTeamId,
          );
          if (firstPlayingTeam == null || secondPlayingTeam == null) {
            return false;
          }

          final isThirdInningAllOut =
              state.currentInning?.index == 3 && _isAllOut();
          final isFourthInningRunning = state.currentInning?.index == 4;

          return (isThirdInningAllOut || isFourthInningRunning) &&
              secondPlayingTeam.run > firstPlayingTeam.run;
        } else {
          return false;
        }
      default:
        // run >= target_run (other_teams_run + 1)
        if (state.otherInning?.innings_status == InningStatus.yetToStart ||
            state.otherInning == null ||
            state.currentInning == null) {
          return false;
        }

        final targetRun = state.match?.revised_target?.runs ??
            (state.otherInning!.total_runs) + 1;
        return state.currentInning!.total_runs >= targetRun;
    }
  }

  bool _isMatchTied() {
    switch (state.match?.match_type) {
      case MatchType.testMatch:
        if (state.currentInning?.index == 4 && _isAllOut()) {
          final secondPlayingTeamId = state.currentInning?.team_id;

          final secondPlayingTeam = state.match?.teams.firstWhereOrNull(
            (element) => element.team.id == secondPlayingTeamId,
          );

          final firstPlayingTeam = state.match?.teams.firstWhereOrNull(
            (element) => element.team.id != secondPlayingTeamId,
          );
          if (firstPlayingTeam == null || secondPlayingTeam == null) {
            return false;
          }

          return secondPlayingTeam.run == firstPlayingTeam.run;
        } else {
          return false;
        }
      default:
        // inning_complete and run == other_teams_run
        final isInningComplete = _isAllOut() || _isAllDeliveryDelivered();
        if (state.otherInning?.innings_status == InningStatus.yetToStart ||
            state.otherInning == null) {
          return false;
        }

        return isInningComplete &&
            state.currentInning?.total_runs == state.otherInning?.total_runs;
    }
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

      final otherBattingInning = state.allInnings.firstWhereOrNull((element) =>
          element.team_id == battingTeamId &&
          element.id != battingTeamInningId);
      final otherBowlingInning = state.allInnings.firstWhereOrNull((element) =>
          element.team_id == bowlingTeamId &&
          element.id != bowlingTeamInningId);

      await _ballScoreService.deleteBallAndUpdateTeamDetails(
          ballId: lastBall.id,
          matchId: matchId,
          battingTeamId: battingTeamId,
          battingTeamInningId: battingTeamInningId,
          overCount: overCount,
          totalRuns: totalRuns,
          otherInningOver: otherBattingInning?.overs ?? 0,
          otherTotalRuns: otherBattingInning?.total_runs ?? 0,
          bowlingTeamId: bowlingTeamId,
          bowlingTeamInningId: bowlingTeamInningId,
          totalWicketTaken: wicketCount,
          otherTotalWicketTaken: otherBowlingInning?.total_wickets ?? 0,
          otherTotalBowlingTeamRuns: otherBowlingInning?.total_runs ?? 0,
          updatedPlayer: updatedPlayers);
      state = state.copyWith(isActionInProgress: false);
    } catch (e) {
      debugPrint("ScoreBoardViewNotifier: error while undo last ball -> $e");
      state = state.copyWith(
          actionError: e, isMatchUpdated: true, isActionInProgress: false);
    }
  }

  List<MatchPlayer>? _getUndoPlayerStatus(BallScoreModel lastBall) {
    if (lastBall.wicket_type == null) {
      return null;
    }
    final battingTeam = state.match?.teams
        .firstWhereOrNull(
            (element) => element.team.id == state.currentInning?.team_id)
        ?.squad;

    final outPlayer = battingTeam?.firstWhereOrNull(
        (element) => element.player.id == lastBall.player_out_id);

    if (outPlayer == null) {
      return null;
    }
    final newBatsMan = state.batsMans?.firstWhereOrNull((element) =>
        element.player.id != lastBall.batsman_id &&
        element.player.id != lastBall.non_striker_id);

    final getOutPlayersPerformance = outPlayer.performance.updateWhere(
        where: (element) => element.inning_id == state.currentInning?.id,
        updated: (oldElement) => oldElement.copyWith(
              status: PlayerStatus.playing,
            ));

    List<MatchPlayer> updateList = [
      MatchPlayer(
        id: outPlayer.player.id,
        performance: getOutPlayersPerformance,
      )
    ];
    if (newBatsMan != null) {
      final getNewBatsMansPerformance = newBatsMan.performance.updateWhere(
          where: (element) => element.inning_id == state.currentInning?.id,
          updated: (oldElement) => oldElement.copyWith(
              status: oldElement.index == state.lastAssignedIndex
                  ? PlayerStatus.yetToPlay
                  : PlayerStatus.injured,
              index: oldElement.index == state.lastAssignedIndex
                  ? null
                  : oldElement.index));
      final newBatsmanRequest = MatchPlayer(
        id: newBatsMan.player.id,
        performance: getNewBatsMansPerformance,
      );
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
      final teamRequest = MatchTeamModel(
          team_id: team.teamId,
          squad: team.players
              .map((e) => MatchPlayer(
                    id: e.player.id,
                    performance: e.performance,
                  ))
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
    final otherInning = state.otherInning;
    final matchId = state.match?.id;
    if (currentInningId == null ||
        currentInningTeamId == null ||
        otherInning == null ||
        matchId == null) {
      return;
    }
    try {
      state = state.copyWith(actionError: null, isActionInProgress: true);
      final batsMan = state.batsMans!
          .map((e) => e.copyWith(
                  performance: e.performance.updateWhere(
                where: (element) =>
                    element.inning_id == state.currentInning?.id,
                updated: (oldElement) =>
                    oldElement.copyWith(status: PlayerStatus.played),
              )))
          .toList();

      await _updateMatchPlayerStatus(
          (teamId: currentInningTeamId, players: batsMan));

      final runningInning =
          state.nextInning != null ? state.nextInning! : otherInning;

      await _inningService.updateInningsStatuses({
        currentInningId: InningStatus.finish,
        runningInning.id: InningStatus.running
      });

      await _matchService.updateCurrentPlayingTeam(
        matchId: matchId,
        teamId: runningInning.team_id,
      );

      state = state.copyWith(
          lastAssignedIndex: 0,
          overCount: 1,
          ballCount: 0,
          bowler: null,
          batsMans: List.empty(),
          previousScoresList:
              runningInning.index == 3 ? List.empty() : state.currentScoresList,
          currentScoresList: List.empty(),
          continueWithInjuredPlayers: true,
          showSelectPlayerSheet: DateTime.now(),
          ballScoreQueryListenerSet: runningInning.index == 3
              ? false
              : state.ballScoreQueryListenerSet,
          isActionInProgress: false);
    } catch (e) {
      debugPrint("ScoreBoardViewNotifier: error while start next inning -> $e");
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
            .map((e) => e.copyWith(
                    performance: e.performance.updateWhere(
                  where: (element) =>
                      element.inning_id == state.currentInning?.id,
                  updated: (oldElement) =>
                      oldElement.copyWith(status: PlayerStatus.played),
                )))
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
        position: null);
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
      var battingPlayer = currentPlayers.firstWhereOrNull(
          (element) => element.teamId == state.currentInning?.team_id);

      bowler = currentPlayers
          .firstWhereOrNull(
              (element) => element.teamId == state.otherInning?.team_id)
          ?.players
          .firstOrNull;

      if (battingPlayer != null) {
        final statusUpdatedSquad = battingPlayer.players;
        for (int index = 0; index < statusUpdatedSquad.length; index++) {
          int batsManIndex = state.lastAssignedIndex + 1;

          final playerPerformance = statusUpdatedSquad
              .elementAt(index)
              .performance
              .firstWhereOrNull(
                  (element) => element.inning_id == state.currentInning?.id);

          if (playerPerformance?.index == null ||
              playerPerformance?.index == 0 ||
              playerPerformance?.status == PlayerStatus.injured) {
            statusUpdatedSquad[index] =
                statusUpdatedSquad.elementAt(index).copyWith(
                      performance: statusUpdatedSquad
                          .elementAt(index)
                          .performance
                          .updateWhere(
                            where: (element) =>
                                element.inning_id == state.currentInning?.id,
                            updated: (oldElement) => oldElement.copyWith(
                                index: batsManIndex,
                                status: PlayerStatus.playing),
                            onNotFound: state.currentInning?.id == null
                                ? null
                                : () => PlayerPerformance(
                                    inning_id: state.currentInning?.id ?? '',
                                    status: PlayerStatus.playing,
                                    index: batsManIndex),
                          ),
                    );
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
      debugPrint("ScoreBoardViewNotifier: error while set players -> $e");
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

  String getOverCount() {
    return state.currentInning?.overs.toString() ??
        "${state.overCount - 1}.${state.ballCount}";
  }

  String? getTeamName({bool isBattingTeam = true}) {
    final teamId = isBattingTeam
        ? state.currentInning?.team_id
        : state.otherInning?.team_id;
    final teamName = state.match?.teams
        .firstWhereOrNull((element) => element.team.id == teamId)
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
        .firstWhere((element) => element.team.id == teamId)
        .squad;

    if (type == PlayerSelectionType.bowler) {
      // remove substitute to select from bowlers
      // get bowlingInningIds of currentBowlingTeam
      final bowlingInningOfCurrentBowlingTeam = state.allInnings
          .where((element) => element.team_id != teamId)
          .map((e) => e.id);
      // if any player is substitute in those innings then remove it else keep them as bowler
      return teamPlayers
              ?.where(
                (element) => !element.performance.any(
                  (element) =>
                      bowlingInningOfCurrentBowlingTeam
                          .contains(element.inning_id) &&
                      element.status == PlayerStatus.substitute,
                ),
              )
              .toList() ??
          [];
    } else {
      // for any bowling innings if player is substitute remove it from batsmen List
      // get bowlingInningIds of currentBattingTeam
      final bowlingInningOfCurrentBattingTeam = state.allInnings
          .where((element) => element.team_id != teamId)
          .map((e) => e.id);
      // if any player is substitute in those innings then remove it else keep them as batsman
      return teamPlayers
              ?.where((element) =>
                  !element.performance.any(
                    (element) =>
                        bowlingInningOfCurrentBattingTeam
                            .contains(element.inning_id) &&
                        element.status == PlayerStatus.substitute,
                  ) &&
                  _isPlayerEligibleForBatsman(element.performance
                      .firstWhereOrNull((element) =>
                          element.inning_id == state.currentInning?.id)
                      ?.status))
              .toList() ??
          [];
    }
  }

  List<UserModel> getNonPlayingTeamMembers() {
    if (state.match == null) {
      return [];
    }

    final team = state.match?.teams.firstWhereOrNull(
        (element) => element.team.id != state.currentInning?.team_id);
    final teamSquadIds = team?.squad.map((e) => e.player.id).toList() ?? [];
    final teamPlayers = team?.team.players
        .where((element) =>
            !teamSquadIds.contains(element.id) && element.user.isActive)
        .map((e) => e.user)
        .toList();
    return teamPlayers ?? [];
  }

  List<String> getPlayingSquadIds() {
    if (state.match == null) {
      return [];
    }

    final team = state.match?.teams.firstWhereOrNull(
        (element) => element.team.id != state.currentInning?.team_id);
    final teamSquadIds = team?.squad.map((e) => e.player.id).toList() ?? [];
    return teamSquadIds;
  }

  Future<void> addSubstitute(UserModel player) async {
    final fieldingTeam = state.match?.teams.firstWhereOrNull(
        (element) => element.team.id != state.currentInning?.team_id);
    if (fieldingTeam == null) {
      return;
    }
    final substituteStatus = PlayerPerformance(
        inning_id: state.currentInning?.id ?? '',
        status: PlayerStatus.substitute);

    final matchPlayer = fieldingTeam.squad
            .firstWhereOrNull((element) => element.player.id == player.id) ??
        MatchPlayer(id: player.id, player: player);

    final playerPerformance = matchPlayer.performance.toList().updateWhere(
        where: (element) => element.inning_id == substituteStatus.inning_id,
        updated: (oldElement) =>
            oldElement.copyWith(status: PlayerStatus.substitute),
        onNotFound: () => substituteStatus);

    await _updateMatchPlayerStatus((
      teamId: fieldingTeam.team.id,
      players: [matchPlayer.copyWith(performance: playerPerformance)],
    ));
  }

  bool _isPlayerEligibleForBatsman(PlayerStatus? status) {
    return (status != PlayerStatus.played &&
            status != PlayerStatus.playing &&
            status != PlayerStatus.suspended) ||
        status == null;
  }

  List<MatchPlayer> getFielderList() {
    if (state.match == null) {
      return [];
    }

    final teamId = state.otherInning?.team_id ?? "INVALID ID";
    final teamPlayers = state.match?.teams
        .firstWhereOrNull((element) => element.team.id == teamId)
        ?.squad;

    return teamPlayers ?? [];
  }

  void onFieldingPositionSelected(
    ScoreButton tapped,
    bool isLongTapped,
    FieldingPositionType position,
    bool showForLessRun,
    bool showForDotBall,
  ) {
    state = state.copyWith(
        position: position,
        showForDotBall: showForDotBall,
        showForLessRun: showForLessRun);
    _handleAddingBall(tapped, isLongTapped);
  }

  List<BallScoreModel> getCurrentOverBall() {
    final list = state.currentScoresList
        .where((element) =>
            element.over_number == state.overCount &&
            element.extras_type != ExtrasType.penaltyRun)
        .toList();
    return list;
  }

  Future<void> setRevisedTarget(int run, int over) async {
    String? matchId = state.match?.id;
    if (matchId == null) {
      return;
    }
    final revisedTarget = RevisedTarget(
      runs: run,
      overs: over.toDouble(),
      time: DateTime.now(),
      revised_time: DateTime.now(),
    );
    await _matchService.setRevisedTarget(
        matchId: matchId, revisedTarget: revisedTarget);
  }

   _cancelStreamSubscription() async {
    await _matchStreamSubscription?.cancel();
    await _ballScoreStreamSubscription?.cancel();
    await _matchStreamController.close();
  }

  void onResume() {
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
    InningModel? nextInning,
    DateTime? showSelectFieldingPositionSheet,
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
    DateTime? showAddExtraSheetForNoBall,
    DateTime? showAddExtraSheetForLegBye,
    DateTime? showAddExtraSheetForBye,
    DateTime? showAddExtraSheetForFiveSeven,
    DateTime? showPauseScoringSheet,
    DateTime? showAddPenaltyRunSheet,
    DateTime? showEndMatchSheet,
    DateTime? showAddSubstituteSheet,
    DateTime? invalidUndoToast,
    DateTime? showReviseTargetSheet,
    ScoreButton? tappedButton,
    bool? isLongTap,
    FieldingPositionType? position,
    @Default([]) List<InningModel> allInnings,
    @Default([]) List<BallScoreModel> currentScoresList,
    @Default([]) List<BallScoreModel> previousScoresList,
    @Default(false) bool loading,
    @Default(false) bool pop,
    @Default(true) bool continueWithInjuredPlayers,
    @Default(false) bool ballScoreQueryListenerSet,
    @Default(true) bool isMatchUpdated,
    @Default(false) bool isActionInProgress,
    @Default(true) bool showForLessRun,
    @Default(true) bool showForDotBall,
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
  reviseTarget,
  pauseScoring,
  continueWithInjuredPlayer,
  addSubstitute,
  endMatch;

  String getTitle(BuildContext context) {
    switch (this) {
      case MatchOption.changeStriker:
        return context.l10n.score_board_change_striker_title;
      case MatchOption.penaltyRun:
        return context.l10n.score_board_penalty_run_title;
      case MatchOption.reviseTarget:
        return context.l10n.score_board_revised_target_title;
      case MatchOption.pauseScoring:
        return context.l10n.score_board_pause_scoring_title;
      case MatchOption.continueWithInjuredPlayer:
        return context.l10n.score_board_continue_with_injured_player_title;
      case MatchOption.addSubstitute:
        return context.l10n.score_board_add_substitute_title;
      case MatchOption.endMatch:
        return context.l10n.score_board_option_end_match;
    }
  }
}
