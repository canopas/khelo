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
  final CollectionReference<InningModel> _inningCollection;

  InningsService(this._firestore)
      : _inningCollection = _firestore
            .collection(FireStoreConst.inningsCollection)
            .withConverter(
                fromFirestore: InningModel.fromFireStore,
                toFirestore: (InningModel inning, _) => inning.toJson());

  Future<void> createInnings({
    required String matchId,
    required String teamId,
    required InningStatus firstInningStatus,
    required String opponentTeamId,
    required InningStatus secondInningStatus,
  }) async {
    try {
      WriteBatch batch = _firestore.batch();
      final firstInningRef = _inningCollection.doc();
      final secondInningRef = _inningCollection.doc();

      final firstInning = InningModel(
        id: firstInningRef.id,
        match_id: matchId,
        team_id: teamId,
        innings_status: firstInningStatus,
        total_runs: 0,
        overs: 0,
        total_wickets: 0,
      );

      final secondInning = InningModel(
        id: secondInningRef.id,
        match_id: matchId,
        team_id: opponentTeamId,
        innings_status: secondInningStatus,
        total_runs: 0,
        overs: 0,
        total_wickets: 0,
      );

      batch.set(firstInningRef, firstInning, SetOptions(merge: true));
      batch.set(secondInningRef, secondInning , SetOptions(merge: true));

      await batch.commit();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<InningModel>> getInningsStreamByMatchId({
    required String matchId,
  }) {
    return _inningCollection
        .where(FireStoreConst.matchId, isEqualTo: matchId)
        .snapshots()
        .map((event) => event.docs.map((inning) => inning.data()).toList())
        .handleError((error, stack) => throw AppError.fromError(error, stack));
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
      final batInningRef =
          _inningCollection.doc(battingTeamInningId);

      final bowlInningRef =
          _inningCollection.doc(bowlingTeamInningId);

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
      final batInningRef = _inningCollection.doc(inningId);
      await batInningRef.update({FireStoreConst.inningsStatus: status.value});
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
