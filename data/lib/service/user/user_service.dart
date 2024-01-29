import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/user/user_models.dart';
import '../../storage/app_preferences.dart';

final userServiceProvider = Provider((ref) {
  final service = UserService(ref.read(currentUserPod),
      ref.read(currentUserJsonPod.notifier), FirebaseFirestore.instance);

  ref.listen(currentUserPod, (_, next) => service.currentUser = next);
  return service;
});

class UserService {
  UserModel? currentUser;
  final StateController<String?> currentUserJsonController;
  final FirebaseFirestore _firestore;
  final String collectionName = 'users';

  UserService(
      this.currentUser, this.currentUserJsonController, this._firestore);

  Future<void> addUser(UserModel user) async {
    await _firestore.collection(collectionName).add(user.toJson());
  }

  Future<void> deleteUser() async {
    await _firestore.collection(collectionName).doc(currentUser?.id).delete();
    currentUserJsonController.state = null;
  }

  Future<void> updateUser(UserModel user) async {
    DocumentReference userRef =
        _firestore.collection(collectionName).doc(user.id);

    await userRef.set(user.toJson(), SetOptions(merge: true));

    currentUserJsonController.state = user.toJsonString();
  }

  Future<void> getUser(String id) async {
    DocumentReference userRef = _firestore.collection(collectionName).doc(id);
    DocumentSnapshot snapshot = await userRef.get();
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
    var tempUser = UserModel.fromJson(userData);
    currentUserJsonController.state = tempUser.toJsonString();
  }

  void signOutUser() {
    currentUserJsonController.state = null;
  }
}
