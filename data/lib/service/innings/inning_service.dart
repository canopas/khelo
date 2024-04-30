import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/innings/inning_model.dart';
import 'package:data/errors/app_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inningServiceProvider = Provider((ref) {
  final service = InningsService(
    FirebaseFirestore.instance,
  );
  return service;
});

class InningsService {
  final FirebaseFirestore _firestore;
  final String _collectionName = 'innings';

  InningsService(this._firestore);

  Future<String> updateInning(InningModel inning) async {
    try {
      DocumentReference inningRef =
          _firestore.collection(_collectionName).doc(inning.id);
      WriteBatch batch = _firestore.batch();

      batch.set(inningRef, inning.toJson(), SetOptions(merge: true));
      String newInningId = inningRef.id;

      if (inning.id == null) {
        batch.update(inningRef, {'id': newInningId});
      }

      await batch.commit();
      return newInningId;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<InningModel> getInningById(String id) async {
    try {
      DocumentReference inningRef =
          _firestore.collection(_collectionName).doc(id);
      DocumentSnapshot snapshot = await inningRef.get();
      Map<String, dynamic> inningData = snapshot.data() as Map<String, dynamic>;
      var inningModel = InningModel.fromJson(inningData);
      return inningModel;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<InningModel>> getInningsByMatchId(
      {required String matchId}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(_collectionName)
          .where('match_id', isEqualTo: matchId)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return InningModel.fromJson(data).copyWith(id: doc.id);
      }).toList();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<InningModel>> getInningsStreamByMatchId({
    required String matchId,
  }) {
    StreamController<List<InningModel>> controller =
        StreamController<List<InningModel>>();

    _firestore
        .collection(_collectionName)
        .where('match_id', isEqualTo: matchId)
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      try {
        List<InningModel> innings = snapshot.docs.map((doc) {
          final data = doc.data();
          return InningModel.fromJson(data).copyWith(id: doc.id);
        }).toList();
        controller.add(innings);
      } catch (error, stack) {
        controller.addError(AppError.fromError(error, stack));
      }
    }, onError: (error, stack) {
      controller.addError(AppError.fromError(error, stack));
    });

    return controller.stream;
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
      DocumentReference batInningRef =
          _firestore.collection(_collectionName).doc(battingTeamInningId);

      DocumentReference bowlInningRef =
          _firestore.collection(_collectionName).doc(bowlingTeamInningId);
      WriteBatch batch = _firestore.batch();

      batch.update(batInningRef, {'overs': over, 'total_runs': totalRun});
      if (runs != null) {
        batch.update(
            bowlInningRef, {'total_wickets': wicketCount, 'total_runs': runs});
      } else {
        batch.update(bowlInningRef, {'total_wickets': wicketCount});
      }

      await batch.commit();
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
          _firestore.collection(_collectionName).doc(inningId);
      await batInningRef.update({'innings_status': status.value});
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
