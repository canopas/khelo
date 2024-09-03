import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../api/innings/inning_model.dart';
import '../../errors/app_error.dart';
import '../../utils/constant/firestore_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inningServiceProvider = Provider((ref) {
  final service = InningsService(FirebaseFirestore.instance);
  return service;
});

class InningsService {
  final FirebaseFirestore _firestore;

  InningsService(this._firestore);

  CollectionReference<InningModel> get _inningCollection =>
      _firestore.collection(FireStoreConst.inningsCollection).withConverter(
            fromFirestore: InningModel.fromFireStore,
            toFirestore: (InningModel inning, _) => inning.toJson(),
          );

  String get generateInningId => _inningCollection.doc().id;

  Future<void> createInnings({
    required List<InningModel> innings,
  }) async {
    try {
      final WriteBatch batch = _firestore.batch();
      for (final inning in innings) {
        final inningRef = _inningCollection.doc(inning.id);
        batch.set(inningRef, inning, SetOptions(merge: true));
      }
      await batch.commit();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<InningModel>> streamInningsByMatchId({
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
      final batInningRef = _inningCollection.doc(battingTeamInningId);
      final bowlInningRef = _inningCollection.doc(bowlingTeamInningId);

      final Map<String, dynamic> battingUpdates = {
        FireStoreConst.totalRuns: totalRun,
      };
      if (over != null) battingUpdates.addAll({FireStoreConst.overs: over});

      transaction.update(batInningRef, battingUpdates);

      final Map<String, dynamic> bowlingUpdates = {
        FireStoreConst.totalWickets: wicketCount,
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

  Future updateInningsStatuses(Map<String, InningStatus> innings) async {
    try {
      final WriteBatch batch = _firestore.batch();

      for (final inning in innings.entries) {
        final inningRef = _inningCollection.doc(inning.key);
        batch.update(inningRef, {
          FireStoreConst.inningsStatus: inning.value.value,
        });
      }

      await batch.commit();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
