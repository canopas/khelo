import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:data/service/device/device_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_with_phone_view_model.freezed.dart';

final signInWithPhoneStateProvider = StateNotifierProvider.autoDispose<
    SignInWithPhoneViewNotifier, SignInWithPhoneState>((ref) {
  return SignInWithPhoneViewNotifier(
      FirebaseAuth.instance, ref.read(deviceServiceProvider));
});

class SignInWithPhoneViewNotifier extends StateNotifier<SignInWithPhoneState> {
  final FirebaseAuth firebaseAuth;
  final DeviceService deviceService;

  SignInWithPhoneViewNotifier(this.firebaseAuth, this.deviceService)
      : super(
          SignInWithPhoneState(
            code: CountryCode.getCountryCodeByAlpha2(
              countryAlpha2Code:
                  WidgetsBinding.instance.platformDispatcher.locale.countryCode,
            ),
          ),
        ) {
    fetchCountryCode();
  }

  void fetchCountryCode() async {
    try {
      final countryCode = await deviceService.countryCode;
      if (countryCode != state.code.code) {
        state = state.copyWith(
          code: CountryCode.getCountryCodeByAlpha2(
            countryAlpha2Code: countryCode,
          ),
        );
      }
    } catch (e) {
      //Error: couldn't get country code
    }
  }

  void changeCountryCode(code) {
    state = state.copyWith(code: code, error: null);
  }

  void onPhoneChange(String phone) {
    state = state.copyWith(
      error: null,
      phone: phone.trim(),
      enableNext: phone.length > 3,
    );
  }

  Future<void> verifyPhoneNumber() async {
    state = state.copyWith(verifying: true, error: null);
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: state.code.dialCode + state.phone,
      verificationCompleted: (phoneAuthCredential) async {
        // automated sign in handled in android
        await firebaseAuth.signInWithCredential(phoneAuthCredential);
        // return cred info to prev screen to push from edit screen

        state = state.copyWith(verifying: false, signInSuccess: true);
      },
      verificationFailed: (error) {
        state = state.copyWith(verifying: false, error: error);
      },
      codeSent: (verificationId, forceResendingToken) {
        state =
            state.copyWith(verificationId: verificationId, verifying: false);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
}

@freezed
class SignInWithPhoneState with _$SignInWithPhoneState {
  const factory SignInWithPhoneState({
    required CountryCode code,
    @Default(false) bool verifying,
    @Default(false) bool signInSuccess,
    String? verificationId,
    @Default(false) bool enableNext,
    Object? error,
    @Default('') String phone,
  }) = _SignInWithPhoneState;
}
