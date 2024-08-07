import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/service/innings/inning_service.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:data/utils/constant/firestore_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/match/match_model.dart';

final ballScoreServiceProvider = Provider((ref) {
  final service = BallScoreService(
    FirebaseFirestore.instance,
    ref.read(matchServiceProvider),
    ref.read(inningServiceProvider),
    ref.read(currentUserPod)?.id,
  );

  ref.listen(currentUserPod, (_, next) => service._currentUserId = next?.id);
  return service;
});

class BallScoreService {
  final FirebaseFirestore _firestore;
  final MatchService _matchService;
  final InningsService _inningsService;
  String? _currentUserId;
  final CollectionReference<BallScoreModel> _ballScoreCollection;

  BallScoreService(this._firestore, this._matchService, this._inningsService,
      this._currentUserId)
      : _ballScoreCollection = _firestore
            .collection(FireStoreConst.ballScoresCollection)
            .withConverter(
                fromFirestore: BallScoreModel.fromFireStore,
                toFirestore: (BallScoreModel score, _) => score.toJson());

  Future<void> addBallScoreAndUpdateTeamDetails({
    required BallScoreModel score,
    required String matchId,
    required String battingTeamId,
    required String battingTeamInningId,
    required int totalRuns,
    required String bowlingTeamId,
    required String bowlingTeamInningId,
    required int totalWicketTaken,
    int? totalBowlingTeamRuns,
    MatchPlayerRequest? updatedPlayer,
  }) async {
    try {
      final scoreRef = _ballScoreCollection.doc();
      await _firestore.runTransaction(maxAttempts: 1, (transaction) async {
        final overCount =
            double.parse("${score.over_number - 1}.${score.ball_number}");

        // update matchTeamScore and squad(if needed)
        await _matchService.updateTeamScoreAndSquadViaTransaction(transaction,
            matchId: matchId,
            battingTeamId: battingTeamId,
            totalRun: totalRuns,
            over: overCount,
            bowlingTeamId: bowlingTeamId,
            wicket: totalWicketTaken,
            runs: totalBowlingTeamRuns,
            updatedMatchPlayer: updatedPlayer != null ? [updatedPlayer] : null);
        // update innings score detail
        _inningsService.updateInningScoreDetailViaTransaction(transaction,
            battingTeamInningId: battingTeamInningId,
            over: overCount,
            totalRun: totalRuns,
            bowlingTeamInningId: bowlingTeamInningId,
            wicketCount: totalWicketTaken,
            runs: totalBowlingTeamRuns);

        // add ball
        transaction.set(
          scoreRef,
          score.copyWith(id: scoreRef.id),
          SetOptions(merge: true),
        );
      }).catchError((error, stack) {
        throw AppError.fromError(error, stack);
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<BallScoreChange>> getBallScoresStreamByInningIds(
      List<String> inningIds) {
    return _ballScoreCollection
        .where(FireStoreConst.inningId, whereIn: inningIds)
        .snapshots()
        .map((event) => event.docChanges
            .map((score) => BallScoreChange(score.type, score.doc.data()!))
            .toList())
        .handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Stream<List<BallScoreModel>> getCurrentUserRelatedBalls() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }

    return _ballScoreCollection
        .where(Filter.or(
            Filter(FireStoreConst.bowlerId, isEqualTo: _currentUserId),
            Filter(FireStoreConst.batsmanId, isEqualTo: _currentUserId),
            Filter(FireStoreConst.wicketTakerId, isEqualTo: _currentUserId),
            Filter(FireStoreConst.playerOutId, isEqualTo: _currentUserId)))
        .snapshots()
        .map((event) => event.docs.map((score) => score.data()).toList())
        .handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<void> deleteBallAndUpdateTeamDetails({
    required String ballId,
    required String matchId,
    required String battingTeamId,
    required String battingTeamInningId,
    required int totalRuns,
    required String bowlingTeamId,
    required String bowlingTeamInningId,
    required int totalWicketTaken,
    double? overCount,
    int? totalBowlingTeamRuns,
    List<MatchPlayerRequest>? updatedPlayer,
  }) async {
    try {
      _firestore.runTransaction((transaction) async {
        // update matchTeamScore and squad(if needed)
        await _matchService.updateTeamScoreAndSquadViaTransaction(transaction,
            matchId: matchId,
            battingTeamId: battingTeamId,
            totalRun: totalRuns,
            over: overCount,
            bowlingTeamId: bowlingTeamId,
            wicket: totalWicketTaken,
            runs: totalBowlingTeamRuns,
            updatedMatchPlayer: updatedPlayer);

        // update innings score detail
        _inningsService.updateInningScoreDetailViaTransaction(transaction,
            battingTeamInningId: battingTeamInningId,
            over: overCount,
            totalRun: totalRuns,
            bowlingTeamInningId: bowlingTeamInningId,
            wicketCount: totalWicketTaken,
            runs: totalBowlingTeamRuns);

        // delete ball
        final docRef = _ballScoreCollection.doc(ballId);
        transaction.delete(docRef);
      });
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}

class BallScoreChange {
  final DocumentChangeType type;
  final BallScoreModel ballScore;

  BallScoreChange(this.type, this.ballScore);
}
