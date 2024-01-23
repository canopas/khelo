import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_verification_view_model.freezed.dart';

final phoneVerificationStateProvider = StateNotifierProvider.autoDispose<
    PhoneVerificationViewNotifier, PhoneVerificationState>((ref) {
  return PhoneVerificationViewNotifier(
    FirebaseAuth.instance,
  );
});

class PhoneVerificationViewNotifier
    extends StateNotifier<PhoneVerificationState> {
  final FirebaseAuth firebaseAuth;
  late Timer timer;
  late String phoneNumber;

  bool firstAutoVerificationComplete = false;

  PhoneVerificationViewNotifier(
    this.firebaseAuth,
  ) : super(const PhoneVerificationState()) {
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
  }

  void onVerificationSuccess(UserCredential credential) {
    // do something with cred
    // return cred info to prev screen to push from edit screen
    state = state.copyWith(verifying: false, verificationComplete: true);
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
    } catch (error) {
      state = state.copyWith(verifying: false, error: error);
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
    @Default(false) bool verificationComplete,
    String? verificationId,
    @Default('') String otp,
    @Default(Duration(seconds: 30)) Duration activeResendDuration,
    Object? error,
  }) = _PhoneVerificationState;
}
