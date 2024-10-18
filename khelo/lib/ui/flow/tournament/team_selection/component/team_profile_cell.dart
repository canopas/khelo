import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/image_avatar.dart';

class TeamProfileCell extends StatelessWidget {
  final TeamModel team;
  final Widget? trailing;
  final Function()? onTap;
  final Function()? onLongTap;

  const TeamProfileCell({
    super.key,
    required this.team,
    this.trailing,
    this.onTap,
    this.onLongTap,
  });

  @override
  Widget build(BuildContext context) {
    return OnTapScale(
      onTap: onTap,
      onLongTap: onLongTap,
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: ImageAvatar(
            initial: team.name_initial ?? team.name.initials(limit: 1),
            imageUrl: team.profile_img_url,
            size: 40,
          ),
          title: Text(
            team.name,
            style: AppTextStyle.subtitle2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          subtitle: Text.rich(
            TextSpan(
              text: team.city != null
                  ? team.city!
                  : context.l10n.common_not_specified_title,
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.textSecondary),
              children: [
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      constraints:
                          const BoxConstraints(maxHeight: 4, maxWidth: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colorScheme.textDisabled,
                      ),
                    )),
                TextSpan(
                  text: context.l10n.common_players_title(team.players.length),
                ),
              ],
            ),
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
