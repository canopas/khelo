import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/service/device/device_service.dart';
import 'package:data/service/user/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_with_phone_view_model.freezed.dart';

final signInWithPhoneStateProvider = StateNotifierProvider.autoDispose<
    SignInWithPhoneViewNotifier, SignInWithPhoneState>((ref) {
  return SignInWithPhoneViewNotifier(FirebaseAuth.instance,
      ref.read(userServiceProvider), ref.read(deviceServiceProvider));
});

class SignInWithPhoneViewNotifier extends StateNotifier<SignInWithPhoneState> {
  final FirebaseAuth firebaseAuth;
  final UserService userService;
  final DeviceService deviceService;

  SignInWithPhoneViewNotifier(
      this.firebaseAuth, this.userService, this.deviceService)
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
      debugPrint(
          "SignInWithPhoneViewNotifier: error in fetchCountryCode -> $e");
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
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: state.code.dialCode + state.phone,
        verificationCompleted: (phoneAuthCredential) async {
          final credential =
              await firebaseAuth.signInWithCredential(phoneAuthCredential);

          // call update function and update user in db
          UserModel user = UserModel(
              id: firebaseAuth.currentUser?.uid ?? "INVALID ID",
              phone: firebaseAuth.currentUser?.phoneNumber);
          await userService.updateUser(user);
          state = state.copyWith(verifying: false, signInSuccess: credential);
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
    } catch (e) {
      state = state.copyWith(verifying: false, error: e);
      debugPrint(
          "SignInWithPhoneViewNotifier: error in verifyPhoneNumber -> $e");
    }
  }
}

@freezed
class SignInWithPhoneState with _$SignInWithPhoneState {
  const factory SignInWithPhoneState({
    required CountryCode code,
    @Default(false) bool verifying,
    @Default(null) UserCredential? signInSuccess,
    String? verificationId,
    @Default(false) bool enableNext,
    Object? error,
    @Default('') String phone,
  }) = _SignInWithPhoneState;
}
