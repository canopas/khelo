import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_squad_view_model.freezed.dart';

final selectSquadStateProvider = StateNotifierProvider.autoDispose<
    SelectSquadViewNotifier, SelectSquadViewState>((ref) {
  return SelectSquadViewNotifier();
});

class SelectSquadViewNotifier extends StateNotifier<SelectSquadViewState> {
  SelectSquadViewNotifier() : super(const SelectSquadViewState());

  void setData(
    TeamModel team,
    List<MatchPlayer> squad,
    String? captainId,
    String? adminId,
  ) {
    state = state.copyWith(
        team: team,
        squad: squad,
        isDoneBtnEnable: squad.length >= 2,
        isOkayBtnEnable: captainId != null && adminId != null,
        captainId: captainId,
        adminId: adminId);
  }

  void removeFromSquad(UserModel user) {
    final updatedList = state.squad.toList();
    updatedList.removeWhere((element) => element.player.id == user.id);
    final captainId =
        updatedList.map((e) => e.player.id).contains(state.captainId)
            ? state.captainId
            : null;
    final adminId = updatedList.map((e) => e.player.id).contains(state.adminId)
        ? state.adminId
        : null;
    state = state.copyWith(
        squad: updatedList, captainId: captainId, adminId: adminId);
    _onSquadChange();
  }

  void addToSquad(MatchPlayer user) {
    state = state.copyWith(squad: [...state.squad, user]);
    _onSquadChange();
  }

  void onCaptainOrAdminSelect(PlayerMatchRole role, String id) {
    switch (role) {
      case PlayerMatchRole.captain:
        state = state.copyWith(captainId: id);
      case PlayerMatchRole.admin:
        state = state.copyWith(adminId: id);
    }
    _onSelectionChange();
  }

  void _onSquadChange() {
    state = state.copyWith(isDoneBtnEnable: state.squad.length >= 2);
    _onSelectionChange();
  }

  void _onSelectionChange() {
    final isEnable = state.captainId != null && state.adminId != null;
    state = state.copyWith(isOkayBtnEnable: isEnable);
  }
}

@freezed
class SelectSquadViewState with _$SelectSquadViewState {
  const factory SelectSquadViewState({
    TeamModel? team,
    String? captainId,
    String? adminId,
    @Default(false) bool isOkayBtnEnable,
    @Default(false) bool isDoneBtnEnable,
    @Default([]) List<MatchPlayer> squad,
  }) = _SelectSquadViewState;
}
