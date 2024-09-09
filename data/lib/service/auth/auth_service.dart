import '../../errors/app_error.dart';
import '../../extensions/string_extensions.dart';
import '../user/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/user/user_models.dart';

final authServiceProvider = Provider((ref) {
  return AuthService(FirebaseAuth.instance, ref.read(userServiceProvider));
});

class AuthService {
  final FirebaseAuth _auth;
  final UserService _userService;

  AuthService(this._auth, this._userService);

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
      if (credential.additionalUserInfo?.isNewUser ?? false) {
        if (_auth.currentUser == null) {
          return;
        }
        final phone = "$countryCode ${phoneNumber.caseAndSpaceInsensitive}";
        final UserModel user = UserModel(
          id: _auth.currentUser!.uid,
          phone: phone,
          created_at2: DateTime.now(),
        );
        await _userService.updateUser(user);
      } else {
        final uid = credential.user?.uid;
        if (uid == null) {
          return;
        }
        await _userService.getUser(uid);
      }
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

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _userService.signOutUser();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _userService.deleteUser();
      await _auth.currentUser?.delete();
    } catch (error, stack) {
      throw AppError.fromError(error, stack);
    }
  }
}
