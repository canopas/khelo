import 'package:data/api/user/user_models.dart';
import 'package:data/service/auth/auth_service.dart';
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
    ref.read(authServiceProvider),
    ref.read(currentUserPod),
  );
  ref.listen(currentUserPod, (_, next) => notifier._updateUser(next));
  return notifier;
});

class EditProfileViewNotifier extends StateNotifier<EditProfileState> {
  final FileUploadService fileUploadService;
  final UserService userService;
  final AuthService _authService;

  EditProfileViewNotifier(
    this.fileUploadService,
    this.userService,
    this._authService,
    UserModel? user,
  ) : super(EditProfileState(
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
        await deleteUnusedImage(prevUrl);
      }
      state = state.copyWith(imageUrl: imageUrl, isImageUploading: false);
      onValueChange();
    } catch (e) {
      state = state.copyWith(isImageUploading: false);
      debugPrint("EditProfileViewNotifier: error while image upload -> $e");
    }
  }

  Future<void> onBackBtnPressed() async {
    if (state.imageUrl != state.currentUser?.profile_img_url &&
        state.imageUrl != null) {
      await deleteUnusedImage(state.imageUrl!);
    }
  }

  Future<void> onSubmitTap() async {
    if (state.currentUser == null) {
      return;
    }

    try {
      state = state.copyWith(isSaveInProgress: true);
      final String? previousImageUrl;
      if (state.currentUser?.profile_img_url != null &&
          state.imageUrl != state.currentUser?.profile_img_url) {
        previousImageUrl = state.currentUser!.profile_img_url!;
      } else {
        previousImageUrl = null;
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
          created_at: state.currentUser?.created_at,
          updated_at: DateTime.now());

      await userService.updateUser(user);
      if (previousImageUrl != null) {
        await deleteUnusedImage(previousImageUrl);
      }
      state = state.copyWith(isSaveInProgress: false, isSaved: true);
    } catch (e) {
      state = state.copyWith(isSaveInProgress: false);
      debugPrint(
          "EditProfileViewNotifier: error while edit profile details -> $e");
    }
  }

  Future<void> onDeleteTap() async {
    try {
      String? userProfileImageUrl;
      String? currentImageUrl;
      if (state.imageUrl != null) {
        if (state.imageUrl != state.currentUser?.profile_img_url &&
            state.currentUser?.profile_img_url != null) {
          userProfileImageUrl = state.currentUser!.profile_img_url!;
        }
        currentImageUrl = state.imageUrl!;
      } else {
        if (state.currentUser?.profile_img_url != null) {
          userProfileImageUrl = state.currentUser!.profile_img_url!;
        }
      }

      await _authService.deleteAccount();

      if (userProfileImageUrl != null) {
        await deleteUnusedImage(userProfileImageUrl);
      }
      if (currentImageUrl != null) {
        await deleteUnusedImage(currentImageUrl);
      } // do not merge above both if-conditions in if-else or any other control-flow, at a time both variable may have non-null value
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      }
    } catch (e) {
      debugPrint("EditProfileViewNotifier: error while delete account -> $e");
    }
  }

  Future<void> _reauthenticateAndDelete() async {
    try {
      String? userProfileImageUrl;
      String? currentImageUrl;
      if (state.imageUrl != null) {
        if (state.imageUrl != state.currentUser?.profile_img_url &&
            state.currentUser?.profile_img_url != null) {
          userProfileImageUrl = state.currentUser!.profile_img_url!;
        }
        currentImageUrl = state.imageUrl!;
      } else {
        if (state.currentUser?.profile_img_url != null) {
          userProfileImageUrl = state.currentUser!.profile_img_url!;
        }
      }

      _authService.reauthenticateAndDeleteAccount();

      if (userProfileImageUrl != null) {
        await deleteUnusedImage(userProfileImageUrl);
      }
      if (currentImageUrl != null) {
        await deleteUnusedImage(currentImageUrl);
      } // do not merge above both if-conditions in if-else or any other control-flow, at a time both variable may have non-null value
    } on FirebaseAuthException catch (e) {
      if (e.code == "web-user-interaction-failure") {
        // TODO: handle the error when user account has been deleted after creating in few course of time
        debugPrint(
            "EditProfileViewNotifier: error in _reAuthenticateAndDelete -> $e");
      }
    } catch (e) {
      debugPrint(
          "EditProfileViewNotifier: error in reAuthenticate And Delete -> $e");
    }
  }

  Future<void> deleteUnusedImage(String imgUrl) async {
    try {
      await fileUploadService.deleteUploadedProfileImage(imgUrl);
    } catch (e) {
      debugPrint(
          "EditProfileViewNotifier: error while deleting Unused Image -> $e");
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
