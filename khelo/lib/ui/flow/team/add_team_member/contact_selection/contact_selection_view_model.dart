import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/service/device/device_service.dart';
import 'package:data/service/user/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

part 'contact_selection_view_model.freezed.dart';

final contactSelectionStateProvider = StateNotifierProvider.autoDispose<
    ContactSelectionViewNotifier, ContactSelectionState>((ref) {
  return ContactSelectionViewNotifier(
    ref.read(userServiceProvider),
    ref.read(deviceServiceProvider),
  );
});

class ContactSelectionViewNotifier
    extends StateNotifier<ContactSelectionState> {
  final UserService _userService;
  final DeviceService _deviceService;
  List<Contact> fetchedContacts = [];
  List<String> memberIds = [];
  String? deviceCountryCode =
      WidgetsBinding.instance.platformDispatcher.locale.countryCode;

  ContactSelectionViewNotifier(this._userService, this._deviceService)
      : super(const ContactSelectionState()) {
    fetchCountryCode();
  }

  void setDate(List<String> memberIds) {
    this.memberIds = memberIds;
    checkContactPermission();
  }

  Future<void> fetchContacts() async {
    try {
      state = state.copyWith(error: null, loading: true);
      fetchedContacts = await ContactsService.getContacts();
      state = state.copyWith(contacts: fetchedContacts, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e);
      debugPrint("ContactSelectionViewNotifier: Error getting contacts");
    }
  }

  void fetchCountryCode() async {
    try {
      deviceCountryCode = await _deviceService.countryCode;
    } catch (e) {
      debugPrint(
          "ContactSelectionViewNotifier: Error in fetchCountryCode -> $e");
    }
  }

  void checkContactPermission({requestIfNotGranted = true}) async {
    var status = await Permission.contacts.status;
    if (requestIfNotGranted &&
        !status.isGranted &&
        status != PermissionStatus.permanentlyDenied) {
      // Show initial permission prompt after 2 seconds
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      status = await Permission.contacts.request();
    }

    state = state.copyWith(
      hasContactPermission: status.isGranted,
      loading: false,
    );

    if (status.isGranted) {
      fetchContacts();
    }
  }

  Future<void> getUserByPhoneNumber(String? name, String number) async {
    state = state.copyWith(alreadyAdded: false, isActionInProgress: true);
    try {
      final user = await _userService.getUserByPhoneNumber(number);
      if (user == null) {
        createUser(name, number);
      } else if (memberIds.contains(user.id)) {
        state = state.copyWith(alreadyAdded: true, isActionInProgress: false);
      } else {
        state = state.copyWith(selectedUser: user, isActionInProgress: false);
      }
    } catch (e) {
      state = state.copyWith(actionError: e, isActionInProgress: false);
      debugPrint(
          "ContactSelectionViewNotifier: Error getting user by phone number $e");
    }
  }

  Future<void> createUser(String? name, String number) async {
    if (name == null) {
      state = state.copyWith(isActionInProgress: false);
      return;
    }

    try {
      final user = await _userService.createNewUser(number, name);
      state = state.copyWith(selectedUser: user, isActionInProgress: false);
    } catch (e) {
      state = state.copyWith(actionError: e, isActionInProgress: false);
      debugPrint("ContactSelectionViewNotifier: Error creating new user $e");
    }
  }

  (CountryCode, String) getNormalisedNumber(String phoneNumber) {
    String? code;
    if (phoneNumber.startsWith('+')) {
      phoneNumber = keepDigitAndPlusAtStart(phoneNumber);

      final matchedCountryCode = CountryCode.allCodes
          .where((element) => phoneNumber.startsWith(element.dialCode))
          .firstOrNull
          ?.dialCode;
      code = matchedCountryCode ?? deviceCountryCode;
      final trimFrom = matchedCountryCode != null ? code?.length : 1;
      phoneNumber = phoneNumber.substring(trimFrom ?? 1);
    } else {
      phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    }

    CountryCode? countryCode;
    if (code == null) {
      countryCode = CountryCode.getCountryCodeByAlpha2(
        countryAlpha2Code: deviceCountryCode,
      );
    } else {
      countryCode = CountryCode.getCountryCodeByDialCode(dialCode: code);
      // handle default returned US code in case not found
      if (countryCode.dialCode == "+1" && code != "+1") {
        countryCode = CountryCode.getCountryCodeByAlpha2(
          countryAlpha2Code: deviceCountryCode,
        );
      }
    }
    return (countryCode, phoneNumber);
  }
}

String keepDigitAndPlusAtStart(String input) {
  String formatted = input.replaceAll(RegExp(r'[^+\d]'), '');

  if (formatted.startsWith('+')) {
    formatted = '+${formatted.replaceAll(RegExp(r'[^\d]'), '')}';
  } else {
    formatted = formatted.replaceAll(RegExp(r'[^\d]'), '');
  }

  return formatted;
}

@freezed
class ContactSelectionState with _$ContactSelectionState {
  const factory ContactSelectionState({
    Object? error,
    Object? actionError,
    UserModel? selectedUser,
    @Default(false) bool loading,
    @Default(false) bool isActionInProgress,
    @Default(false) bool alreadyAdded,
    @Default(false) bool hasContactPermission,
    @Default([]) List<Contact> contacts,
  }) = _ContactSelectionState;
}
