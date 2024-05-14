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

  BallScoreService(this._firestore, this._matchService, this._inningsService,
      this._currentUserId);

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
      DocumentReference scoreRef =
          _firestore.collection(FireStoreConst.ballScoresCollection).doc();
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
          score.copyWith(id: scoreRef.id).toJson(),
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
    StreamController<List<BallScoreChange>> controller =
        StreamController<List<BallScoreChange>>();

    _firestore
        .collection(FireStoreConst.ballScoresCollection)
        .where(FireStoreConst.inningId, whereIn: inningIds)
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      try {
        List<BallScoreChange> changes = [];
        for (var doc in snapshot.docChanges) {
          final data = doc.doc.data();
          if (data != null) {
            changes
                .add(BallScoreChange(doc.type, BallScoreModel.fromJson(data)));
          }
        }
        controller.add(changes);
      } catch (error, stack) {
        controller.addError(AppError.fromError(error, stack));
        controller.close();
      }
    }, onError: (error, stack) {
      controller.addError(AppError.fromError(error, stack));
      controller.close();
    });

    return controller.stream;
  }

  Stream<List<BallScoreModel>> getCurrentUserRelatedBalls() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }
    StreamController<List<BallScoreModel>> controller =
        StreamController<List<BallScoreModel>>();
    _firestore
        .collection(FireStoreConst.ballScoresCollection)
        .where(Filter.or(
            Filter(FireStoreConst.bowlerId, isEqualTo: _currentUserId),
            Filter(FireStoreConst.batsmanId, isEqualTo: _currentUserId),
            Filter(FireStoreConst.wicketTakerId, isEqualTo: _currentUserId),
            Filter(FireStoreConst.playerOutId, isEqualTo: _currentUserId)))
        .snapshots()
        .listen((snapshot) {
      try {
        final ballList = snapshot.docs.map((doc) {
          final data = doc.data();
          return BallScoreModel.fromJson(data).copyWith(id: doc.id);
        }).toList();

        controller.add(ballList);
      } catch (error, stack) {
        controller.addError(AppError.fromError(error, stack));
        controller.close();
      }
    }, onError: (error, stack) {
      controller.addError(AppError.fromError(error, stack));
      controller.close();
    });

    return controller.stream;
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
        final docRef = _firestore
            .collection(FireStoreConst.ballScoresCollection)
            .doc(ballId);
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