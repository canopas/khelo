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
          nameController: TextEditingController(),
          code: CountryCode.getCountryCodeByAlpha2(
            countryAlpha2Code:
                WidgetsBinding.instance.platformDispatcher.locale.countryCode,
          ),
        ));

  void setData(
    CountryCode? code,
    String? defaultNumber,
    bool isForCreateUser,
  ) {
    state.phoneController.text = defaultNumber ?? '';
    state = state.copyWith(
        isForCreateUser: isForCreateUser, code: code ?? state.code);
    onTextChange();
  }

  void onCodeChange(CountryCode code) {
    state = state.copyWith(code: code);
  }

  void onTextChange() {
    final isNameNotEmpty = state.isForCreateUser
        ? state.nameController.text.trim().isNotEmpty
        : true;
    final isPhoneNotEmpty = state.phoneController.text.trim().length > 3;
    state = state.copyWith(isButtonEnable: isNameNotEmpty && isPhoneNotEmpty);
  }

  void onConfirmTap() {
    state = state.copyWith(isPop: true);
  }

  @override
  void dispose() {
    state.nameController.dispose();
    state.phoneController.dispose();
    super.dispose();
  }
}

@freezed
class ConfirmNumberViewState with _$ConfirmNumberViewState {
  const factory ConfirmNumberViewState({
    required TextEditingController phoneController,
    required TextEditingController nameController,
    required CountryCode code,
    @Default(false) bool isButtonEnable,
    @Default(false) bool isForCreateUser,
    @Default(false) bool isPop,
  }) = _ConfirmNumberViewState;
}
