import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/extensions/list_extensions.dart';
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
  final String _collectionName = 'users';

  UserService(
      this._currentUser, this._currentUserJsonController, this._firestore);

  Future<void> getUser(String id) async {
    try {
      DocumentReference userRef =
          _firestore.collection(_collectionName).doc(id);
      DocumentSnapshot snapshot = await userRef.get();
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      var userModel = UserModel.fromJson(userData);
      _currentUserJsonController.state = userModel.toJsonString();
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      DocumentReference userRef =
          _firestore.collection(_collectionName).doc(user.id);

      await userRef.set(user.toJson(), SetOptions(merge: true));

      _currentUserJsonController.state = user.toJsonString();
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<void> deleteUser() async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(_currentUser?.id)
          .delete();
      _currentUserJsonController.state = null;
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentReference userRef =
          _firestore.collection(_collectionName).doc(id);
      DocumentSnapshot snapshot = await userRef.get();
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      var userModel = UserModel.fromJson(userData);
      return userModel;
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<List<UserModel>> getUsersByIds(List<String> ids) async {
    List<UserModel> users = [];
    try {
      for (final tenIds in ids.chunked(10)) {
        QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection(_collectionName)
            .where('id', whereIn: tenIds)
            .get();

        users.addAll(snapshot.docs.map((doc) {
          final data = doc.data();
          return UserModel.fromJson(data).copyWith(id: doc.id);
        }).toList());
      }

      return users;
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  Future<List<UserModel>> searchUser(String searchKey) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(_collectionName)
          .where('name_lowercase',
              isGreaterThanOrEqualTo: searchKey.toLowerCase())
          .where('name_lowercase', isLessThan: '${searchKey.toLowerCase()}z')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return UserModel.fromJson(data).copyWith(id: doc.id);
      }).toList();
    } catch (error) {
      throw AppError.fromError(error);
    }
  }

  void signOutUser() {
    _currentUserJsonController.state = null;
  }
}
