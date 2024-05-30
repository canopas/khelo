import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/image_avatar.dart';

class MemberCell extends StatelessWidget {
  final UserModel member;

  const MemberCell({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
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
