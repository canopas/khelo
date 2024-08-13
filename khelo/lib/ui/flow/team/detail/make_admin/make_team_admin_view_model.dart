import 'package:data/api/team/team_model.dart';
import 'package:data/service/team/team_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'make_team_admin_view_model.freezed.dart';

final makeTeamAdminStateProvider = StateNotifierProvider.autoDispose<
        MakeTeamAdminViewNotifier, MakeTeamAdminState>(
    (ref) => MakeTeamAdminViewNotifier(ref.read(teamServiceProvider)));

class MakeTeamAdminViewNotifier extends StateNotifier<MakeTeamAdminState> {
  final TeamService _teamService;

  MakeTeamAdminViewNotifier(this._teamService)
      : super(const MakeTeamAdminState());

  late String _teamId;
  late List<TeamPlayer> _players;

  void setData({
    required String teamId,
    required List<TeamPlayer> players,
  }) {
    _teamId = teamId;
    _players = players;
    final admins = players
        .where((element) => element.role == TeamPlayerRole.admin)
        .toList();
    state = state.copyWith(selectedPlayers: admins);
  }

  void selectAdmin(TeamPlayer player) {
    final admins = state.selectedPlayers.toList();
    (admins.contains(player)) ? admins.remove(player) : admins.add(player);
    state = state.copyWith(selectedPlayers: admins, isButtonEnabled: true);
  }

  void onSave() async {
    try {
      final players = _players.map((player) {
        final role = state.selectedPlayers.contains(player)
            ? TeamPlayerRole.admin
            : TeamPlayerRole.player;
        return player.copyWith(role: role);
      }).toList();

      await _teamService.editPlayersToTeam(_teamId, players);
      state = state.copyWith(pop: true, actionError: null);
    } catch (e) {
      state = state.copyWith(pop: false, actionError: e);
      debugPrint("MakeTeamAdminViewNotifier: error while making admins -> $e");
    }
  }
}

@freezed
class MakeTeamAdminState with _$MakeTeamAdminState {
  const factory MakeTeamAdminState({
    Object? actionError,
    @Default(false) bool pop,
    @Default(false) bool isButtonEnabled,
    @Default([]) List<TeamPlayer> selectedPlayers,
  }) = _MakeTeamAdminState;
}
