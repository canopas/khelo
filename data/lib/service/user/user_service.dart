import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> deleteUser() async {
    await _firestore.collection(_collectionName).doc(_currentUser?.id).delete();
    _currentUserJsonController.state = null;
  }

  Future<void> updateUser(UserModel user) async {
    DocumentReference userRef =
        _firestore.collection(_collectionName).doc(user.id);

    await userRef.set(user.toJson(), SetOptions(merge: true));

    _currentUserJsonController.state = user.toJsonString();
  }

  Future<void> getUser(String id) async {
    DocumentReference userRef = _firestore.collection(_collectionName).doc(id);
    DocumentSnapshot snapshot = await userRef.get();
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
    var userModel = UserModel.fromJson(userData);
    _currentUserJsonController.state = userModel.toJsonString();
  }

  Future<UserModel> getUserById(String id) async {
    DocumentReference userRef = _firestore.collection(_collectionName).doc(id);
    DocumentSnapshot snapshot = await userRef.get();
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
    var userModel = UserModel.fromJson(userData);
    return userModel;
  }

  Future<List<UserModel>> searchUser(String searchKey) async {
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
  }

  void signOutUser() {
    _currentUserJsonController.state = null;
  }
}
