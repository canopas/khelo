import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/action_bottom_sheet.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/widget_extension.dart';

import 'package:khelo/ui/flow/tournament/detail/members/tournament_detail_members_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/error_snackbar.dart';
import '../../../matches/add_match/match_officials/search_user/search_user_screen.dart';

class TournamentDetailMembersScreen extends ConsumerStatefulWidget {
  final TournamentModel tournament;

  const TournamentDetailMembersScreen({
    super.key,
    required this.tournament,
  });

  @override
  ConsumerState<TournamentDetailMembersScreen> createState() =>
      _TournamentDetailMembersScreenState();
}

class _TournamentDetailMembersScreenState
    extends ConsumerState<TournamentDetailMembersScreen> {
  late TournamentDetailMembersViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(tournamentDetailMembersStateProvider.notifier);
    runPostFrame(() => notifier.setData(widget.tournament.members));
  }

  void _observeActionError(BuildContext context, WidgetRef ref) {
    ref.listen(
        tournamentDetailMembersStateProvider
            .select((value) => value.actionError), (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _observeActionError(context, ref);

    final state = ref.watch(tournamentDetailMembersStateProvider);

    return AppPage(
      title: context.l10n.tournament_detail_members_title,
      actions: state.currentUserId == widget.tournament.created_by
          ? [
              actionButton(
                context,
                icon: Icon(
                  Icons.add,
                  color: context.colorScheme.textPrimary,
                ),
                onPressed: () async {
                  final user = await SearchUserBottomSheet.show<UserModel>(
                    context,
                    emptyScreenTitle: context
                        .l10n.tournament_members_search_member_empty_title,
                    emptyScreenDescription: context.l10n
                        .tournament_members_search_member_empty_description,
                  );

                  if (user != null && mounted) {
                    notifier.addTournamentMember(widget.tournament.id, user);
                  }
                },
              )
            ]
          : null,
      body: Builder(builder: (context) {
        return Padding(
          padding: context.mediaQueryPadding,
          child: _body(context, state),
        );
      }),
    );
  }

  Widget _body(BuildContext context, TournamentDetailMembersState state) {
    if (state.members.isEmpty) {
      return EmptyScreen(
        title: context.l10n.tournament_members_empty_title,
        description: context.l10n.tournament_members_empty_description,
        isShowButton: false,
      );
    }
    final currentUserRole = state.members
        .firstWhere(
          (element) => element.id == state.currentUserId,
        )
        .role;

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16),
      itemCount: state.members.length,
      itemBuilder: (context, index) {
        return OnTapScale(
            onTap: () {
              _showActionSheet(
                context,
                member: state.members[index],
                currentUserRole: currentUserRole,
                currentUserId: state.currentUserId,
                tournament: widget.tournament,
              );
            },
            child: _memberCellView(context, state.members[index]));
      },
      separatorBuilder: (context, index) => Divider(
        color: context.colorScheme.outline,
      ),
    );
  }

  Widget _memberCellView(BuildContext context, TournamentMember member) {
    return Material(
        type: MaterialType.transparency,
        child: ListTile(
          leading: ImageAvatar(
            initial: member.user.nameInitial,
            imageUrl: member.user.profile_img_url,
            size: 40,
          ),
          title: Text(
            member.user.name ?? '',
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          subtitle: Text(
            member.role.name,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textSecondary),
          ),
          trailing: widget.tournament.created_by == member.id
              ? Text(
                  context.l10n.common_owner,
                  style: AppTextStyle.body2.copyWith(
                    color: context.colorScheme.primary,
                  ),
                )
              : null,
        ));
  }

  void _showActionSheet(
    BuildContext context, {
    required TournamentMember member,
    required TournamentMemberRole currentUserRole,
    required String? currentUserId,
    required TournamentModel tournament,
  }) async {
    if (currentUserRole == TournamentMemberRole.admin &&
        member.id == tournament.created_by) {
      return;
    }

    bool isOwner = currentUserId == tournament.created_by;
    bool isSelf = currentUserId == member.id;

    List<TournamentMemberActionType> availableActions = [];

    if (isSelf && !isOwner) {
      availableActions.add(TournamentMemberActionType.removeSelf);
    }

    if (isOwner) {
      if (isSelf) {
        availableActions.add(TournamentMemberActionType.transferOwnership);
      } else if (member.role == TournamentMemberRole.admin) {
        availableActions.add(TournamentMemberActionType.makeOrganizer);
        availableActions.add(TournamentMemberActionType.removeMember);
      } else {
        availableActions.add(TournamentMemberActionType.makeAdmin);
        availableActions.add(TournamentMemberActionType.removeMember);
      }
    } else if (currentUserRole == TournamentMemberRole.organizer) {
      if (member.role != TournamentMemberRole.admin) {
        availableActions.add(TournamentMemberActionType.makeAdmin);
        availableActions.add(TournamentMemberActionType.removeMember);
      }
    }

    List<BottomSheetAction> actions = availableActions.map((actionType) {
      return BottomSheetAction(
        title: actionType.getString(context),
        onTap: () async {
          context.pop();
          if (actionType == TournamentMemberActionType.transferOwnership) {
            final newOwner = await SearchUserBottomSheet.show<UserModel>(
              context,
              emptyScreenTitle: context.l10n.common_transfer_ownership,
              emptyScreenDescription: context
                  .l10n.tournament_members_transfer_ownership_description,
            );
            if (context.mounted && newOwner != null) {
              notifier.handleMemberAction(
                tournamentId: tournament.id,
                member: member,
                newOwner: newOwner,
                action: actionType,
              );
              context.pop();
            }
          } else {
            notifier.handleMemberAction(
              tournamentId: tournament.id,
              member: member,
              action: actionType,
            );
          }
        },
      );
    }).toList();

    return showActionBottomSheet(context: context, items: actions);
  }
}
