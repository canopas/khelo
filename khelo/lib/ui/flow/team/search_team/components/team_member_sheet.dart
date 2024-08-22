import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/user_detail_cell.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/team/add_team_member/components/verify_team_member_sheet.dart';
import 'package:style/button/secondary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../matches/add_match/select_squad/components/user_detail_sheet.dart';

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
                children: (team.players)
                    .map((player) => UserDetailCell(
                          user: player.user,
                          onTap: () => UserDetailSheet.show(
                            context,
                            player.user,
                            actionButtonTitle:
                                isForVerification && player.user.isActive
                                    ? context.l10n.common_select_title
                                    : null,
                            onButtonTap: () =>
                                _onSelectButtonTap(context, player.user),
                          ),
                          trailing: isForVerification && player.user.isActive
                              ? _selectButton(context, player.user)
                              : null,
                        ))
                    .toList()),
          ],
        ),
      ),
    );
  }

  Widget _selectButton(BuildContext context, UserModel user) {
    return SecondaryButton(
      context.l10n.common_select_title,
      onPressed: () => _onSelectButtonTap(context, user),
    );
  }

  Future<void> _onSelectButtonTap(BuildContext context, UserModel user) async {
    if (user.phone != null) {
      final res =
          await VerifyTeamMemberSheet.show(context, phoneNumber: user.phone!);
      if (res != null && res && context.mounted) {
        context.pop(res);
      }
    }
  }
}
