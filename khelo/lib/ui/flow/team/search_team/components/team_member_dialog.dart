import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/ui/flow/team/add_team_member/components/verify_add_team_member_dialog.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class TeamMemberDialog extends StatelessWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required TeamModel team,
    bool isForVerification = false,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return TeamMemberDialog(
          team: team,
          isForVerification: isForVerification,
        );
      },
    );
  }

  final TeamModel team;
  final bool isForVerification;

  const TeamMemberDialog(
      {super.key, required this.team, this.isForVerification = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorScheme.containerLowOnSurface,
      title: Text(team.name),
      content: SingleChildScrollView(
        child: Wrap(
          runSpacing: 16,
          children: [
            for (final member in team.players != null ? team.players! : []) ...[
              _userProfileCell(context, member),
            ],
          ],
        ),
      ),
    );
  }

  Widget _userProfileCell(BuildContext context, UserModel user) {
    return Row(
      children: [
        ImageAvatar(
          initial: user.nameInitial,
          imageUrl: user.profile_img_url,
          size: 50,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name ?? context.l10n.common_anonymous_title,
                style: AppTextStyle.header4
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              Text(
                  user.player_role != null
                      ? user.player_role!.getString(context)
                      : context.l10n.common_not_specified_title,
                  style: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textSecondary)),
              if (user.phone != null) ...[
                const SizedBox(
                  height: 2,
                ),
                Text(
                  context.l10n.common_obscure_phone_number_text(
                      user.phone!.substring(1, 3),
                      user.phone!.substring(user.phone!.length - 2)),
                  style: AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textSecondary),
                ),
              ],
            ],
          ),
        ),
        if (isForVerification) ...[_selectButton(context, user)]
      ],
    );
  }

  Widget _selectButton(BuildContext context, UserModel user) {
    return OnTapScale(
      onTap: () async {
        if (user.phone != null) {
          final res = await VerifyAddTeamMemberDialog.show(context,
              phoneNumber: user.phone!.substring(user.phone!.length - 5));
          if (res != null && res && context.mounted) {
            context.pop(res);
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            color: context.colorScheme.containerLow,
            borderRadius: BorderRadius.circular(20)),
        child: Text(context.l10n.search_team_select_title),
      ),
    );
  }
}
