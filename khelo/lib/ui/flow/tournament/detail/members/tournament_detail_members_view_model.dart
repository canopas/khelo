import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/extensions/list_extensions.dart';
import 'package:data/service/tournament/tournament_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

part 'tournament_detail_members_view_model.freezed.dart';

final tournamentDetailMembersStateProvider = StateNotifierProvider.autoDispose<
    TournamentDetailMembersViewNotifier, TournamentDetailMembersState>((ref) {
  final notifier = TournamentDetailMembersViewNotifier(
    ref.read(tournamentServiceProvider),
    ref.read(currentUserPod)?.id,
  );
  ref.listen(currentUserPod, (previous, next) {
    notifier._setUserId(next?.id);
  });
  return notifier;
});

class TournamentDetailMembersViewNotifier
    extends StateNotifier<TournamentDetailMembersState> {
  final TournamentService _tournamentService;

  TournamentDetailMembersViewNotifier(this._tournamentService, String? userId)
      : super(TournamentDetailMembersState(currentUserId: userId));

  void setData(List<TournamentMember> members) {
    state = state.copyWith(members: members);
  }

  void _setUserId(String? userId) {
    state = state.copyWith(currentUserId: userId);
  }

  void addTournamentMember(String tournamentId, UserModel user) async {
    try {
      final member = TournamentMember(
        id: user.id,
        role: TournamentMemberRole.admin,
      );

      final members = {...state.members, member.copyWith(user: user)}.toList();

      await _tournamentService.updateTournamentMembers(tournamentId, members);

      state = state.copyWith(members: members);
    } catch (error) {
      state = state.copyWith(actionError: error);
      debugPrint(
          "TournamentDetailMembersViewNotifier: error while adding tournament member -> $error");
    }
  }

  void handleMemberAction({
    required String tournamentId,
    required TournamentMember member,
    UserModel? newOwner,
    required TournamentMemberActionType action,
  }) async {
    switch (action) {
      case TournamentMemberActionType.removeSelf:
      case TournamentMemberActionType.removeMember:
        _removeTournamentMember(tournamentId, member);
        break;

      case TournamentMemberActionType.makeAdmin:
        _updateMemberRole(tournamentId, member, TournamentMemberRole.admin);
        break;

      case TournamentMemberActionType.makeOrganizer:
        _updateMemberRole(tournamentId, member, TournamentMemberRole.organizer);
        break;

      case TournamentMemberActionType.transferOwnership:
        if (newOwner != null) {
          _changeTournamentOwner(tournamentId, member, newOwner);
        }
        break;
    }
  }

  void _removeTournamentMember(
      String tournamentId, TournamentMember member) async {
    try {
      await _tournamentService.removeTournamentMember(tournamentId, member);
      final members = state.members.toList();
      members.removeWhere((element) => element.id == member.id);

      state = state.copyWith(members: members);
    } catch (error) {
      state = state.copyWith(actionError: error);
      debugPrint(
          "TournamentDetailMembersViewNotifier: error while removing tournament member -> $error");
    }
  }

  void _updateMemberRole(
    String tournamentId,
    TournamentMember member,
    TournamentMemberRole role,
  ) async {
    try {
      final members = state.members.toList().updateWhere(
            where: (element) => element.id == member.id,
            updated: (element) => element.copyWith(role: role),
          );

      await _tournamentService.updateTournamentMembers(tournamentId, members);

      state = state.copyWith(members: members);
    } catch (error) {
      state = state.copyWith(actionError: error);
      debugPrint(
          "TournamentDetailMembersViewNotifier: error while updating tournament member role-> $error");
    }
  }

  void _changeTournamentOwner(
    String tournamentId,
    TournamentMember oldOwner,
    UserModel newOwnerUser,
  ) async {
    try {
      final newOwner = TournamentMember(
        id: newOwnerUser.id,
        role: TournamentMemberRole.organizer,
      );

      final members = state.members.toList();
      members.removeWhere(
          (member) => member.id == oldOwner.id || member.id == newOwnerUser.id);
      members.add(newOwner.copyWith(user: newOwnerUser));

      await _tournamentService.changeTournamentOwner(
          tournamentId, newOwner.id, members);

      state = state.copyWith(members: members);
    } catch (error) {
      state = state.copyWith(actionError: error);
      debugPrint(
        "TournamentDetailMembersViewNotifier: error while changing tournament owner -> $error",
      );
    }
  }
}

@freezed
class TournamentDetailMembersState with _$TournamentDetailMembersState {
  const factory TournamentDetailMembersState({
    Object? actionError,
    String? currentUserId,
    @Default([]) List<TournamentMember> members,
  }) = _TournamentDetailMembersState;
}

enum TournamentMemberActionType {
  removeSelf,
  transferOwnership,
  makeOrganizer,
  removeMember,
  makeAdmin;

  String getString(BuildContext context) {
    switch (this) {
      case TournamentMemberActionType.removeSelf:
        return context.l10n.tournament_members_remove_self;
      case TournamentMemberActionType.transferOwnership:
        return context.l10n.common_transfer_ownership;
      case TournamentMemberActionType.makeOrganizer:
        return context.l10n.tournament_members_make_organizer;
      case TournamentMemberActionType.removeMember:
        return context.l10n.tournament_members_remove_member;
      case TournamentMemberActionType.makeAdmin:
        return context.l10n.common_make_admin;
    }
  }
}
