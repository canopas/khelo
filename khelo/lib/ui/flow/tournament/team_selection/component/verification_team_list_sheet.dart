import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/tournament/team_selection/component/team_profile_cell.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/button/secondary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../team/search_team/components/team_member_sheet.dart';

class VerificationTeamListSheet extends StatefulWidget {
  final List<TeamModel> verified;
  final List<TeamModel> allTeams;

  static Future<T?> show<T>(
    BuildContext context, {
    required List<TeamModel> verified,
    required List<TeamModel> allTeams,
    bool isForCreateUser = false,
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
        return VerificationTeamListSheet(
          verified: verified,
          allTeams: allTeams,
        );
      },
    );
  }

  const VerificationTeamListSheet({
    super.key,
    required this.verified,
    required this.allTeams,
  });

  @override
  State<VerificationTeamListSheet> createState() =>
      _VerificationTeamListSheetState();
}

class _VerificationTeamListSheetState extends State<VerificationTeamListSheet> {
  late final List<TeamModel> verified;

  @override
  void initState() {
    verified = widget.verified;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: context.mediaQuerySize.height * 0.8),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Padding(
              padding: context.mediaQueryPadding +
                  BottomStickyOverlay.padding +
                  EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.team_selection_verify_team_to_add_title,
                      style: AppTextStyle.header3
                          .copyWith(color: context.colorScheme.textPrimary),
                    ),
                    SizedBox(height: 24),
                    ..._buildList(context),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            BottomStickyOverlay(
              child: PrimaryButton(context.l10n.common_select_title,
                  enabled: verified.isNotEmpty,
                  onPressed: () => context.pop(verified.toSet().toList())),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    if (widget.allTeams.isEmpty) {
      return [];
    }
    return List.generate((widget.allTeams.length * 2) - 1, (index) {
      if (index.isOdd) {
        return Divider(color: context.colorScheme.outline);
      } else {
        final team = widget.allTeams[index ~/ 2];
        final isVerified = verified.map((e) => e.id).contains(team.id);
        return TeamProfileCell(
          team: team,
          trailing: SecondaryButton(
            isVerified
                ? context.l10n.common_verified_title
                : context.l10n.common_verify_title,
            enabled: !isVerified,
            onPressed: () async {
              final res = await TeamMemberSheet.show<bool>(
                context,
                team: team,
                isForVerification: true,
              );

              if (res == true && context.mounted) {
                verified.add(team);
                setState(() {});
              }
            },
          ),
          onTap: () => TeamMemberSheet.show(context, team: team),
        );
      }
    });
  }
}
