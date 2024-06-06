import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/domain/formatter/string_formatter.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:style/text/app_text_style.dart';

class UserDetailSheet extends StatelessWidget {
  static Future<T?> show<T>(
    BuildContext context,
    UserModel user,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      showDragHandle: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return UserDetailSheet(
          user: user,
        );
      },
    );
  }

  final UserModel user;

  const UserDetailSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.mediaQueryPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _memberProfile(context),
          Divider(color: context.colorScheme.outline),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              context.l10n.add_team_member_details_title,
              style: AppTextStyle.header4.copyWith(
                color: context.colorScheme.textPrimary,
              ),
            ),
          ),
          _memberDetailCell(
            context,
            label: context.l10n.edit_profile_gender_placeholder,
            value: user.gender?.getString(context),
          ),
          _memberDetailCell(
            context,
            label: context.l10n.common_location_title,
            value: user.location.toString(),
          ),
          _memberDetailCell(
            context,
            label: context.l10n.add_team_player_role_title,
            value: user.player_role?.getString(context),
          ),
          _memberDetailCell(
            context,
            label: context.l10n.edit_profile_batting_style_placeholder,
            value: user.batting_style?.getString(context),
          ),
          _memberDetailCell(
            context,
            label: context.l10n.edit_profile_bowling_style_placeholder,
            value: user.bowling_style?.getString(context),
          ),
        ],
      ),
    );
  }

  Widget _memberProfile(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        dense: true,
        leading: ImageAvatar(
          initial: user.nameInitial,
          imageUrl: user.profile_img_url,
          size: 40,
        ),
        title: Text(
          user.name ?? context.l10n.common_anonymous_title,
          style: AppTextStyle.subtitle1
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        subtitle: Text(
          user.phone.format(context, StringFormats.obscurePhoneNumber),
          style: AppTextStyle.body2
              .copyWith(color: context.colorScheme.textDisabled),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.add_match_joined_on_title,
              style: AppTextStyle.caption
                  .copyWith(color: context.colorScheme.textDisabled),
            ),
            Text(
              (user.created_at ?? DateTime.now())
                  .format(context, DateFormatType.dayMonthYear),
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _memberDetailCell(
    BuildContext context, {
    required String label,
    required String? value,
  }) {
    if (value == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyle.body1.copyWith(
              color: context.colorScheme.textDisabled,
            ),
          ),
          Text(
            value,
            style: AppTextStyle.body2.copyWith(
              color: context.colorScheme.textPrimary,
            ),
          )
        ],
      ),
    );
  }
}
