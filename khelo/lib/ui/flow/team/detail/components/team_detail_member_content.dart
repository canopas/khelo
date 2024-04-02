import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
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

    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        for (final member in state.team?.players ?? []) ...[
          _memberCell(context, member),
          const SizedBox(
            height: 16,
          ),
        ],
        const SizedBox(
          height: 34,
        ),
      ],
    );
  }

  Widget _memberCell(BuildContext context, UserModel user) {
    return Row(
      children: [
        ImageAvatar(
          initial: user.nameInitial,
          imageUrl: user.profile_img_url,
          size: 50,
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name ?? context.l10n.common_anonymous_title,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            Text(
              user.player_role != null
                  ? user.player_role!.getString(context)
                  : "Not Specified",
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
            Text(
              user.location ?? "Not Specified",
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textSecondary),
            )
          ],
        )
      ],
    );
  }
}
