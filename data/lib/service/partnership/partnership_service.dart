import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/partnership/partnership_model.dart';
import '../../errors/app_error.dart';
import '../../utils/constant/firestore_constant.dart';

final partnershipServiceProvider = Provider(
  (ref) => PartnershipService(FirebaseFirestore.instance),
);

class PartnershipService {
  final FirebaseFirestore _firestore;

  PartnershipService(this._firestore);

  CollectionReference<PartnershipModel> get _partnershipCollection => _firestore
      .collection(FireStoreConst.partnershipsCollection)
      .withConverter(
        fromFirestore: PartnershipModel.fromFireStore,
        toFirestore: (PartnershipModel partnership, _) => partnership.toJson(),
      );

  String get generatePartnershipId => _partnershipCollection.doc().id;

  Future<String> updatePartnership(PartnershipModel partnership) async {
    try {
      final partnershipRef = _partnershipCollection.doc(partnership.id);
      await partnershipRef.set(
        partnership.copyWith(id: partnershipRef.id),
        SetOptions(merge: true),
      );
      return partnershipRef.id;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<List<PartnershipModel>> streamPartnershipByMatches(String matchId) {
    return _partnershipCollection
        .where(FireStoreConst.matchId, isEqualTo: matchId)
        .snapshots()
        .asyncMap((snapshot) async {
      return snapshot.docs.map((mainDoc) => mainDoc.data()).toList();
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<void> deletePartnership(String partnershipId) async {
    try {
      await _partnershipCollection.doc(partnershipId).delete();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
