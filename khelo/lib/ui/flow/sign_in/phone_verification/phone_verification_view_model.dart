import 'dart:async';
import 'package:data/service/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_verification_view_model.freezed.dart';

final phoneVerificationStateProvider = StateNotifierProvider.autoDispose<
    PhoneVerificationViewNotifier, PhoneVerificationState>((ref) {
  return PhoneVerificationViewNotifier(
    ref.read(authServiceProvider),
  );
});

class PhoneVerificationViewNotifier
    extends StateNotifier<PhoneVerificationState> {
  final AuthService _authService;
  late Timer timer;
  late String phoneNumber;

  bool firstAutoVerificationComplete = false;

  PhoneVerificationViewNotifier(this._authService)
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
        showErrorVerificationCodeText: false);

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
      state = state.copyWith(showErrorVerificationCodeText: false);
      updateResendCodeTimerDuration();
      _authService.verifyPhoneNumber(
        phoneNumber: phone,
        onVerificationCompleted: (phoneCredential, _) {
          state =
              state.copyWith(verifying: false, isVerificationComplete: true);
        },
        onVerificationFailed: (error) {
          state = state.copyWith(error: error);
        },
        onCodeSent: (verificationId, _) {
          state = state.copyWith(verificationId: verificationId);
        },
      );
    } catch (e) {
      debugPrint("PhoneVerificationViewNotifier: error in resend otp -> $e");
    }
  }

  Future<void> verifyOTP() async {
    if (state.verificationId == null) return;
    state =
        state.copyWith(verifying: true, showErrorVerificationCodeText: false);
    try {
      await _authService.verifyOTP(state.verificationId!, state.otp);
      state = state.copyWith(verifying: false, isVerificationComplete: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-verification-code") {
        state = state.copyWith(
            verifying: false, showErrorVerificationCodeText: true);
      } else {
        //network-request-failed
        state = state.copyWith(verifying: false, error: e);
      }
      debugPrint(
          "PhoneVerificationViewNotifier: error in FirebaseAuthException: verifyOTP -> $e");
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
    @Default(false) bool isVerificationComplete,
    @Default(false) bool showErrorVerificationCodeText,
    String? verificationId,
    @Default('') String otp,
    @Default(Duration(seconds: 30)) Duration activeResendDuration,
    Object? error,
  }) = _PhoneVerificationState;
}
