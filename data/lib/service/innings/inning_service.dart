import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/utils/constant/firestore_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inningServiceProvider = Provider((ref) {
  final service = InningsService(
    FirebaseFirestore.instance,
  );
  return service;
});

class InningsService {
  final FirebaseFirestore _firestore;

  InningsService(this._firestore);

  Future<void> createInnings({
    required String matchId,
    required String teamId,
    required InningStatus firstInningStatus,
    required String opponentTeamId,
    required InningStatus secondInningStatus,
  }) async {
    try {
      WriteBatch batch = _firestore.batch();

      DocumentReference firstInningRef =
          _firestore.collection(FireStoreConst.inningsCollection).doc();
      DocumentReference secondInningRef =
          _firestore.collection(FireStoreConst.inningsCollection).doc();

      final firstInning = InningModel(
        match_id: matchId,
        team_id: teamId,
        innings_status: firstInningStatus,
        total_runs: 0,
        overs: 0,
        total_wickets: 0,
      );

      final secondInning = InningModel(
        match_id: matchId,
        team_id: opponentTeamId,
        innings_status: secondInningStatus,
        total_runs: 0,
        overs: 0,
        total_wickets: 0,
      );

      // Set data for both innings using their respective references
      batch.set(
          firstInningRef,
          firstInning.copyWith(id: firstInningRef.id).toJson(),
          SetOptions(merge: true));
      batch.set(
          secondInningRef,
          secondInning.copyWith(id: secondInningRef.id).toJson(),
          SetOptions(merge: true));

      // Commit the batch
      await batch.commit();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<InningModel>> getInningsStreamByMatchId({
    required String matchId,
  }) {
    return _firestore
        .collection(FireStoreConst.inningsCollection)
        .where(FireStoreConst.matchId, isEqualTo: matchId)
        .snapshots()
        .asyncMap((snapshot) async {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return InningModel.fromJson(data).copyWith(id: doc.id);
      }).toList();
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<void> updateInningScoreDetail({
    required String battingTeamInningId,
    required double over,
    required int totalRun,
    required String bowlingTeamInningId,
    required int wicketCount,
    int? runs,
  }) async {
    try {
      DocumentReference batInningRef = _firestore
          .collection(FireStoreConst.inningsCollection)
          .doc(battingTeamInningId);

      DocumentReference bowlInningRef = _firestore
          .collection(FireStoreConst.inningsCollection)
          .doc(bowlingTeamInningId);
      WriteBatch batch = _firestore.batch();

      batch.update(batInningRef, {
        FireStoreConst.overs: over,
        FireStoreConst.totalRuns: totalRun,
      });
      if (runs != null) {
        batch.update(bowlInningRef, {
          FireStoreConst.totalWickets: wicketCount,
          FireStoreConst.totalRuns: runs
        });
      } else {
        batch.update(bowlInningRef, {FireStoreConst.totalWickets: wicketCount});
      }

      await batch.commit();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  void updateInningScoreDetailViaTransaction(
    Transaction transaction, {
    required String battingTeamInningId,
    double? over,
    required int totalRun,
    required String bowlingTeamInningId,
    required int wicketCount,
    int? runs,
  }) {
    try {
      DocumentReference batInningRef = _firestore
          .collection(FireStoreConst.inningsCollection)
          .doc(battingTeamInningId);

      DocumentReference bowlInningRef = _firestore
          .collection(FireStoreConst.inningsCollection)
          .doc(bowlingTeamInningId);

      Map<String, dynamic> battingUpdates = {
        FireStoreConst.totalRuns: totalRun,
      };
      if (over != null) battingUpdates.addAll({FireStoreConst.overs: over});

      transaction.update(batInningRef, battingUpdates);

      Map<String, dynamic> bowlingUpdates = {
        FireStoreConst.totalWickets: wicketCount
      };
      if (runs != null) bowlingUpdates.addAll({FireStoreConst.totalRuns: runs});

      transaction.update(bowlInningRef, bowlingUpdates);
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateInningStatus({
    required String inningId,
    required InningStatus status,
  }) async {
    try {
      DocumentReference batInningRef =
          _firestore.collection(FireStoreConst.inningsCollection).doc(inningId);
      await batInningRef.update({FireStoreConst.inningsStatus: status.value});
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
