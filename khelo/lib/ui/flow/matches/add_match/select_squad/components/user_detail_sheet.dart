import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/domain/formatter/string_formatter.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:style/text/app_text_style.dart';

class UserDetailSheet extends StatelessWidget {
  static Future<T?> show<T>(
    BuildContext context,
    UserModel user, {
    String? actionButtonTitle,
    VoidCallback? onButtonTap,
  }) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      showDragHandle: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) => UserDetailSheet(
        user: user,
        actionButtonTitle: actionButtonTitle,
        onButtonTap: onButtonTap,
      ),
    );
  }

  final UserModel user;
  final String? actionButtonTitle;
  final VoidCallback? onButtonTap;

  const UserDetailSheet({
    super.key,
    required this.user,
    this.actionButtonTitle,
    this.onButtonTap,
  });

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
            label: context.l10n.common_gender_title,
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
            label: context.l10n.common_batting_style_title,
            value: user.batting_style?.getString(context),
          ),
          _memberDetailCell(
            context,
            label: context.l10n.common_bowling_style_title,
            value: user.bowling_style?.getString(context),
          ),
          if (actionButtonTitle != null) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PrimaryButton(
                actionButtonTitle!,
                enabled: onButtonTap != null,
                onPressed: () {
                  context.pop();
                  onButtonTap?.call();
                },
              ),
            )
          ],
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
