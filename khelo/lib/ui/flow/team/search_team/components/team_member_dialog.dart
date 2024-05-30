import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
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

  const TeamMemberDialog({
    super.key,
    required this.team,
    this.isForVerification = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorScheme.containerLowOnSurface,
      title: Text(
        team.name,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      content: SingleChildScrollView(
        child: Wrap(
          runSpacing: 16,
          children: [
            for (final member in team.players != null ? team.players! : []) ...[
              UserDetailCell(
                user: member,
                trailing:
                    isForVerification ? _selectButton(context, member) : null,
              ),
            ],
          ],
        ),
      ),
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
