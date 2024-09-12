import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:khelo/domain/formatter/date_formatter.dart';
import 'package:khelo/ui/flow/team/user_detail/user_detail_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class UserDetailInfoContent extends ConsumerWidget {
  const UserDetailInfoContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(userDetailStateProvider);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        _title(context, context.l10n.user_detail_personal_information_title),
        const SizedBox(height: 8),
        _infoRowView(context, context.l10n.user_detail_joining_date_title,
            state.user?.created_at?.format(context, DateFormatType.shortDate)),
        _infoRowView(context, context.l10n.common_gender_title,
            state.user?.gender?.getString(context)),
        _infoRowView(
            context, context.l10n.common_location_title, state.user?.location),
        _infoRowView(context, context.l10n.user_detail_role_title,
            state.user?.player_role?.getString(context)),
        _infoRowView(context, context.l10n.common_batting_style_title,
            state.user?.batting_style?.getString(context)),
        _infoRowView(context, context.l10n.common_bowling_style_title,
            state.user?.bowling_style?.getString(context)),
        _teamParticipationView(context, state),
      ],
    );
  }

  Widget _title(BuildContext context, String title) {
    return Text(
      title,
      style:
          AppTextStyle.header3.copyWith(color: context.colorScheme.textPrimary),
    );
  }

  Widget _infoRowView(BuildContext context, String title, String? subtitle) {
    if (subtitle == null || subtitle.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.subtitle3
                .copyWith(color: context.colorScheme.textSecondary),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              subtitle,
              textAlign: TextAlign.end,
              style: AppTextStyle.subtitle2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamParticipationView(
    BuildContext context,
    UserDetailViewState state,
  ) {
    final teams = state.teams.map((e) => e.name).join(", ");
    if (teams.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 32, color: context.colorScheme.outline),
        _title(context, context.l10n.user_detail_participation_title),
        const SizedBox(height: 16),
        Text(
          teams,
          style: AppTextStyle.body1
              .copyWith(color: context.colorScheme.textSecondary),
        ),
      ],
    );
  }
}
