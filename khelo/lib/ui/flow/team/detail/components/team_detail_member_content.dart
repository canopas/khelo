import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    if (state.team?.players != null &&
        state.team?.players?.isNotEmpty == true) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.team!.players!.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _addMemberButton(
              context,
              onTap: () =>
                  AppRoute.addTeamMember(team: state.team!).push(context),
            );
          }
          final member = state.team!.players![index - 1];
          return UserDetailCell(
              user: member,
              onTap: () => UserDetailSheet.show(context, member),
              showPhoneNumber: false);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            context.l10n.team_detail_empty_member_title,
            textAlign: TextAlign.center,
            style: AppTextStyle.body2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
      );
    }
  }

  Widget _addMemberButton(BuildContext context, {required Function() onTap}) {
    return OnTapScale(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: context.colorScheme.containerLow,
              shape: BoxShape.circle,
            ),
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
    );
  }
}
