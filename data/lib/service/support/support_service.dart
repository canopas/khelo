import 'package:cloud_firestore/cloud_firestore.dart';
import '../../api/support/support_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../errors/app_error.dart';
import '../../utils/constant/firestore_constant.dart';

final supportServiceProvider = Provider(
  (ref) => SupportService(FirebaseFirestore.instance),
);

class SupportService {
  final FirebaseFirestore _firestore;

  SupportService(this._firestore);

  CollectionReference<AddSupportCaseRequest> get _supportCollection =>
      _firestore.collection(FireStoreConst.supportCollection).withConverter(
            fromFirestore: AddSupportCaseRequest.fromFireStore,
            toFirestore: (AddSupportCaseRequest support, _) => support.toJson(),
          );

  String get generateSupportId => _supportCollection.doc().id;

  Future<String> addSupportCase(AddSupportCaseRequest supportCase) async {
    try {
      final supportCaseRef = _supportCollection.doc(supportCase.id);
      await supportCaseRef.set(
        supportCase.copyWith(id: supportCaseRef.id),
        SetOptions(merge: true),
      );
      return supportCaseRef.id;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
