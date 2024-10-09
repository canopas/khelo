import 'dart:async';

import 'package:data/api/team/team_model.dart';
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
  TeamModel? _team;

  AddTeamMemberViewNotifier(
    this._userService,
    this._teamService,
  ) : super(AddTeamMemberState(searchController: TextEditingController()));

  void setData(TeamModel team) {
    _team = team;
  }

  Future<void> _search(String searchKey) async {
    try {
      if (searchKey.isEmpty) {
        state = state.copyWith(searchedUsers: []);
        return;
      }
      final users = await _userService.searchUser(searchKey);
      state = state.copyWith(searchedUsers: users, error: null);
    } catch (e) {
      state = state.copyWith(error: e);
      debugPrint("AddTeamMemberViewNotifier: error while search players -> $e");
    }
  }

  void onSearchChanged() {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      _search(state.searchController.text.trim());
    });
  }

  void selectUser(UserModel user) {
    final role = (_team?.created_by == user.id)
        ? TeamPlayerRole.admin
        : TeamPlayerRole.player;
    final player = TeamPlayer(id: user.id, role: role, user: user);
    state = state.copyWith(selectedUsers: [...state.selectedUsers, player]);
  }

  void unSelectUser(UserModel user) {
    final updatedList = state.selectedUsers.toList();
    updatedList.removeWhere((element) => element.id == user.id);
    state = state.copyWith(selectedUsers: updatedList);
  }

  Future<void> addPlayersToTeam() async {
    state = state.copyWith(isAddInProgress: true, actionError: null);
    try {
      await _teamService.addPlayersToTeam(_team?.id ?? '', state.selectedUsers);
      state = state.copyWith(isAddInProgress: false, isAdded: true);
    } catch (e) {
      state = state.copyWith(isAddInProgress: false, actionError: e);
      debugPrint(
          "AddTeamMemberViewNotifier: error while adding players to team -> $e");
    }
  }

  List<String> getMemberIds() {
    var memberIds = _team?.players.map((e) => e.id).toList() ?? [];
    memberIds.addAll(state.selectedUsers.map((e) => e.id));
    return memberIds;
  }

  @override
  void dispose() {
    state.searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}

@freezed
class AddTeamMemberState with _$AddTeamMemberState {
  const factory AddTeamMemberState({
    required TextEditingController searchController,
    Object? error,
    Object? actionError,
    @Default([]) List<UserModel> searchedUsers,
    @Default([]) List<TeamPlayer> selectedUsers,
    @Default(false) bool isAdded,
    @Default(false) bool isAddInProgress,
  }) = _AddTeamMemberState;
}
