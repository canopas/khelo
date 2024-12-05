import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/match_event/match_event_model.dart';
import '../../errors/app_error.dart';
import '../../utils/constant/firestore_constant.dart';

final matchEventServiceProvider = Provider(
  (ref) => MatchEventService(FirebaseFirestore.instance),
);

class MatchEventService {
  final FirebaseFirestore _firestore;

  MatchEventService(this._firestore);

  CollectionReference<MatchEventModel> get _matchEventCollection =>
      _firestore.collection(FireStoreConst.matchEventsCollection).withConverter(
            fromFirestore: MatchEventModel.fromFireStore,
            toFirestore: (MatchEventModel event, _) => event.toJson(),
          );

  String get generateMatchEventId => _matchEventCollection.doc().id;

  Stream<List<MatchEventModel>> streamEventsByMatches(String matchId) {
    return _matchEventCollection
        .where(FireStoreConst.matchId, isEqualTo: matchId)
        .snapshots()
        .asyncMap((snapshot) async {
      return snapshot.docs.map((mainDoc) => mainDoc.data()).toList();
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<String> updateMatchEvent(MatchEventModel event) async {
    try {
      final eventRef = _matchEventCollection.doc(event.id);
      await eventRef.set(
        event,
        SetOptions(merge: true),
      );
      return eventRef.id;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> deleteMatchEvent(String eventId) async {
    try {
      await _matchEventCollection.doc(eventId).delete();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
