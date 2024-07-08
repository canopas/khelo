import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/extensions/list_extensions.dart';
import 'package:data/utils/constant/firestore_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/user/user_models.dart';
import '../../storage/app_preferences.dart';

final userServiceProvider = Provider((ref) {
  final service = UserService(ref.read(currentUserPod),
      ref.read(currentUserJsonPod.notifier), FirebaseFirestore.instance);

  ref.listen(currentUserPod, (_, next) => service._currentUser = next);
  return service;
});

class UserService {
  UserModel? _currentUser;
  final StateController<String?> _currentUserJsonController;
  final FirebaseFirestore _firestore;

  UserService(
      this._currentUser, this._currentUserJsonController, this._firestore);

  Future<void> getUser(String id) async {
    try {
      DocumentReference userRef =
          _firestore.collection(FireStoreConst.usersCollection).doc(id);
      DocumentSnapshot snapshot = await userRef.get();
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      var userModel = UserModel.fromJson(userData);
      _currentUserJsonController.state = userModel.toJsonString();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      DocumentReference userRef =
          _firestore.collection(FireStoreConst.usersCollection).doc(user.id);

      await userRef.set(user.toJson(), SetOptions(merge: true));

      _currentUserJsonController.state = user.toJsonString();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> deleteUser() async {
    try {
      await _firestore
          .collection(FireStoreConst.usersCollection)
          .doc(_currentUser?.id)
          .delete();
      _currentUserJsonController.state = null;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentReference userRef =
          _firestore.collection(FireStoreConst.usersCollection).doc(id);
      DocumentSnapshot snapshot = await userRef.get();
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      var userModel = UserModel.fromJson(userData);
      return userModel;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<UserModel>> getUsersByIds(List<String> ids) async {
    List<UserModel> users = [];
    try {
      for (final tenIds in ids.chunked(10)) {
        QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection(FireStoreConst.usersCollection)
            .where(FireStoreConst.id, whereIn: tenIds)
            .get();

        users.addAll(snapshot.docs.map((doc) {
          final data = doc.data();
          return UserModel.fromJson(data).copyWith(id: doc.id);
        }).toList());

        final deactivatedUserIds =
            tenIds.where((id) => !users.map((user) => user.id).contains(id));
        users.addAll(deactivatedUserIds.map(
          (id) => UserModel(
              id: id,
              name: "Deactivated User",
              isActive: false,
              created_at: DateTime(1950),
              location: "--"),
        ));
      }

      return users;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<UserModel>> searchUser(String searchKey) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(FireStoreConst.usersCollection)
          .where(FireStoreConst.nameLowercase,
              isGreaterThanOrEqualTo: searchKey.toLowerCase())
          .where(FireStoreConst.nameLowercase,
              isLessThan: '${searchKey.toLowerCase()}z')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return UserModel.fromJson(data).copyWith(id: doc.id);
      }).toList();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  void signOutUser() {
    _currentUserJsonController.state = null;
  }
}
