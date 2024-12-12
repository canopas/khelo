import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../api/network/client.dart';
import '../../api/user/user_models.dart';
import '../../errors/app_error.dart';
import '../../extensions/list_extensions.dart';
import '../../storage/app_preferences.dart';
import '../../utils/constant/firestore_constant.dart';
import '../../utils/dummy_deactivated_account.dart';
import '../device/device_service.dart';
import 'user_endpoint.dart';

final userServiceProvider = Provider((ref) {
  final service = UserService(
    ref.read(currentUserPod),
    FirebaseFirestore.instance,
    ref.read(httpProvider),
    ref.read(deviceServiceProvider),
  );

  ref.listen(currentUserPod, (_, next) => service._currentUser = next);
  return service;
});

class UserService {
  UserModel? _currentUser;

  final FirebaseFirestore firestore;
  final http.Client client;
  final DeviceService deviceService;

  UserService(
    this._currentUser,
    this.firestore,
    this.client,
    this.deviceService,
  );

  CollectionReference<UserModel> get _userRef => firestore
      .collection(FireStoreConst.usersCollection)
      .withConverter<UserModel>(
        fromFirestore: UserModel.fromFireStore,
        toFirestore: (user, options) => user.toJson(),
      );

  CollectionReference _sessionRef(String userId) => _userRef
      .doc(userId)
      .collection(FireStoreConst.userSessionCollection)
      .withConverter<ApiSession>(
        fromFirestore: ApiSession.fromFireStore,
        toFirestore: (session, _) => session.toJson(),
      );

  CollectionReference<UserStat> _userStatsRef(String userId) => _userRef
      .doc(userId)
      .collection(FireStoreConst.userStatCollection)
      .withConverter(
        fromFirestore: UserStat.fromFireStore,
        toFirestore: (userStat, _) => userStat.toJson(),
      );

  Future<List<UserModel>> migrate() async {
    final users = await _userRef.get();
    return users.docs.map((e) => e.data()).toList();
  }

  Future<void> clearSession({
    required String uid,
    required String sessionId,
  }) async {
    await _sessionRef(uid).doc(sessionId).delete();
  }

  Future<ApiSession> _createSession(String userId) async {
    final sessionDocRef = _sessionRef(userId).doc();
    final session = ApiSession(
      id: sessionDocRef.id,
      user_id: userId,
      device_type: deviceService.currentPlatformType(),
      device_id: deviceService.deviceId,
      device_name: await deviceService.deviceName,
      app_version: await deviceService.appVersion,
      os_version: await deviceService.osVersion,
      created_at: DateTime.now(),
    );

    await sessionDocRef.set(session);
    return session;
  }

  Future<(UserModel, ApiSession)> upsertUser({
    required String uid,
    required String phone,
  }) async {
    var user = await getUser(uid);
    user ??= await _createUser(uid, phone);
    final session = await _createSession(uid);
    return (user, session);
  }

  Future<UserModel?> getUser(String id) async {
    try {
      final snapshot = await _userRef.doc(id).get();
      return (snapshot.exists) ? snapshot.data() : null;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<UserModel?> getUserByPhoneNumber(String number) async {
    try {
      final snapshot =
          await _userRef.where(FireStoreConst.phone, isEqualTo: number).get();
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
      if (ids.isEmpty) return [];
      for (final tenIds in ids.chunked(10)) {
        final snapshot =
            await _userRef.where(FireStoreConst.id, whereIn: tenIds).get();

        users.addAll(snapshot.docs.map((user) => user.data()).toList());

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
    return _userRef.doc(id).snapshots().map((snapshot) {
      final userModel = snapshot.data();
      if (userModel == null) {
        return deActiveDummyUserAccount(id);
      }
      return userModel;
    }).handleError((error, stack) {
      throw AppError.fromError(error, stack);
    });
  }

  Stream<List<UserStat>?> streamUserStats(String userId) {
    return _userStatsRef(userId).snapshots().map((snapshot) {
      return snapshot.docs.isEmpty
          ? null
          : snapshot.docs.map((e) => e.data()).toList();
    }).handleError((error, stack) => throw AppError.fromError(error, stack));
  }

  Future<UserStat?> getUserStats(String userId, UserStatType type) async {
    try {
      final snapshot = await _userStatsRef(userId)
          .where(FireStoreConst.type, isEqualTo: type.name)
          .limit(1)
          .get();
      return snapshot.docs.isEmpty ? null : snapshot.docs.first.data();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<UserModel> createNewUser(
    String phoneNumber,
    String displayName,
  ) async {
    try {
      final response = await client.req(
        CreateUserEndpoint(
          name: displayName,
          phone: phoneNumber,
        ),
      );

      return UserModel.fromJson(response.data);
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      final userRef = _userRef.doc(user.id);
      await userRef.set(user, SetOptions(merge: true));
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> updateUserStats(String userId, UserStat stats) async {
    try {
      final userStatsRef = _userStatsRef(userId);

      await userStatsRef
          .doc(stats.type?.name)
          .set(stats, SetOptions(merge: true));
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<UserModel> _createUser(String userId, String phone) async {
    final user = UserModel(
      id: userId,
      phone: phone,
      created_at: DateTime.now(),
    );
    await _userRef.doc(userId).set(user);
    return user;
  }

  Future<void> deleteUser() async {
    try {
      await _userRef.doc(_currentUser?.id).delete();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<List<UserModel>> searchUser(String searchKey) async {
    try {
      final snapshot = await _userRef
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

  Future<void> registerDevice(
    String sessionId, {
    required String userId,
    required String deviceToken,
  }) async {
    await _sessionRef(userId).doc(sessionId).update({
      FireStoreConst.deviceFcmToken: deviceToken,
    });
  }

  Future<void> updateUserNotificationSettings(
    String id,
    bool notifications,
  ) async {
    await _userRef
        .doc(id)
        .update({FireStoreConst.notifications: notifications});
  }
}
