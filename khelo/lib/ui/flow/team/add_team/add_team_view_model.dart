import 'dart:async';

import 'package:data/api/user/user_models.dart';
import 'package:data/extensions/string_extensions.dart';
import 'package:data/service/file_upload/file_upload_service.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
        imageUrl: editTeam?.profile_img_url,
        editTeam: editTeam,
        teamMembers: editTeam?.players ?? []);
  }

  void _updateUser(UserModel? user) {
    state = state.copyWith(currentUser: user);
  }

  Future<void> updatePlayersList(List<UserModel> players) async {
    if (state.editTeam == null) {
      return;
    }
    state = state.copyWith(teamMembers: [...state.teamMembers, ...players]);
    onValueChange();
  }

  void onAddMeCheckBoxTap() {
    state = state.copyWith(isAddMeCheckBoxEnable: !state.isAddMeCheckBoxEnable);
  }

  Future<void> onImageSelect(String imagePath) async {
    try {
      state = state.copyWith(isImageUploading: true);
      final imageUrl = await _fileUploadService.uploadProfileImage(
          imagePath, ImageUploadType.team);
      final prevUrl = state.imageUrl;

      if (prevUrl != null && prevUrl != state.editTeam?.profile_img_url) {
        await deleteUnusedImage(prevUrl);
      }
      state = state.copyWith(imageUrl: imageUrl, isImageUploading: false);
      onValueChange();
    } catch (e) {
      state = state.copyWith(isImageUploading: false);
      debugPrint("AddTeamViewNotifier: error while image upload -> $e");
    }
  }

  Future<void> onBackBtnPressed() async {
    if (state.imageUrl != state.editTeam?.profile_img_url &&
        state.imageUrl != null) {
      await deleteUnusedImage(state.imageUrl!);
    }
  }

  Future<void> onAddBtnTap() async {
    try {
      state = state.copyWith(isAddInProgress: true);
      final String? previousImageUrl;
      if (state.editTeam?.profile_img_url != null &&
          state.imageUrl != state.editTeam?.profile_img_url) {
        previousImageUrl = state.editTeam!.profile_img_url!;
      } else {
        previousImageUrl = null;
      }

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

      AddTeamRequestModel team = AddTeamRequestModel(
          id: state.editTeam?.id,
          name: name,
          name_lowercase: name.caseAndSpaceInsensitive,
          profile_img_url: state.imageUrl,
          city: location.toLowerCase(),
          created_by: state.currentUser!.id,
          players: players.map((e) => e.id).toList(),
          created_at: state.editTeam?.created_at ?? DateTime.now());

      await _teamService.updateTeam(team);

      if (previousImageUrl != null) {
        await deleteUnusedImage(previousImageUrl);
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
            id: state.editTeam?.id,
            name: name,
            name_lowercase: name.caseAndSpaceInsensitive,
            profile_img_url: state.imageUrl,
            city: location.toLowerCase(),
            created_by: state.currentUser!.id,
            players: players,
            created_at: state.editTeam?.created_at ?? DateTime.now());
        state = state.copyWith(isAddInProgress: false, team: teamModel);
      }
    } catch (e) {
      state = state.copyWith(isAddInProgress: false);
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

    try {
      String? teamProfileImageUrl;
      String? currentImageUrl;
      if (state.imageUrl != null) {
        if (state.imageUrl != state.editTeam!.profile_img_url &&
            state.editTeam!.profile_img_url != null) {
          teamProfileImageUrl = state.editTeam!.profile_img_url!;
        }
        currentImageUrl = state.imageUrl!;
      } else {
        if (state.editTeam!.profile_img_url != null) {
          teamProfileImageUrl = state.editTeam!.profile_img_url!;
        }
      }

      await _teamService.deleteTeam(state.editTeam!.id ?? "INVALID ID");
      state = state.copyWith(isPop: true);

      if (teamProfileImageUrl != null) {
        await deleteUnusedImage(teamProfileImageUrl);
      }
      if (currentImageUrl != null) {
        await deleteUnusedImage(currentImageUrl);
      } // do not merge above both if-conditions in if-else or any other control-flow, at a time both variable may have non-null value
    } catch (e) {
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
    @Default(false) bool isImageUploading,
    @Default(true) bool isAddMeCheckBoxEnable,
    @Default(false) bool checkingForAvailability,
    @Default(false) bool isAddBtnEnable,
    @Default(false) bool isAddInProgress,
    @Default(false) bool isPop,
    @Default([]) List<UserModel> teamMembers,
    String? imageUrl,
    bool? isNameAvailable,
    TeamModel? team,
    TeamModel? editTeam,
    UserModel? currentUser,
  }) = _AddTeamState;
}
