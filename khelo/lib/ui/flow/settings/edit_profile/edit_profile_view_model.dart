import 'dart:io';

import 'package:data/api/user/user_models.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/service/auth/auth_service.dart';
import 'package:data/service/file_upload/file_upload_service.dart';
import 'package:data/service/match/match_service.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/service/tournament/tournament_service.dart';
import 'package:data/service/user/user_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:data/storage/provider/preferences_provider.dart';
import 'package:data/utils/constant/firebase_storage_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/file_extension.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';

part 'edit_profile_view_model.freezed.dart';

final editProfileStateProvider = StateNotifierProvider.autoDispose<
    EditProfileViewNotifier, EditProfileState>((ref) {
  final notifier = EditProfileViewNotifier(
    ref.read(fileUploadServiceProvider),
    ref.read(userServiceProvider),
    ref.read(authServiceProvider),
    ref.read(teamServiceProvider),
    ref.read(matchServiceProvider),
    ref.read(tournamentServiceProvider),
    ref.read(currentUserPod),
    ref.read(currentUserJsonPod.notifier),
  );
  ref.listen(currentUserPod, (_, next) => notifier._updateUser(next));
  return notifier;
});

class EditProfileViewNotifier extends StateNotifier<EditProfileState> {
  final FileUploadService _fileUploadService;
  final UserService userService;
  final AuthService _authService;
  final TeamService _teamService;
  final MatchService _matchService;
  final TournamentService _tournamentService;
  final PreferenceNotifier<String?> _userJsonController;

  EditProfileViewNotifier(
    this._fileUploadService,
    this.userService,
    this._authService,
    this._teamService,
    this._matchService,
    this._tournamentService,
    UserModel? user,
    this._userJsonController,
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

  Future<void> onImageChange(String imagePath) async {
    try {
      state = state.copyWith(isImageUploading: true, actionError: null);
      if (await File(imagePath).isFileUnderMaxSize()) {
        state = state.copyWith(filePath: imagePath, isImageUploading: false);
      } else {
        state = state.copyWith(
            isImageUploading: false,
            actionError: const LargeAttachmentUploadError());
      }
      onValueChange();
    } catch (e) {
      state = state.copyWith(isImageUploading: false, actionError: e);
      debugPrint("EditProfileViewNotifier: error while image upload -> $e");
    }
  }

  Future<void> onSubmitTap() async {
    if (state.currentUser == null) {
      return;
    }
    state = state.copyWith(actionError: null);
    try {
      state = state.copyWith(isSaveInProgress: true);
      if (state.filePath != null) {
        final imageUrl = await _fileUploadService.uploadProfileImage(
            filePath: state.filePath!,
            uploadPath: StorageConst.userProfileUploadPath(
                userId: state.currentUser!.id));
        state = state.copyWith(imageUrl: imageUrl);
      }

      final name = state.nameController.text.trim();
      final email = state.emailController.text.trim();
      final location = state.locationController.text.trim();

      UserModel user = UserModel(
        id: state.currentUser!.id,
        name: name,
        name_lowercase: name.toLowerCase(),
        email: email,
        location: location.toLowerCase(),
        batting_style: state.battingStyle,
        bowling_style: state.bowlingStyle,
        player_role: state.playerRole,
        gender: state.gender,
        phone: state.currentUser?.phone,
        profile_img_url: state.imageUrl,
        dob: state.dob,
        created_at: state.currentUser?.created_at ?? DateTime.now(),
        updated_at: DateTime.now(),
      );

      await userService.updateUser(user);
      _userJsonController.state = user.toJsonString();
      state = state.copyWith(isSaveInProgress: false, isSaved: true);
    } catch (e) {
      state = state.copyWith(isSaveInProgress: false, actionError: e);
      debugPrint(
          "EditProfileViewNotifier: error while edit profile details -> $e");
    }
  }

  Future<void> onDeleteTap() async {
    try {
      state = state.copyWith(actionError: null);
      final userProfileImageUrl = state.currentUser!.profile_img_url;
      await _authService.deleteAccount();

      if (userProfileImageUrl != null) {
        await _deleteUnusedImage(userProfileImageUrl);
      }
    } catch (e) {
      if (e is RequiresRecentLoginError) {
        await _reAuthenticateAndDelete();
      }
      state = state.copyWith(actionError: e);

      debugPrint("EditProfileViewNotifier: error while delete account -> $e");
    }
  }

  Future<void> checkUserOwnershipAndShowDialog() async {
    try {
      final userId = state.currentUser?.id;
      if (userId == null) return;
      state = state.copyWith(
        showDeleteConfirmationDialog: false,
        showTransferTeamsSheet: false,
      );

      final [matchCount, teamCount, tournamentCount] = await Future.wait([
        _matchService.getUserOwnedMatchesCount(userId),
        _teamService.getUserOwnedTeamsCount(userId),
        _tournamentService.getUserOwnedTournamentsCount(userId)
      ]);
      if (teamCount == 0 && matchCount == 0 && tournamentCount == 0) {
        state = state.copyWith(showDeleteConfirmationDialog: true);
      } else {
        state = state.copyWith(showTransferTeamsSheet: true);
      }
    } catch (e) {
      state = state.copyWith(actionError: e);
      debugPrint(
          "EditProfileViewNotifier: error while fetching user teams -> $e");
    }
  }

  Future<void> _reAuthenticateAndDelete() async {
    try {
      final userProfileImageUrl = state.currentUser!.profile_img_url;
      _authService.reAuthenticateAndDeleteAccount();
      if (userProfileImageUrl != null) {
        await _deleteUnusedImage(userProfileImageUrl);
      }
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

  Future<void> _deleteUnusedImage(String imgUrl) async {
    try {
      await _fileUploadService.deleteUploadedImage(imgUrl);
    } catch (e) {
      debugPrint(
          "EditProfileViewNotifier: error while deleting Unused Image -> $e");
    }
  }

  @override
  void dispose() {
    state.nameController.dispose();
    state.emailController.dispose();
    state.locationController.dispose();
    super.dispose();
  }
}

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    required DateTime dob,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController locationController,
    Object? actionError,
    UserModel? currentUser,
    String? filePath,
    @Default(null) String? imageUrl,
    @Default(null) UserGender? gender,
    @Default(null) BattingStyle? battingStyle,
    @Default(null) BowlingStyle? bowlingStyle,
    @Default(null) PlayerRole? playerRole,
    @Default(false) bool isButtonEnable,
    @Default(false) bool isImageUploading,
    @Default(false) bool isSaved,
    @Default(false) bool isSaveInProgress,
    @Default(false) bool showDeleteConfirmationDialog,
    @Default(false) bool showTransferTeamsSheet,
  }) = _EditProfileState;
}
