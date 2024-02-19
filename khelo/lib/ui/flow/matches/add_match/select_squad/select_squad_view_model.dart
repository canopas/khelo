import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/extensions/list_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_squad_view_model.freezed.dart';

final selectSquadStateProvider = StateNotifierProvider.autoDispose<
    SelectSquadViewNotifier, SelectSquadViewState>((ref) {
  return SelectSquadViewNotifier();
});

class SelectSquadViewNotifier extends StateNotifier<SelectSquadViewState> {
  SelectSquadViewNotifier() : super(const SelectSquadViewState());

  void setData(TeamModel team, List<MatchPlayer> squad) {
    state = state.copyWith(
        team: team, squad: squad, isDoneBtnEnable: squad.isNotEmpty);
  }

  void removeFromSquad(UserModel user) {
    final updatedList = state.squad.toList();
    updatedList.removeWhere((element) => element.player.id == user.id);
    state = state.copyWith(squad: updatedList);
    onSquadChange();
  }

  void addToSquad(MatchPlayer user) {
    state = state.copyWith(squad: [...state.squad, user]);
    onSquadChange();
  }

  void onCaptainOrAdminSelect(PlayerMatchRole role, String id) {
    state = state.copyWith(
        squad: state.squad.updateWhere(
      where: (element) => element.role.contains(role),
      updated: (oldElement) {
        final roles = oldElement.role.toList();
        roles.remove(role);
        return oldElement.copyWith(role: roles);
      },
    ));

    state = state.copyWith(
        squad: state.squad.updateWhere(
      where: (element) => element.player.id == id,
      updated: (oldElement) {
        final roles = oldElement.role.toList();
        roles.add(role);
        return oldElement.copyWith(role: roles);
      },
    ));
    onSelectionChange();
  }

  void onSquadChange() {
    state = state.copyWith(isDoneBtnEnable: state.squad.isNotEmpty);
  }

  void onSelectionChange() {
    final flattenList = state.squad.expand((e) => e.role).toList();
    final isEnable = flattenList.contains(PlayerMatchRole.captain) &&
        flattenList.contains(PlayerMatchRole.admin);
    state = state.copyWith(isOkayBtnEnable: isEnable);
  }
}

@freezed
class SelectSquadViewState with _$SelectSquadViewState {
  const factory SelectSquadViewState({
    Object? error,
    TeamModel? team,
    @Default(false) bool isOkayBtnEnable,
    @Default(false) bool isDoneBtnEnable,
    @Default([]) List<MatchPlayer> squad,
  }) = _SelectSquadViewState;
}

