import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_number_view_model.freezed.dart';

final confirmNumberStateProvider = StateNotifierProvider.autoDispose<
    ConfirmNumberViewNotifier, ConfirmNumberViewState>((ref) {
  return ConfirmNumberViewNotifier();
});

class ConfirmNumberViewNotifier extends StateNotifier<ConfirmNumberViewState> {
  ConfirmNumberViewNotifier()
      : super(ConfirmNumberViewState(
          phoneController: TextEditingController(),
          code: CountryCode.getCountryCodeByAlpha2(
            countryAlpha2Code:
                WidgetsBinding.instance.platformDispatcher.locale.countryCode,
          ),
        ));

  void setDate(CountryCode? code, String? defaultNumber) {
    state.phoneController.text = defaultNumber ?? '';
    if (code != null) {
      state = state.copyWith(code: code);
    }
  }

  void onCodeChange(CountryCode code) {
    state = state.copyWith(code: code);
  }

  void onTextChange() {
    state = state.copyWith(
        isButtonEnable: state.phoneController.text.length > 3);
  }

  void onConfirmTap() {
    state = state.copyWith(isPop: true);
  }
}

@freezed
class ConfirmNumberViewState with _$ConfirmNumberViewState {
  const factory ConfirmNumberViewState({
    Object? error,
    required TextEditingController phoneController,
    required CountryCode code,
    @Default(false) bool isButtonEnable,
    @Default(false) bool isPop,
  }) = _ConfirmNumberViewState;
}
