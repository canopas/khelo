import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
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
      padding: context.mediaQueryPadding +
          const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          _nameText(context),
          Divider(
            height: 32,
            color: context.colorScheme.outline,
            thickness: 2,
          ),
          _textDividerView(
            context,
            title1: user.location.toString(),
            title2: user.gender?.getString(context) ?? "",
          ),
          Divider(
            height: 32,
            color: context.colorScheme.outline,
            thickness: 2,
          ),
          _textDividerView(context,
              title1: user.player_role?.getString(context),
              title2: user.batting_style?.getString(context),
              title3: user.bowling_style?.getString(context)),
        ],
      ),
    );
  }

  Widget _nameText(BuildContext context) {
    return Row(
      children: [
        ImageAvatar(
          initial: user.nameInitial,
          imageUrl: user.profile_img_url,
          size: 70,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                user.name ?? context.l10n.common_anonymous_title,
                style: AppTextStyle.subtitle1.copyWith(
                    color: context.colorScheme.textPrimary, fontSize: 20),
              ),
              Text(
                user.phone.format(context, StringFormats.obscurePhoneNumber),
                style: AppTextStyle.subtitle1.copyWith(
                    color: context.colorScheme.textPrimary, fontSize: 20),
              ),
            ],
          ),
        ),
        Text.rich(
            textAlign: TextAlign.right,
            TextSpan(
                text: context.l10n.add_match_joined_on_title,
                style: AppTextStyle.body2
                    .copyWith(color: context.colorScheme.textSecondary),
                children: [
                  TextSpan(
                      text:
                          "\n${DateFormat.yMMMd().format(user.created_at ?? DateTime.now())}",
                      style: AppTextStyle.subtitle1
                          .copyWith(color: context.colorScheme.textSecondary))
                ])),
      ],
    );
  }

  Widget _textDividerView(
    BuildContext context, {
    required String? title1,
    required String? title2,
    String? title3,
  }) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (title1 != null) ...[
            Text(
              title1,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ],
          if (title2 != null) ...[
            VerticalDivider(
              thickness: 2,
              color: context.colorScheme.outline,
              width: 24,
            ),
            Text(
              title2,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ],
          if (title3 != null) ...[
            VerticalDivider(
              thickness: 2,
              color: context.colorScheme.outline,
              width: 24,
            ),
            Text(
              title3,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ],
        ],
      ),
    );
  }
}
