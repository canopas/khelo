import 'package:data/service/user/user_service.dart';
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
    required String phoneNumber,
    Function(String, int?)? onCodeSent,
    Function(PhoneAuthCredential, UserCredential)? onVerificationCompleted,
    Function(FirebaseAuthException)? onVerificationFailed,
    Function(String)? onCodeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        final userCredential =
            await _auth.signInWithCredential(phoneAuthCredential);
        _onVerificationSuccess(userCredential);
        onVerificationCompleted != null
            ? onVerificationCompleted(phoneAuthCredential, userCredential)
            : null;
      },
      verificationFailed: (FirebaseAuthException e) =>
          onVerificationFailed != null ? onVerificationFailed(e) : null,
      codeSent: (String verificationId, int? resendToken) =>
          onCodeSent != null ? onCodeSent(verificationId, resendToken) : null,
      codeAutoRetrievalTimeout: (verificationId) =>
          onCodeAutoRetrievalTimeout != null
              ? onCodeAutoRetrievalTimeout(verificationId)
              : null,
    );
  }

  Future<void> verifyOTP(String verificationId, String otp) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    await _onVerificationSuccess(userCredential);
  }

  Future<void> _onVerificationSuccess(UserCredential credential) async {
    if (credential.additionalUserInfo?.isNewUser ?? false) {
      if (_auth.currentUser == null) {
        return;
      }
      UserModel user = UserModel(
          id: _auth.currentUser!.uid,
          phone: _auth.currentUser!.phoneNumber,
          created_at: DateTime.now());
      await _userService.updateUser(user);
    } else {
      final uid = credential.user?.uid;
      if (uid == null) {
        return;
      }
      await _userService.getUser(uid);
    }
  }

  Future<void> reauthenticateAndDeleteAccount() async {
    final providerData = _auth.currentUser?.providerData.first;
    if (PhoneAuthProvider().providerId == providerData?.providerId) {
      await _auth.currentUser?.reauthenticateWithProvider(PhoneAuthProvider());
      deleteAccount();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _userService.signOutUser();
  }

  Future<void> deleteAccount() async {
    await _auth.currentUser?.delete();
    await _userService.deleteUser();
  }
}
