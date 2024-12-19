import 'package:data/api/team/team_model.dart';
import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/more_option_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import 'image_avatar.dart';

class TeamDetailCell extends StatelessWidget {
  final TeamModel team;
  final bool showMoreOptionButton;
  final VoidCallback? onTap;
  final VoidCallback? onMoreOptionTap;

  const TeamDetailCell({
    super.key,
    required this.team,
    this.showMoreOptionButton = false,
    this.onTap,
    this.onMoreOptionTap,
  });

  @override
  Widget build(BuildContext context) {
    return OnTapScale(
      onTap: onTap,
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
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
          subtitle: team.players.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                      '${team.players.length} ${context.l10n.add_team_players_text}',
                      style: AppTextStyle.subtitle2
                          .copyWith(color: context.colorScheme.textSecondary)),
                )
              : null,
          trailing: showMoreOptionButton
              ? moreOptionButton(
                  context,
                  onPressed: onMoreOptionTap,
                )
              : null,
        ),
      ),
    );
  }
}
