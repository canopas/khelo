import 'package:cloud_firestore/cloud_firestore.dart';
import '../../errors/app_error.dart';
import '../../extensions/list_extensions.dart';
import '../../utils/constant/firestore_constant.dart';
import '../../utils/dummy_deactivated_account.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/user/user_models.dart';
import '../../storage/app_preferences.dart';

final userServiceProvider = Provider((ref) {
  final service = UserService(
    ref.read(currentUserPod),
    ref.read(currentUserJsonPod.notifier),
    FirebaseFirestore.instance,
  );

  ref.listen(currentUserPod, (_, next) => service._currentUser = next);
  return service;
});

class UserService {
  UserModel? _currentUser;

  final FirebaseFirestore _firestore;
  final StateController<String?> _currentUserJsonController;

  UserService(
    this._currentUser,
    this._currentUserJsonController,
    this._firestore,
  );

  CollectionReference<UserModel> get _userCollection =>
      _firestore.collection(FireStoreConst.usersCollection).withConverter(
            fromFirestore: UserModel.fromFireStore,
            toFirestore: (UserModel user, _) => user.toJson(),
          );

  Future<void> getUser(String id) async {
    try {
      final snapshot = await _userCollection.doc(id).get();
      final userModel = snapshot.data();
      _currentUserJsonController.state = userModel?.toJsonString();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      final snapshot = await _userCollection.doc(id).get();
      final userModel = snapshot.data();
      if (userModel == null) {
        return deActiveDummyUserAccount(id);
      }
      return userModel;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<UserModel?> getUserByPhoneNumber(String number) async {
    try {
      final snapshot = await _userCollection
          .where(FireStoreConst.phone, isEqualTo: number)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data();
      } else {
        return null;
      }
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<UserModel>> getUsersByIds(List<String> ids) async {
    final List<UserModel> users = [];
    try {
      for (final tenIds in ids.chunked(10)) {
        final snapshot = await _userCollection
            .where(FireStoreConst.id, whereIn: tenIds)
            .get();

        users.addAll(
          snapshot.docs.map((doc) {
            return doc.data();
          }).toList(),
        );

        final deactivatedUserIds =
            tenIds.where((id) => !users.map((user) => user.id).contains(id));
        users.addAll(
          deactivatedUserIds.map(
            (id) => deActiveDummyUserAccount(id),
          ),
        );
      }

      return users;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Stream<UserModel> streamUserById(String id) {
    return _userCollection.doc(id).snapshots().map((snapshot) {
      final userModel = snapshot.data();
      if (userModel == null) {
        return deActiveDummyUserAccount(id);
      }
      return userModel;
    }).handleError((error, stack) {
      throw AppError.fromError(error, stack);
    });
  }

  Future<List<UserModel>> searchUser(String searchKey) async {
    try {
      final snapshot = await _userCollection
          .where(
            FireStoreConst.nameLowercase,
            isGreaterThanOrEqualTo: searchKey.toLowerCase(),
          )
          .where(
            FireStoreConst.nameLowercase,
            isLessThan: '${searchKey.toLowerCase()}z',
          )
          .get();

      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      final userRef = _userCollection.doc(user.id);

      await userRef.set(user, SetOptions(merge: true));

      _currentUserJsonController.state = user.toJsonString();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  void signOutUser() {
    _currentUserJsonController.state = null;
  }

  Future<void> deleteUser() async {
    try {
      await _userCollection.doc(_currentUser?.id).delete();
      _currentUserJsonController.state = null;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
