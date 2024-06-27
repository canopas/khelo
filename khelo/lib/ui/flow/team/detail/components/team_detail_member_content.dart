import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/empty_screen.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_view_model.dart';
import 'package:style/extensions/context_extensions.dart';

import '../../../../app_route.dart';
import '../../../matches/add_match/select_squad/components/user_detail_sheet.dart';

class TeamDetailMemberContent extends ConsumerWidget {
  const TeamDetailMemberContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamDetailStateProvider);

    if (state.team?.players != null &&
        state.team?.players?.isNotEmpty == true) {
      return ListView.separated(
        padding: context.mediaQueryPadding + const EdgeInsets.all(16),
        itemCount: state.team!.players!.length,
        itemBuilder: (context, index) {
          final member = state.team!.players![index];
          return UserDetailCell(
              user: member,
              onTap: () => UserDetailSheet.show(context, member),
              showPhoneNumber: false);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      );
    } else {
      return EmptyScreen(
        title: context.l10n.team_list_no_teams_created_title,
        description: context.l10n.team_detail_empty_member_description_text,
        buttonTitle: context.l10n.team_list_add_members_title,
        onTap: () => AppRoute.addTeamMember(team: state.team!).push(context),
      );
    }
  }
}
