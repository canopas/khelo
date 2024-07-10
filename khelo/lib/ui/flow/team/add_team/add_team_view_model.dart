import 'dart:async';
import 'dart:io';
import 'package:data/api/user/user_models.dart';
import 'package:data/errors/app_error.dart';
import 'package:data/extensions/string_extensions.dart';
import 'package:data/service/file_upload/file_upload_service.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:data/utils/constant/firebase_storage_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/file_extension.dart';

part 'add_team_view_model.freezed.dart';

final addTeamStateProvider =
    StateNotifierProvider.autoDispose<AddTeamViewNotifier, AddTeamState>((ref) {
  final notifier = AddTeamViewNotifier(
    ref.read(fileUploadServiceProvider),
    ref.read(teamServiceProvider),
    ref.read(currentUserPod),
  );
  ref.listen(currentUserPod, (_, next) => notifier._updateUser(next));
  return notifier;
});

class AddTeamViewNotifier extends StateNotifier<AddTeamState> {
  final FileUploadService _fileUploadService;
  final TeamService _teamService;
  Timer? _debounce;

  AddTeamViewNotifier(
      this._fileUploadService, this._teamService, UserModel? user)
      : super(AddTeamState(
            nameController: TextEditingController(),
            locationController: TextEditingController(),
            currentUser: user));

  void setData({TeamModel? editTeam}) {
    state.nameController.text = editTeam?.name ?? "";
    state.locationController.text = editTeam?.city ?? "";
    state = state.copyWith(
        editTeam: editTeam, teamMembers: editTeam?.players ?? []);
  }

  void _updateUser(UserModel? user) {
    state = state.copyWith(currentUser: user);
  }

  void updatePlayersList(List<UserModel> players) {
    if (state.editTeam == null) {
      return;
    }
    state = state.copyWith(
        teamMembers: {...state.teamMembers, ...players}.toList());
    onValueChange();
  }

  void onAddMeCheckBoxTap(bool isAddMeCheckBoxEnable) {
    state = state.copyWith(isAddMeCheckBoxEnable: isAddMeCheckBoxEnable);
  }

  Future<void> onImageSelect(String imagePath) async {
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
      debugPrint("AddTeamViewNotifier: error while image upload -> $e");
    }
  }

  Future<void> onAddBtnTap() async {
    try {
      state = state.copyWith(isAddInProgress: true, actionError: null);

      final name = state.nameController.text.trim();
      final location = state.locationController.text.trim();

      List<UserModel> players = [];

      if (state.isAddMeCheckBoxEnable &&
          state.currentUser != null &&
          state.editTeam == null) {
        players.add(state.currentUser!);
      }

      if (state.editTeam != null) {
        players = state.teamMembers;
      }
      String? imageUrl = state.editTeam?.profile_img_url;
      AddTeamRequestModel team = AddTeamRequestModel(
          id: state.editTeam?.id,
          name: name,
          name_lowercase: name.caseAndSpaceInsensitive,
          profile_img_url: imageUrl,
          city: location.toLowerCase(),
          created_by: state.currentUser!.id,
          players: players.map((e) => e.id).toList(),
          created_at: state.editTeam?.created_at ?? DateTime.now());

      final newTeamId = await _teamService.updateTeam(team);
      if (state.filePath != null) {
        imageUrl = await _fileUploadService.uploadProfileImage(
          filePath: state.filePath!,
          uploadPath: StorageConst.teamProfileUploadPath(
              userId: state.currentUser!.id, teamId: newTeamId),
        );
        await _teamService.updateProfileImageUrl(newTeamId, imageUrl);
      }

      if (state.editTeam != null) {
        final filterList = (state.editTeam!.players ?? [])
            .where((element) => !state.teamMembers.contains(element))
            .map((e) => e.id)
            .toList();

        await _teamService.removePlayersFromTeam(
            team.id ?? "INVALID ID", filterList);

        state = state.copyWith(isAddInProgress: false, isPop: true);
      } else {
        final teamModel = TeamModel(
            id: newTeamId,
            name: name,
            name_lowercase: name.caseAndSpaceInsensitive,
            profile_img_url: imageUrl,
            city: location.toLowerCase(),
            created_by: state.currentUser!.id,
            players: players,
            created_at: state.editTeam?.created_at ?? DateTime.now());
        state = state.copyWith(isAddInProgress: false, team: teamModel);
      }
    } catch (e) {
      state = state.copyWith(isAddInProgress: false, actionError: e);
      debugPrint("AddTeamViewNotifier: error while adding team detail -> $e");
    }
  }

  Future<void> onValueChange() async {
    final isEnable = state.nameController.text.trim().length >= 3 &&
        state.locationController.text.trim().length >= 3 &&
        (state.isNameAvailable == true ||
            state.editTeam?.name_lowercase ==
                state.nameController.text.caseAndSpaceInsensitive);
    state = state.copyWith(isAddBtnEnable: isEnable);
  }

  Future<void> onNameTextChanged() async {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }

    if (state.nameController.text.trim().length >= 3) {
      state = state.copyWith(checkingForAvailability: true);
    }
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (state.nameController.text.trim().length >= 3 &&
          state.nameController.text.trim() != state.editTeam?.name) {
        final searchName = state.nameController.text.caseAndSpaceInsensitive;
        final isAvailable = await _teamService.isTeamNameAvailable(searchName);
        state = state.copyWith(
            isNameAvailable:
                isAvailable || state.editTeam?.name_lowercase == searchName,
            checkingForAvailability: false);
      } else {
        state = state.copyWith(
            isNameAvailable: null, checkingForAvailability: false);
      }

      onValueChange();
    });
  }

  Future<void> deleteUnusedImage(String imgUrl) async {
    try {
      await _fileUploadService.deleteUploadedImage(imgUrl);
    } catch (e) {
      debugPrint(
          "AddTeamViewNotifier: error while deleting Unused Image -> $e");
    }
  }

  Future<void> onRemoveUserFromTeam(UserModel user) async {
    final updatedList = state.teamMembers.toList();
    updatedList.removeWhere((element) => element.id == user.id);
    state = state.copyWith(teamMembers: updatedList);
    onValueChange();
  }

  Future<void> onTeamDelete() async {
    if (state.editTeam == null) {
      return;
    }
    state = state.copyWith(actionError: null);
    try {
      final teamProfileImageUrl = state.editTeam!.profile_img_url;

      await _teamService.deleteTeam(state.editTeam!.id ?? "INVALID ID");
      state = state.copyWith(isPop: true);

      if (teamProfileImageUrl != null) {
        await deleteUnusedImage(teamProfileImageUrl);
      }
    } catch (e) {
      state = state.copyWith(actionError: e);
      debugPrint("AddTeamViewNotifier: error while delete team -> $e");
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

@freezed
class AddTeamState with _$AddTeamState {
  const factory AddTeamState({
    required TextEditingController nameController,
    required TextEditingController locationController,
    Object? actionError,
    String? filePath,
    bool? isNameAvailable,
    TeamModel? team,
    TeamModel? editTeam,
    UserModel? currentUser,
    @Default(false) bool isImageUploading,
    @Default(true) bool isAddMeCheckBoxEnable,
    @Default(false) bool checkingForAvailability,
    @Default(false) bool isAddBtnEnable,
    @Default(false) bool isAddInProgress,
    @Default(false) bool isPop,
    @Default([]) List<UserModel> teamMembers,
  }) = _AddTeamState;
}
