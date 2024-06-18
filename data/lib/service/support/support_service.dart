import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/support/support_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../errors/app_error.dart';
import '../../utils/constant/firestore_constant.dart';

final supportServiceProvider = Provider(
  (ref) => SupportService(
    FirebaseFirestore.instance,
  ),
);

class SupportService {
  final FirebaseFirestore _firestore;

  SupportService(this._firestore);

  Future<String> addSupportCase(AddSupportCaseRequest supportCase) async {
    try {
      DocumentReference supportCaseRef = _firestore
          .collection(FireStoreConst.supportCollection)
          .doc(supportCase.id);
      WriteBatch batch = _firestore.batch();

      batch.set(supportCaseRef, supportCase.toJson(), SetOptions(merge: true));
      String newSupportCaseId = supportCaseRef.id;

      if (supportCase.id == null) {
        batch.update(supportCaseRef, {FireStoreConst.id: newSupportCaseId});
      }
      await batch.commit();
      return newSupportCaseId;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
