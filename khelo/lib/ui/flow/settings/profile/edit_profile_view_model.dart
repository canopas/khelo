import 'package:data/api/user/user_models.dart';
import 'package:data/service/file_upload/file_upload_service.dart';
import 'package:data/service/user/user_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';

part 'edit_profile_view_model.freezed.dart';

final editProfileStateProfile = StateNotifierProvider.autoDispose<
    EditProfileViewNotifier, EditProfileState>((ref) {
  final notifier = EditProfileViewNotifier(
    ref.read(fileUploadServiceProvider),
    ref.read(userServiceProvider),
    FirebaseAuth.instance,
    ref.read(currentUserPod),
  );
  ref.listen(currentUserPod, (_, next) => notifier._updateUser(next));
  return notifier;
});

class EditProfileViewNotifier extends StateNotifier<EditProfileState> {
  final FileUploadService fileUploadService;
  final UserService userService;
  final FirebaseAuth auth;

  EditProfileViewNotifier(
      this.fileUploadService, this.userService, this.auth, UserModel? user)
      : super(EditProfileState(
            dob: user?.dob ?? DateTime.now(),
            imageUrl: user?.profile_img_url,
            battingStyle: user?.batting_style,
            bowlingStyle: user?.bowling_style,
            gender: user?.gender,
            playerRole: user?.player_role,
            nameController: TextEditingController(text: user?.name),
            emailController: TextEditingController(text: user?.email),
            currentUser: user,
            locationController: TextEditingController(text: user?.location)));

  void _updateUser(UserModel? user) {
    state = state.copyWith(currentUser: user);
  }

  void onDateSelect({required DateTime selectedDate}) {
    state = state.copyWith(dob: selectedDate);
    onValueChange();
  }

  void onGenderSelect({required UserGender gender}) {
    state = state.copyWith(gender: gender);
    onValueChange();
  }

  void onBattingStyleChange(BattingStyle style) {
    state = state.copyWith(battingStyle: style);
    onValueChange();
  }

  void onBowlingStyleChange(BowlingStyle style) {
    state = state.copyWith(bowlingStyle: style);
    onValueChange();
  }

  void onPlayerRoleChange(PlayerRole role) {
    state = state.copyWith(playerRole: role);
    onValueChange();
  }

  void onValueChange() {
    final bool isEnable = state.nameController.text.trim().length >= 3 &&
        state.emailController.text.trim().isValidEmail() &&
        state.locationController.text.trim().length >= 3;

    state = state.copyWith(isButtonEnable: isEnable);
  }

  Future<void> onImageChange(String path) async {
    try {
      state = state.copyWith(isImageUploading: true);
      final imageUrl = await fileUploadService.uploadProfileImage(path);
      final prevUrl = state.imageUrl;

      if (prevUrl != null && prevUrl != state.currentUser?.profile_img_url) {
        await fileUploadService.deleteUploadedProfileImage(prevUrl);
      }
      state = state.copyWith(imageUrl: imageUrl, isImageUploading: false);
      onValueChange();
    } catch (e) {
      state = state.copyWith(isImageUploading: false);
      debugPrint("EditProfileViewNotifier: error while image upload -> $e");
    }
  }

  Future<void> onBackBtnPressed() async {
    try {
      if (state.imageUrl != state.currentUser?.profile_img_url &&
          state.imageUrl != null) {
        await fileUploadService.deleteUploadedProfileImage(state.imageUrl!);
      }
    } catch (e) {
      debugPrint(
          "EditProfileViewNotifier: error while delete image on back btn press -> $e");
    }
  }

  Future<void> onSubmitTap() async {
    if (state.currentUser == null) {
      return;
    }

    try {
      state = state.copyWith(isSaveInProgress: true);
      if (state.currentUser?.profile_img_url != null &&
          state.imageUrl != state.currentUser?.profile_img_url) {
        fileUploadService
            .deleteUploadedProfileImage(state.currentUser!.profile_img_url!);
      }

      final name = state.nameController.text.trim();
      final email = state.emailController.text.trim();
      final location = state.locationController.text.trim();

      UserModel user = UserModel(
          id: state.currentUser!.id,
          name: name,
          email: email,
          location: location,
          batting_style: state.battingStyle,
          bowling_style: state.bowlingStyle,
          player_role: state.playerRole,
          gender: state.gender,
          profile_img_url: state.imageUrl,
          dob: state.dob,
          updated_at: DateTime.now());

      await userService.updateUser(user);
      state = state.copyWith(isSaveInProgress: false, isSaved: true);
    } catch (e) {
      state = state.copyWith(isSaveInProgress: false);
      debugPrint(
          "EditProfileViewNotifier: error while edit profile details -> $e");
    }
  }

  Future<void> onDeleteTap() async {
    try {
      if (state.imageUrl != null) {
        if (state.imageUrl != state.currentUser?.profile_img_url &&
            state.currentUser?.profile_img_url != null) {
          fileUploadService
              .deleteUploadedProfileImage(state.currentUser!.profile_img_url!);
        }
        fileUploadService.deleteUploadedProfileImage(state.imageUrl!);
      } else {
        if (state.currentUser?.profile_img_url != null) {
          fileUploadService
              .deleteUploadedProfileImage(state.currentUser!.profile_img_url!);
        }
      }

      await auth.currentUser?.delete();
      userService.deleteUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        await _reAuthenticateAndDelete();
      }
    } catch (e) {
      debugPrint("EditProfileViewNotifier: error while delete account -> $e");
    }
  }

  Future<void> _reAuthenticateAndDelete() async {
    try {
      final providerData = auth.currentUser?.providerData.first;
      if (PhoneAuthProvider().providerId == providerData?.providerId) {
        await auth.currentUser?.reauthenticateWithProvider(PhoneAuthProvider());
        await auth.currentUser?.delete();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "web-user-interaction-failure") {
        debugPrint(
            "EditProfileViewNotifier: error in _reAuthenticateAndDelete -> $e");
      }
    } catch (e) {
      debugPrint(
          "EditProfileViewNotifier: error in reAuthenticate And Delete -> $e");
    }
  }
}

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    required DateTime dob,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController locationController,
    @Default(null) String? imageUrl,
    @Default(null) UserGender? gender,
    @Default(null) BattingStyle? battingStyle,
    @Default(null) BowlingStyle? bowlingStyle,
    @Default(null) PlayerRole? playerRole,
    @Default(false) bool isButtonEnable,
    @Default(false) bool isImageUploading,
    @Default(false) bool isSaved,
    @Default(false) bool isSaveInProgress,
    UserModel? currentUser,
  }) = _EditProfileState;
}
