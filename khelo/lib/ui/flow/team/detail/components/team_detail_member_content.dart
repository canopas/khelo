import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class TeamDetailMemberContent extends ConsumerWidget {
  const TeamDetailMemberContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamDetailStateProvider);

    if (state.team?.players?.isEmpty ?? true) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            context.l10n.team_detail_empty_member_title,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: context.mediaQueryPadding +
          const EdgeInsets.symmetric(horizontal: 16),
      itemCount: (state.team?.players ?? []).length,
      itemBuilder: (context, index) {
        final member = (state.team?.players ?? [])[index];
        return _memberCell(context, member);
      },
    );
  }

  Widget _memberCell(BuildContext context, UserModel member) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: ImageAvatar(
          initial: member.nameInitial,
          imageUrl: member.profile_img_url,
          size: 40,
        ),
        title: Text(
          member.name ?? context.l10n.common_anonymous_title,
          style: AppTextStyle.subtitle2
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        subtitle: Text(
          member.player_role != null
              ? member.player_role!.getString(context)
              : context.l10n.team_detail_member_not_specified_role,
          style: AppTextStyle.caption
              .copyWith(color: context.colorScheme.textDisabled),
        ),
      ),
    );
  }
}
