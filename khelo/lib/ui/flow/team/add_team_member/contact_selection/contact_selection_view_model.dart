import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/service/user/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

part 'contact_selection_view_model.freezed.dart';

final contactSelectionStateProvider = StateNotifierProvider.autoDispose<
    ContactSelectionViewNotifier, ContactSelectionState>((ref) {
  return ContactSelectionViewNotifier(ref.read(userServiceProvider));
});

class ContactSelectionViewNotifier
    extends StateNotifier<ContactSelectionState> {
  final UserService _userService;
  List<Contact> fetchedContacts = [];
  List<String> memberIds = [];

  ContactSelectionViewNotifier(this._userService)
      : super(const ContactSelectionState()) {
    checkContactPermission();
  }

  void setDate(List<String> memberIds) {
    this.memberIds = memberIds;
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
    state = state.copyWith(alreadyAdded: false);
    try {
      final user = await _userService.getUserByPhoneNumber(number);
      if (user == null) {
        // TODO: call function for create account, it'll return that created user and use that one.
      } else if (memberIds.contains(user.id)) {
        state = state.copyWith(alreadyAdded: true);
      } else {
        state = state.copyWith(selectedUser: user);
      }
    } catch (e) {
      debugPrint(
          "ContactSelectionViewNotifier: Error getting user by phone number $e");
    }
  }

  (CountryCode, String) getNormalisedNumber(String phoneNumber) {
    String? code;
    if (phoneNumber.startsWith('+')) {
      String splitString = phoneNumber.split(" ").first;
      if (splitString.length <= 5) {
        code = splitString;
        phoneNumber = phoneNumber
            .substring(splitString.length)
            .replaceAll(RegExp(r'[\s\-\(\)]+'), '');
      } else {
        phoneNumber = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]+'), '');
      }
    } else {
      phoneNumber = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]+'), '');
    }
    CountryCode? countryCode;
    if (code == null) {
      countryCode = CountryCode.getCountryCodeByAlpha2(
        countryAlpha2Code:
            WidgetsBinding.instance.platformDispatcher.locale.countryCode,
      );
    } else {
      countryCode = CountryCode.getCountryCodeByDialCode(dialCode: code);

      if (countryCode.dialCode == "+1" && code != "+1") {
        countryCode = CountryCode.getCountryCodeByAlpha2(
          countryAlpha2Code:
              WidgetsBinding.instance.platformDispatcher.locale.countryCode,
        );
      }
    }
    return (countryCode, phoneNumber);
  }
}

@freezed
class ContactSelectionState with _$ContactSelectionState {
  const factory ContactSelectionState({
    Object? error,
    UserModel? selectedUser,
    @Default(false) bool loading,
    @Default(false) bool alreadyAdded,
    @Default(false) bool hasContactPermission,
    @Default([]) List<Contact> contacts,
  }) = _ContactSelectionState;
}
