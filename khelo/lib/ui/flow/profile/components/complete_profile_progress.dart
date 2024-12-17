import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class CompleteProfileProgress extends ConsumerStatefulWidget {
  final UserModel? user;

  const CompleteProfileProgress({super.key, this.user});

  @override
  ConsumerState<CompleteProfileProgress> createState() =>
      _CompleteProfileProgressState();
}

class _CompleteProfileProgressState
    extends ConsumerState<CompleteProfileProgress> {
  @override
  Widget build(BuildContext context) {
    if (widget.user?.profile_img_url != null &&
        widget.user?.gender != null &&
        widget.user?.player_role != null &&
        widget.user?.batting_style != null &&
        widget.user?.bowling_style != null) {
      return const SizedBox();
    }

    return OnTapScale(
      onTap: () => AppRoute.editProfile().push(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.profile_complete_your_profile_title,
              style: AppTextStyle.header4.copyWith(
                color: context.colorScheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.profile_complete_description_title,
              style: AppTextStyle.subtitle3.copyWith(
                color: context.colorScheme.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: widget.user?.progress,
              minHeight: 6,
              borderRadius: BorderRadius.circular(12),
              backgroundColor: context.colorScheme.outline,
              valueColor:
                  AlwaysStoppedAnimation<Color>(context.colorScheme.primary),
            ),
            const SizedBox(height: 8),
            if (widget.user?.profile_img_url == null) ...[
              _fieldStatus(context.l10n.profile_complete_add_profile_picture),
            ],
            if (widget.user?.dob == null || widget.user?.gender == null) ...[
              _fieldStatus(context.l10n.profile_complete_add_personal_details),
            ],
            if (widget.user?.player_role == null ||
                widget.user?.batting_style == null ||
                widget.user?.bowling_style == null) ...[
              _fieldStatus(context.l10n.profile_complete_add_playing_style),
            ],
          ],
        ),
      ),
    );
  }

  Widget _fieldStatus(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_rounded,
            color: context.colorScheme.containerHigh,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: AppTextStyle.body1.copyWith(
              color: context.colorScheme.textSecondary,
            ),
          )
        ],
      ),
    );
  }
}
