import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider((ref) {
  return AuthService(FirebaseAuth.instance);
});

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get user => _auth.authStateChanges();

  // Future<void> signInWithPhoneNumber(
  //     String verificationId, String smsCode) async {
  //   AuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: verificationId,
  //     smsCode: smsCode,
  //   );
  //   await _auth.signInWithCredential(credential);
  //   // Update user details in Fire-store after successful sign-in
  //   // await _updateUserData();
  // }
  //
  // Future<void> signUpWithPhoneNumber(
  //     String verificationId, String smsCode, String additionalDetails) async {
  //   AuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: verificationId,
  //     smsCode: smsCode,
  //   );
  //   await _auth.signInWithCredential(credential);
  //   // Update user details in Fire-store after successful sign-up
  //   // await _updateUserData(additionalDetails);
  // }

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    Function(String, int?)? onCodeSent,
    Function(PhoneAuthCredential)? onVerificationCompleted,
    Function(FirebaseAuthException)? onVerificationFailed,
    Function(String)? onCodeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically sign in the user if verification is successful
        await _auth.signInWithCredential(credential);
        // whole process here and then call
        onVerificationCompleted != null
            ? onVerificationCompleted(credential)
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

  Future<void> signOut() async {
    await _auth.signOut();
    // make user null here
  }
}
