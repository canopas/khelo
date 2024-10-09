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
  late String _phoneNumber;
  late String _countryCode;

  bool _firstAutoVerificationComplete = false;

  PhoneVerificationViewNotifier(this._authService)
      : super(const PhoneVerificationState());

  void updateOTP(String otp) {
    state = state.copyWith(
        otp: otp,
        enableVerify: otp.length == 6,
        showErrorVerificationCodeText: false);

    if (!_firstAutoVerificationComplete && otp.length == 6) {
      verifyOTP();
      _firstAutoVerificationComplete = true;
    }
  }

  void updateVerificationIdAndPhone({
    required String verificationId,
    required String phone,
    required String code,
  }) {
    state = state.copyWith(verificationId: verificationId);
    _phoneNumber = phone;
    _countryCode = code;
  }

  Future<void> verifyOTP() async {
    if (state.verificationId == null) return;
    state = state.copyWith(
        verifying: true,
        showErrorVerificationCodeText: false,
        actionError: null);
    try {
      await _authService.verifyOTP(
          _countryCode, _phoneNumber, state.verificationId!, state.otp);
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
