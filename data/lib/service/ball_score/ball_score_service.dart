import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/ball_score/ball_score_model.dart';
import '../../api/match/match_model.dart';
import '../../errors/app_error.dart';
import '../../extensions/double_extensions.dart';
import '../../extensions/list_extensions.dart';
import '../../utils/constant/firestore_constant.dart';
import '../innings/inning_service.dart';
import '../match/match_service.dart';

final ballScoreServiceProvider = Provider((ref) {
  final service = BallScoreService(
    FirebaseFirestore.instance,
    ref.read(matchServiceProvider),
    ref.read(inningServiceProvider),
  );

  return service;
});

class BallScoreService {
  final FirebaseFirestore _firestore;
  final MatchService _matchService;
  final InningsService _inningsService;

  BallScoreService(
    this._firestore,
    this._matchService,
    this._inningsService,
  );

  CollectionReference<BallScoreModel> get _ballScoreCollection =>
      _firestore.collection(FireStoreConst.ballScoresCollection).withConverter(
            fromFirestore: BallScoreModel.fromFireStore,
            toFirestore: (BallScoreModel score, _) => score.toJson(),
          );

  String get generateBallScoreId => _ballScoreCollection.doc().id;

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
    double otherInningOver = 0,
    int otherTotalRuns = 0,
    int otherTotalWicketTaken = 0,
    int otherTotalBowlingTeamRuns = 0,
    MatchPlayer? updatedPlayer,
  }) async {
    try {
      final scoreRef = _ballScoreCollection.doc();
      await _firestore.runTransaction(maxAttempts: 1, (transaction) async {
        final overCount = score.formattedOver;

        // update matchTeamScore and squad(if needed)
        await _matchService.updateTeamScoreAndSquadViaTransaction(
          transaction,
          matchId: matchId,
          battingTeamId: battingTeamId,
          totalRun: otherTotalRuns + totalRuns,
          over: overCount.add(otherInningOver.toBalls()),
          bowlingTeamId: bowlingTeamId,
          wicket: otherTotalWicketTaken + totalWicketTaken,
          runs: totalBowlingTeamRuns != null
              ? otherTotalBowlingTeamRuns + totalBowlingTeamRuns
              : null,
          updatedMatchPlayer: updatedPlayer != null ? [updatedPlayer] : null,
        );
        // update innings score detail
        _inningsService.updateInningScoreDetailViaTransaction(
          transaction,
          battingTeamInningId: battingTeamInningId,
          over: overCount,
          totalRun: totalRuns,
          bowlingTeamInningId: bowlingTeamInningId,
          wicketCount: totalWicketTaken,
          runs: totalBowlingTeamRuns,
        );

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

  Future<List<BallScoreModel>> getBallScoresByMatchIds(
    List<String> matchIds,
  ) async {
    try {
      if (matchIds.isEmpty) return [];
      final List<BallScoreModel> data = [];
      for (var ids in matchIds.chunked(30)) {
        final ballScoreRef = await _ballScoreCollection
            .where(FireStoreConst.matchId, whereIn: ids)
            .get();
        data.addAll(ballScoreRef.docs.map((e) => e.data()));
      }

      return data;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<BallScoreChange>> streamBallScoresByInningIds(
    List<String> inningIds,
  ) {
    if (inningIds.isEmpty) return const Stream.empty();
    return _ballScoreCollection
        .where(FireStoreConst.inningId, whereIn: inningIds)
        .snapshots()
        .map(
          (event) => event.docChanges
              .map((score) => BallScoreChange(score.type, score.doc.data()!))
              .toList(),
        )
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
    double otherInningOver = 0,
    int otherTotalRuns = 0,
    int otherTotalWicketTaken = 0,
    int otherTotalBowlingTeamRuns = 0,
    List<MatchPlayer>? updatedPlayer,
  }) async {
    try {
      _firestore.runTransaction((transaction) async {
        // update matchTeamScore and squad(if needed)
        await _matchService.updateTeamScoreAndSquadViaTransaction(
          transaction,
          matchId: matchId,
          battingTeamId: battingTeamId,
          totalRun: otherTotalRuns + totalRuns,
          over: overCount?.add(otherInningOver.toBalls()),
          bowlingTeamId: bowlingTeamId,
          wicket: otherTotalWicketTaken + totalWicketTaken,
          runs: totalBowlingTeamRuns != null
              ? otherTotalBowlingTeamRuns + totalBowlingTeamRuns
              : null,
          updatedMatchPlayer: updatedPlayer,
        );

        // update innings score detail
        _inningsService.updateInningScoreDetailViaTransaction(
          transaction,
          battingTeamInningId: battingTeamInningId,
          over: overCount,
          totalRun: totalRuns,
          bowlingTeamInningId: bowlingTeamInningId,
          wicketCount: totalWicketTaken,
          runs: totalBowlingTeamRuns,
        );

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
