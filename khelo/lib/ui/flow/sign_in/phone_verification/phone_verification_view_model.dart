import 'dart:async';
import 'package:data/errors/app_error.dart';
import 'package:data/errors/app_error_l10n_codes.dart';
import 'package:data/service/auth/auth_service.dart';
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
  late String countryCode;

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
    required String code,
  }) {
    state = state.copyWith(verificationId: verificationId);
    phoneNumber = phone;
    countryCode = code;
  }

  Future<void> resendCode({required String countryCode, required String phone}) async {
    try {
      state = state.copyWith(showErrorVerificationCodeText: false, actionError: null);
      updateResendCodeTimerDuration();
      _authService.verifyPhoneNumber(
        countryCode: countryCode,
        phoneNumber: phone,
        onVerificationCompleted: (phoneCredential, _) {
          state =
              state.copyWith(verifying: false, isVerificationComplete: true);
        },
        onVerificationFailed: (error) {
          state = state.copyWith(actionError: error);
        },
        onCodeSent: (verificationId, _) {
          state = state.copyWith(verificationId: verificationId);
        },
      );
    } catch (e) {
      state = state.copyWith(actionError: e);
      debugPrint("PhoneVerificationViewNotifier: error in resend otp -> $e");
    }
  }

  Future<void> verifyOTP() async {
    if (state.verificationId == null) return;
    state =
        state.copyWith(verifying: true, showErrorVerificationCodeText: false, actionError: null);
    try {
      await _authService.verifyOTP(countryCode, phoneNumber, state.verificationId!, state.otp);
      state = state.copyWith(verifying: false, isVerificationComplete: true);
    } on AppError catch (e) {
      if (e.l10nCode == AppErrorL10nCodes.invalidVerificationCode) {
        state = state.copyWith(
            verifying: false, showErrorVerificationCodeText: true);
      } else {
        state = state.copyWith(verifying: false, actionError: e);
      }
      debugPrint(
          "PhoneVerificationViewNotifier: error in AppError: verifyOTP -> $e");
    } catch (e) {
      state = state.copyWith(verifying: false, actionError: e);
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
    Object? actionError,
    String? verificationId,
    @Default(false) bool verifying,
    @Default(false) bool enableVerify,
    @Default(false) bool isVerificationComplete,
    @Default(false) bool showErrorVerificationCodeText,
    @Default('') String otp,
    @Default(Duration(seconds: 30)) Duration activeResendDuration,
  }) = _PhoneVerificationState;
}
