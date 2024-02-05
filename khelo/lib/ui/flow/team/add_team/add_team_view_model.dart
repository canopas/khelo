import 'dart:async';

import 'package:data/api/user/user_models.dart';
import 'package:data/service/file_upload/file_upload_service.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

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
    state =
        state.copyWith(imageUrl: editTeam?.profile_img_url, editTeam: editTeam);
  }

  void _updateUser(UserModel? user) {
    state = state.copyWith(currentUser: user);
  }

  Future<void> updatePlayersList(List<UserModel> players) async {
    if (state.editTeam == null) {
      return;
    }
    // final team =
    //     await _teamService.getTeamById(state.editTeam!.id ?? "INVALID ID");
    // final filteredPlayers = team.players
    //     ?.where((element) => !state.memberToDelete.contains(element.id))
    //     .toList();
    state = state.copyWith(
        editTeam: state.editTeam
            ?.copyWith(players: [...?state.editTeam?.players, ...players]));
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

      TeamModel team = TeamModel(
          id: state.editTeam?.id ?? const Uuid().v4(),
          name: name,
          name_lowercase: name.toLowerCase().replaceAll(RegExp(r'\s+'), ""),
          profile_img_url: state.imageUrl,
          city: location.toLowerCase(),
          created_by: state.currentUser!.id,
          created_at: state.editTeam?.created_at ?? DateTime.now());

      await _teamService.updateTeam(team, players);

      if (previousImageUrl != null) {
        await deleteUnusedImage(previousImageUrl);
      }
      if (state.editTeam != null) {
        final filterList = state.memberToDelete
            .where((element) => !(state.editTeam!.players ?? [])
                .map((e) => e.id)
                .contains(element))
            .toList();

        await _teamService.removePlayersFromTeam(
            team.id ?? "INVALID ID", filterList);

        state = state.copyWith(isAddInProgress: false, isPop: true);
      } else {
        state = state.copyWith(
            isAddInProgress: false, team: team.copyWith(players: players));
      }
    } catch (e) {
      state = state.copyWith(isAddInProgress: false);
      debugPrint("AddTeamViewNotifier: error while adding team detail -> $e");
    }
  }

  Future<void> onValueChange() async {
    final searchName =
        state.nameController.text.trim().replaceAll(RegExp(r'\s+'), "");
    final isAvailable = await _teamService.isTeamNameAvailable(searchName);
    state = state.copyWith(
        isNameAvailable: isAvailable ||
            state.editTeam?.name_lowercase == searchName.toLowerCase());

    final isEnable = state.nameController.text.trim().length >= 3 &&
        state.locationController.text.trim().length >= 3 &&
        state.isNameAvailable == true;
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
      if (state.nameController.text.trim().length >= 3) {
        final searchName =
            state.nameController.text.trim().replaceAll(RegExp(r'\s+'), "");
        final isAvailable = await _teamService.isTeamNameAvailable(searchName);
        state = state.copyWith(
            isNameAvailable: isAvailable ||
                state.editTeam?.name_lowercase == searchName.toLowerCase(),
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
    final updatedList = state.editTeam?.players?.toList();
    if (updatedList == null) {
      return;
    }
    updatedList.removeWhere((element) => element.id == user.id);

    // add only if not contain already
    final deleteMember = state.memberToDelete.contains(user.id)
        ? state.memberToDelete
        : [...state.memberToDelete, user.id];
    state = state.copyWith(
        editTeam: state.editTeam?.copyWith(players: updatedList),
        memberToDelete: deleteMember);
    onValueChange();
  }

  Future<void> onTeamDelete() async {
    try {
      String? teamProfileImageUrl;
      String? currentImageUrl;
      if (state.imageUrl != null) {
        if (state.imageUrl != state.editTeam?.profile_img_url &&
            state.editTeam?.profile_img_url != null) {
          teamProfileImageUrl = state.editTeam!.profile_img_url!;
        }
        currentImageUrl = state.imageUrl!;
      } else {
        if (state.editTeam?.profile_img_url != null) {
          teamProfileImageUrl = state.editTeam!.profile_img_url!;
        }
      }

      await _teamService
          .deleteTeamWithCollection(state.editTeam?.id ?? "INVALID ID");
      state = state.copyWith(isPop: true);

      if (teamProfileImageUrl != null) {
        await deleteUnusedImage(teamProfileImageUrl);
      }
      if (currentImageUrl != null) {
        await deleteUnusedImage(currentImageUrl);
      } // do not merge above both if-conditions in if-else or any other control-flow, at a time both variable may have non-null value
    } catch (e) {
      debugPrint("EditProfileViewNotifier: error while delete account -> $e");
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
    @Default(null) String? imageUrl,
    @Default(false) bool isImageUploading,
    @Default(null) bool? isNameAvailable,
    @Default(true) bool isAddMeCheckBoxEnable,
    @Default(false) bool checkingForAvailability,
    @Default(false) bool isAddBtnEnable,
    @Default(false) bool isAddInProgress,
    @Default(false) bool isPop,
    @Default([]) List<String> memberToDelete,
    @Default(null) TeamModel? team,
    @Default(null) TeamModel? editTeam,
    UserModel? currentUser,
  }) = _AddTeamState;
}
