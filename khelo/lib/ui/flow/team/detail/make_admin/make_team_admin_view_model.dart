import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/service/team/team_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'make_team_admin_view_model.freezed.dart';

final makeTeamAdminStateProvider = StateNotifierProvider.autoDispose<
    MakeTeamAdminViewNotifier, MakeTeamAdminState>((ref) {
  final notifier = MakeTeamAdminViewNotifier(
    ref.read(teamServiceProvider),
    ref.read(currentUserPod)?.id,
  );
  ref.listen(currentUserPod, (previous, next) => notifier.setUserId(next?.id));
  return notifier;
});

class MakeTeamAdminViewNotifier extends StateNotifier<MakeTeamAdminState> {
  final TeamService _teamService;
  late TeamModel team;

  MakeTeamAdminViewNotifier(this._teamService, String? userId)
      : super(MakeTeamAdminState(currentUserId: userId));

  void setUserId(String? userId) {
    state = state.copyWith(currentUserId: userId);
  }

  void setData(TeamModel team) {
    this.team = team;
    final admins = team.players
        .where((element) => element.role == TeamPlayerRole.admin)
        .map((e) => e.id)
        .toList();

    final members = team.players
        .where((element) => element.id != team.created_by)
        .map((e) => e.user)
        .toList();

    final owner = team.players
        .firstWhere((element) => element.id == team.created_by,
            orElse: () => TeamPlayer(
                  id: team.created_by_user.id,
                  user: team.created_by_user,
                ))
        .user;

    state = state.copyWith(
        selectedPlayerIds: admins, players: members, owner: owner);
  }

  void selectAdmin(UserModel player) {
    state = state.copyWith(showSelectionError: false);
    final admins = state.selectedPlayerIds.toList();

    // Do not allow to select Deactivated user but allow to deselect them.
    if (!player.isActive && !admins.contains(player.id)) {
      state = state.copyWith(showSelectionError: true);
      return;
    }

    (admins.contains(player.id))
        ? admins.remove(player.id)
        : admins.add(player.id);

    state = state.copyWith(
        selectedPlayerIds: admins, isButtonEnabled: admins.isNotEmpty);
  }

  void onSave() async {
    try {
      state = state.copyWith(actionError: null);
      final players = team.players.map((player) {
        final role = state.selectedPlayerIds.contains(player.id)
            ? TeamPlayerRole.admin
            : TeamPlayerRole.player;
        return player.copyWith(role: role);
      }).toList();

      await _teamService.editPlayersToTeam(team.id, state.owner.id, players);
      state = state.copyWith(pop: true, actionError: null);
    } catch (e) {
      state = state.copyWith(pop: false, actionError: e);
      debugPrint("MakeTeamAdminViewNotifier: error while making admins -> $e");
    }
  }

  void changeTeamOwner(UserModel newOwner) {
    final currentOwner = state.owner;
    final player = state.players.toList();

    final allPlayers = team.players.map((player) => player.id).toList();
    if (allPlayers.contains(currentOwner.id) &&
        !player.contains(currentOwner)) {
      player.add(currentOwner);
    }
    if (player.contains(newOwner)) {
      player.remove(newOwner);
    }
    state = state.copyWith(
        owner: newOwner,
        players: player,
        isButtonEnabled: state.selectedPlayerIds.isNotEmpty);
  }
}

@freezed
class MakeTeamAdminState with _$MakeTeamAdminState {
  const factory MakeTeamAdminState({
    Object? actionError,
    String? currentUserId,
    @Default(false) bool pop,
    @Default(false) bool isButtonEnabled,
    @Default(false) bool showSelectionError,
    @Default(UserModel(id: '')) UserModel owner,
    @Default([]) List<UserModel> players,
    @Default([]) List<String> selectedPlayerIds,
  }) = _MakeTeamAdminState;
}
