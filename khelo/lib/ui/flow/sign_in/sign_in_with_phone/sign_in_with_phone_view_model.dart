import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:data/service/auth/auth_service.dart';
import 'package:data/service/device/device_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_with_phone_view_model.freezed.dart';

final signInWithPhoneStateProvider = StateNotifierProvider.autoDispose<
    SignInWithPhoneViewNotifier, SignInWithPhoneState>((ref) {
  return SignInWithPhoneViewNotifier(
      ref.read(authServiceProvider), ref.read(deviceServiceProvider));
});

class SignInWithPhoneViewNotifier extends StateNotifier<SignInWithPhoneState> {
  final AuthService _authService;
  final DeviceService _deviceService;

  SignInWithPhoneViewNotifier(this._authService, this._deviceService)
      : super(
          SignInWithPhoneState(
            phoneController: TextEditingController(),
            code: CountryCode.getCountryCodeByAlpha2(
              countryAlpha2Code:
                  WidgetsBinding.instance.platformDispatcher.locale.countryCode,
            ),
          ),
        ) {
    _fetchCountryCode();
  }

  void _fetchCountryCode() async {
    try {
      final countryCode = await _deviceService.countryCode;
      if (countryCode != state.code.code) {
        state = state.copyWith(
          code: CountryCode.getCountryCodeByAlpha2(
            countryAlpha2Code: countryCode,
          ),
        );
      }
    } catch (e) {
      debugPrint(
          "SignInWithPhoneViewNotifier: error in fetchCountryCode -> $e");
    }
  }

  void changeCountryCode(code) {
    state = state.copyWith(code: code);
  }

  void onPhoneChange(String phone) {
    state = state.copyWith(
      phone: phone.trim(),
      enableBtn: phone.length > 3,
    );
  }

  Future<void> verifyPhoneNumber() async {
    state = state.copyWith(verifying: true, actionError: null);
    try {
      _authService.verifyPhoneNumber(
          countryCode: state.code.dialCode,
          phoneNumber: state.phone,
          onVerificationCompleted: (phoneCredential, _) {
            state = state.copyWith(verifying: false, signInSuccess: true);
          },
          onVerificationFailed: (error) {
            FirebaseCrashlytics.instance.recordError(error, error.stackTrace,
                reason: "Verify Phone-Number Error",
                information: [error.statusCode ?? "", error.message ?? ""]);
            state = state.copyWith(verifying: false, actionError: error);
            debugPrint(
                "SignInWithPhoneViewNotifier: error in verifyPhoneNumber -> $error");
          },
          onCodeSent: (verificationId, _) {
            state = state.copyWith(
                verificationId: verificationId, verifying: false);
          });
    } catch (error, stack) {
      FirebaseCrashlytics.instance
          .recordError(error, stack, reason: "Verify Phone-Number Error");
      state = state.copyWith(verifying: false, actionError: error);
      debugPrint(
          "SignInWithPhoneViewNotifier: error in verifyPhoneNumber -> $error");
    }
  }

  @override
  void dispose() {
    state.phoneController.dispose();
    super.dispose();
  }
}

@freezed
class SignInWithPhoneState with _$SignInWithPhoneState {
  const factory SignInWithPhoneState({
    required TextEditingController phoneController,
    required CountryCode code,
    Object? actionError,
    String? verificationId,
    @Default(false) bool verifying,
    @Default(false) bool signInSuccess,
    @Default(false) bool enableBtn,
    @Default('') String phone,
  }) = _SignInWithPhoneState;
}
