import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/team/add_team_member/components/verify_add_team_member_dialog.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class TeamMemberSheet extends StatelessWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required TeamModel team,
    bool isForVerification = false,
  }) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      showDragHandle: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return TeamMemberSheet(
          team: team,
          isForVerification: isForVerification,
        );
      },
    );
  }

  final TeamModel team;
  final bool isForVerification;

  const TeamMemberSheet({
    super.key,
    required this.team,
    this.isForVerification = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.mediaQueryPadding +
          const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              team.name,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            const SizedBox(height: 16),
            Wrap(
                runSpacing: 16,
                children: (team.players ?? [])
                    .map((member) => UserDetailCell(
                          user: member,
                          trailing: isForVerification
                              ? _selectButton(context, member)
                              : null,
                        ))
                    .toList()),
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
              phoneNumber: user.phone!);
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
        child: Text(
          context.l10n.common_select_title,
          style: AppTextStyle.body2
              .copyWith(color: context.colorScheme.textDisabled),
        ),
      ),
    );
  }
}
