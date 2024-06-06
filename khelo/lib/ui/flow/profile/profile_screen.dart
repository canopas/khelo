import 'package:data/api/user/user_models.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/confirmation_dialog.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/profile/profile_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(profileStateProvider.notifier);
    final state = ref.watch(profileStateProvider);

    _observeActionError(context, ref);
    _observeUserSession(context, ref);
    return AppPage(
      title: context.l10n.tab_profile_title,
      actions: [
        TextButton(
            onPressed: () => showConfirmationDialog(context,
                title: context.l10n.common_sign_out_title,
                message: context.l10n.alert_confirm_default_message(
                    context.l10n.common_sign_out_title.toLowerCase()),
                confirmBtnText: context.l10n.common_sign_out_title,
                onConfirm: notifier.onSignOutTap),
            child: Text(
              context.l10n.common_sign_out_title,
              style: AppTextStyle.button
                  .copyWith(color: context.colorScheme.alert),
            ))
      ],
      body: Builder(
        builder: (context) {
          return ListView(
            padding: context.mediaQueryPadding +
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _userProfileView(context, state),
              if (state.currentUser != null) ...[
                const SizedBox(height: 24),
                _inCompleteProfileView(context, state.currentUser!)
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _userProfileView(BuildContext context, ProfileState state) {
    return OnTapScale(
      onTap: () => AppRoute.editProfile().push(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: context.colorScheme.containerNormal,
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            ImageAvatar(
              size: 80,
              imageUrl: state.currentUser?.profile_img_url,
              initial: state.currentUser?.nameInitial ?? '?',
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                state.currentUser?.name ?? context.l10n.common_anonymous_title,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _inCompleteProfileView(BuildContext context, UserModel currentUser) {
    if (currentUser.profile_img_url == null ||
        currentUser.batting_style == null ||
        currentUser.bowling_style == null) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.outline),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Text(
              context.l10n.profile_complete_your_profile_title,
              textAlign: TextAlign.center,
              style: AppTextStyle.header4
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.profile_complete_profile_description,
              textAlign: TextAlign.center,
              style: AppTextStyle.body1
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
                onPressed: () => AppRoute.editProfile().push(context),
                context.l10n.profile_complete_profile_btn_title)
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  void _observeActionError(BuildContext context, WidgetRef ref) {
    ref.listen(profileStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observeUserSession(BuildContext context, WidgetRef ref) {
    ref.listen(hasUserSession, (previous, next) {
      if (!next) {
        AppRoute.intro.go(context);
      }
    });
  }
}
