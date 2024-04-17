import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/api/user/user_models.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/confirmation_dialog.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/profile/profile_view_model.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _observeUserSession(BuildContext context, WidgetRef ref) {
    ref.listen(hasUserSession, (previous, next) {
      if (!next) {
        AppRoute.intro.go(context);
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(profileStateProvider.notifier);
    final state = ref.watch(profileStateProvider);

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
                  .copyWith(color: context.colorScheme.primary),
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
                const SizedBox(
                  height: 24,
                ),
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
            border: Border.all(color: context.colorScheme.containerHigh),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              height: 90,
              width: 90,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: context.colorScheme.containerLow,
                  shape: BoxShape.circle,
                  image: state.currentUser?.profile_img_url != null
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(
                              state.currentUser!.profile_img_url!),
                          fit: BoxFit.cover)
                      : null,
                  border: Border.all(color: context.colorScheme.containerHigh)),
              child: state.currentUser?.profile_img_url == null
                  ? Text(state.currentUser?.nameInitial ?? '?',
                      style: AppTextStyle.header1.copyWith(
                        color: context.colorScheme.secondary,
                        fontSize: 40,
                      ))
                  : null,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                state.currentUser?.name ?? context.l10n.common_anonymous_title,
                style: AppTextStyle.header3
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.containerHigh),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(
              context.l10n.profile_complete_your_profile_title,
              style: AppTextStyle.header1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              context.l10n.profile_complete_profile_description_title,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
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
}
