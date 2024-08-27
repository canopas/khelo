import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../../errors/app_error.dart';
import '../../extensions/string_extensions.dart';
import '../../storage/app_preferences.dart';
import '../user/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/user/user_models.dart';

final authServiceProvider = Provider((ref) {
  return AuthService(
    FirebaseAuth.instance,
    ref.read(userServiceProvider),
    ref.read(currentUserJsonPod.notifier),
    ref.read(currentUserSessionJsonPod.notifier),
  );
});

class AuthService {
  final FirebaseAuth _auth;
  final UserService _userService;

  final StateController<String?> _currantUserNotifier;
  final StateController<String?> _userSessionNotifier;

  AuthService(
    this._auth,
    this._userService,
    this._currantUserNotifier,
    this._userSessionNotifier,
  ) {
    _auth.authStateChanges().listen(
      (user) {
        if (user == null) {
          _currantUserNotifier.state = null;
          _userSessionNotifier.state = null;
        }
      },
    );
  }

  Stream<User?> get user => _auth.authStateChanges();

  Future<void> verifyPhoneNumber({
    required String countryCode,
    required String phoneNumber,
    Function(String, int?)? onCodeSent,
    Function(PhoneAuthCredential, UserCredential)? onVerificationCompleted,
    Function(AppError)? onVerificationFailed,
    Function(String)? onCodeAutoRetrievalTimeout,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          final userCredential =
              await _auth.signInWithCredential(phoneAuthCredential);
          _onVerificationSuccess(countryCode, phoneNumber, userCredential);
          onVerificationCompleted != null
              ? onVerificationCompleted(phoneAuthCredential, userCredential)
              : null;
        },
        verificationFailed: (FirebaseAuthException e) =>
            onVerificationFailed != null
                ? onVerificationFailed(AppError.fromError(e, e.stackTrace))
                : null,
        codeSent: (String verificationId, int? resendToken) =>
            onCodeSent != null ? onCodeSent(verificationId, resendToken) : null,
        codeAutoRetrievalTimeout: (verificationId) =>
            onCodeAutoRetrievalTimeout != null
                ? onCodeAutoRetrievalTimeout(verificationId)
                : null,
      );
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> verifyOTP(
    String countryCode,
    String phoneNumber,
    String verificationId,
    String otp,
  ) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      await _onVerificationSuccess(countryCode, phoneNumber, userCredential);
      final deviceToken = await FirebaseMessaging.instance.getToken();
      if (deviceToken == null) {
        debugPrint("AuthService: FCMToken is null");
        return;
      }
      await registerDevice(deviceToken);
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> _onVerificationSuccess(
    String countryCode,
    String phoneNumber,
    UserCredential credential,
  ) async {
    try {
      if (credential.user == null) {
        _currantUserNotifier.state = null;
        _userSessionNotifier.state = null;
        return;
      }
      final phone = "$countryCode ${phoneNumber.caseAndSpaceInsensitive}";

      final (user, session) = await _userService.upsertUser(
        uid: credential.user!.uid,
        phone: phone,
      );

      _currantUserNotifier.state = user.toJsonString();
      _userSessionNotifier.state = session.toJsonString();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> reAuthenticateAndDeleteAccount() async {
    try {
      final providerData = _auth.currentUser?.providerData.first;
      if (PhoneAuthProvider().providerId == providerData?.providerId) {
        await _auth.currentUser
            ?.reauthenticateWithProvider(PhoneAuthProvider());
        deleteAccount();
      }
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> clearSession() async {
    final session = ApiSession.fromJsonString(_userSessionNotifier.state!);
    final userId = _auth.currentUser?.uid;

    if (session == null || userId == null) return;
    await _userService.clearSession(uid: userId, sessionId: session.id);
    _userSessionNotifier.state = null;
  }

  Future<void> registerDevice(String fcmToken) async {
    if (_userSessionNotifier.state == null) return;

    try {
      final session = ApiSession.fromJsonString(_userSessionNotifier.state!);
      if (session == null) return;

      if (session.device_fcm_token == fcmToken) return;

      await _userService.registerDevice(
        session.id,
        userId: session.user_id,
        deviceToken: fcmToken,
      );
      debugPrint('AuthService: registerDevice succeed with token $fcmToken');
    } catch (error) {
      debugPrint('AuthService: registerDevice error $error');
    }
  }

  Future<void> signOut() async {
    try {
      await clearSession();
      await _auth.signOut();
      _currantUserNotifier.state = null;
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _userService.deleteUser();
      _currantUserNotifier.state = null;
      await _auth.currentUser?.delete();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
