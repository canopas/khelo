import 'dart:async';
import 'package:data/api/user/user_models.dart';
import 'package:data/service/user/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_verification_view_model.freezed.dart';

final phoneVerificationStateProvider = StateNotifierProvider.autoDispose<
    PhoneVerificationViewNotifier, PhoneVerificationState>((ref) {
  return PhoneVerificationViewNotifier(
      FirebaseAuth.instance, ref.read(userServiceProvider));
});

class PhoneVerificationViewNotifier
    extends StateNotifier<PhoneVerificationState> {
  final FirebaseAuth firebaseAuth;
  final UserService userService;
  late Timer timer;
  late String phoneNumber;

  bool firstAutoVerificationComplete = false;

  PhoneVerificationViewNotifier(this.firebaseAuth, this.userService)
      : super(const PhoneVerificationState()) {
    updateResendCodeTimerDuration();
  }

  void updateResendCodeTimerDuration() {
    state = state.copyWith(activeResendDuration: const Duration(seconds: 30));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        activeResendDuration:
            Duration(seconds: state.activeResendDuration.inSeconds - 1),
      );
      if (state.activeResendDuration.inSeconds < 1) {
        timer.cancel();
      }
    });
  }

  void updateOTP(String otp) {
    state = state.copyWith(
      otp: otp,
      enableVerify: otp.length == 6,
    );

    if (!firstAutoVerificationComplete && otp.length == 6) {
      verifyOTP();
      firstAutoVerificationComplete = true;
    }
  }

  void updateVerificationIdAndPhone({
    required String verificationId,
    required String phone,
  }) {
    state = state.copyWith(verificationId: verificationId);
    phoneNumber = phone;
  }

  Future<void> resendCode({required String phone}) async {
    try {
      state = state.copyWith(error: null);
      updateResendCodeTimerDuration();
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (phoneAuthCredential) async {
          try {
            final userCredential =
                await firebaseAuth.signInWithCredential(phoneAuthCredential);
            onVerificationSuccess(userCredential);
          } catch (error) {
            state = state.copyWith(error: error);
          }
        },
        verificationFailed: (error) {
          state = state.copyWith(error: error);
        },
        codeSent: (verificationId, forceResendingToken) {
          state = state.copyWith(verificationId: verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      debugPrint("PhoneVerificationViewNotifier: error in resend otp -> $e");
    }
  }

  Future<void> onVerificationSuccess(UserCredential credential) async {
    try {
      if (credential.additionalUserInfo?.isNewUser ?? false) {
        UserModel user = UserModel(
            id: firebaseAuth.currentUser?.uid ?? "INVALID ID",
            phone: firebaseAuth.currentUser?.phoneNumber,
            created_at: DateTime.now());
        await userService.updateUser(user);
        state = state.copyWith(verifying: false, credential: credential);
      } else {
        // get user
        await userService.getUser(credential.user?.uid ?? "INVALID ID");
        state = state.copyWith(verifying: false, credential: credential);
      }
    } catch (e) {
      debugPrint(
          "PhoneVerificationViewNotifier: error in onVerificationSuccess -> $e");
    }
  }

  Future<void> verifyOTP() async {
    if (state.verificationId == null) return;

    state = state.copyWith(verifying: true, error: null);
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId!,
        smsCode: state.otp,
      );
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      onVerificationSuccess(userCredential);
    } catch (e) {
      state = state.copyWith(verifying: false, error: e);
      debugPrint("PhoneVerificationViewNotifier: error in verifyOTP -> $e");
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

@freezed
class PhoneVerificationState with _$PhoneVerificationState {
  const factory PhoneVerificationState({
    @Default(false) bool verifying,
    @Default(false) bool enableVerify,
    @Default(null) UserCredential? credential,
    String? verificationId,
    @Default('') String otp,
    @Default(Duration(seconds: 30)) Duration activeResendDuration,
    Object? error,
  }) = _PhoneVerificationState;
}
