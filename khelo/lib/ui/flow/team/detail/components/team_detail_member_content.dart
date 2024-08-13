import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../matches/add_match/select_squad/components/user_detail_sheet.dart';

class TeamDetailMemberContent extends ConsumerWidget {
  const TeamDetailMemberContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamDetailStateProvider);

    if (state.team?.players != null && state.team?.players.isNotEmpty == true) {
      return Column(
        children: [
          if (state.team?.players.any((element) =>
                  element.id == state.currentUserId &&
                  element.role == TeamPlayerRole.admin) ==
              true) ...[
            _addMemberButton(
              context,
              onTap: () =>
                  AppRoute.addTeamMember(team: state.team!).push(context),
            ),
          ],
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: state.team!.players.length,
              itemBuilder: (context, index) {
                final member = state.team!.players[index].user!;
                return UserDetailCell(
                    user: member,
                    onTap: () => UserDetailSheet.show(context, member),
                    showPhoneNumber: false);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          ),
        ],
      );
    } else {
      return EmptyScreen(
        title: context.l10n.team_detail_empty_member_title,
        description: state.team!.created_by == state.currentUserId
            ? context.l10n.team_detail_empty_member_description_text
            : context.l10n.team_detail_visitor_empty_member_description_text,
        isShowButton: state.team!.created_by == state.currentUserId,
        buttonTitle: context.l10n.team_list_add_members_title,
        onTap: () => AppRoute.addTeamMember(team: state.team!).push(context),
      );
    }
  }

  Widget _addMemberButton(BuildContext context, {required Function() onTap}) {
    return OnTapScale(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: context.colorScheme.containerLow,
              child: Icon(
                Icons.add,
                size: 24,
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              context.l10n.team_detail_add_member_title,
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.primary),
            )
          ],
        ),
      ),
    );
  }
}
