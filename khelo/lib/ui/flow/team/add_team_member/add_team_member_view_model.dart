import 'dart:async';

import 'package:data/api/user/user_models.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/service/user/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_team_member_view_model.freezed.dart';

final addTeamMemberStateProvider = StateNotifierProvider.autoDispose<
    AddTeamMemberViewNotifier, AddTeamMemberState>((ref) {
  return AddTeamMemberViewNotifier(
    ref.read(userServiceProvider),
    ref.read(teamServiceProvider),
  );
});

class AddTeamMemberViewNotifier extends StateNotifier<AddTeamMemberState> {
  final UserService _userService;
  final TeamService _teamService;
  Timer? _debounce;

  AddTeamMemberViewNotifier(this._userService, this._teamService)
      : super(AddTeamMemberState(
            searchController: TextEditingController(),
            verifyNumberController: TextEditingController()));

  Future<void> search(String searchKey) async {
    final users = await _userService.searchUser(searchKey);
    state = state.copyWith(searchedUsers: users);
  }

  void onSearchChanged(String value) {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (state.searchController.text.isNotEmpty) {
        search(state.searchController.text.trim());
      }
    });
  }

  void selectUser(UserModel user) {
    state = state.copyWith(selectedUsers: [...state.selectedUsers, user]);
  }

  void unSelectUser(UserModel user) {
    final updatedList = state.selectedUsers.toList();
    updatedList.removeWhere((element) => element.id == user.id);
    state = state.copyWith(selectedUsers: updatedList);
  }

  void addPlayersToTeam(String id) {
    _teamService.addPlayersToTeam(id, state.selectedUsers);
    state = state.copyWith(isAdded: true);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

@freezed
class AddTeamMemberState with _$AddTeamMemberState {
  const factory AddTeamMemberState({
    required TextEditingController searchController,
    required TextEditingController verifyNumberController,
    @Default([]) List<UserModel> searchedUsers,
    @Default([]) List<UserModel> selectedUsers,
    Object? error,
    @Default(false) bool isAdded,
  }) = _AddTeamMemberState;
}
