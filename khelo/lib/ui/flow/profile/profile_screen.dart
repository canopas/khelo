import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/confirmation_dialog.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/profile/components/complete_profile_progress.dart';
import 'package:khelo/ui/flow/profile/profile_view_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../gen/assets.gen.dart';

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
      body: Builder(
        builder: (context) {
          return ListView(
            padding: context.mediaQueryPadding +
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _userProfileView(context, state),
              if (state.currentUser != null) ...[
                CompleteProfileProgress(user: state.currentUser!)
              ],
              const SizedBox(height: 24),
              Text(
                context.l10n.profile_settings_title,
                style: AppTextStyle.header4
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              const SizedBox(height: 16),
              _settingsView(context, notifier),
              if (state.currentUser?.id != null) ...[
                const SizedBox(height: 16),
                _qrCodeView(context, state.currentUser?.id ?? ""),
              ],
              const SizedBox(height: 24),
              Visibility(
                visible: state.appVersion != null,
                child: Text(
                  context.l10n.profile_setting_app_version_text(
                      state.appVersion.toString()),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.body2.copyWith(
                    color: context.colorScheme.textDisabled,
                  ),
                ),
              ),
              const SizedBox(height: 24),
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

  Widget _settingsView(
    BuildContext context,
    ProfileViewNotifier notifier,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Column(
        children: [
          _settingItem(
            context,
            icon: Assets.images.icContactSupport,
            title: context.l10n.contact_support_title,
            onTap: () => AppRoute.contactSupport().push(context),
          ),
          _settingItem(
            context,
            icon: Assets.images.icPrivacyPolicy,
            title: context.l10n.profile_setting_privacy_policy_title,
            onTap: () => notifier
                .openUrl("https://canopas.github.io/khelo/privacy-policy"),
          ),
          _settingItem(
            context,
            icon: Assets.images.icTermsConditions,
            title: context.l10n.profile_setting_terms_and_condition_title,
            onTap: () => notifier
                .openUrl("https://canopas.github.io/khelo/terms-and-condition"),
          ),
          _settingItem(
            context,
            icon: Assets.images.icSignOut,
            color: context.colorScheme.alert,
            title: context.l10n.common_sign_out_title,
            onTap: () {
              showConfirmationDialog(context,
                  title: context.l10n.common_sign_out_title,
                  message: context.l10n.alert_confirm_default_message(
                      context.l10n.common_sign_out_title.toLowerCase()),
                  confirmBtnText: context.l10n.common_sign_out_title,
                  onConfirm: notifier.onSignOutTap);
            },
          ),
        ],
      ),
    );
  }

  Widget _settingItem(
    BuildContext context, {
    required String icon,
    Color? color,
    required String title,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: OnTapScale(
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                  color ?? context.colorScheme.textPrimary, BlendMode.srcATop),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: AppTextStyle.subtitle2
                  .copyWith(color: color ?? context.colorScheme.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qrCodeView(
    BuildContext context,
    String userId,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.profile_setting_scan_to_play_text,
            style: AppTextStyle.header4
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.profile_setting_scan_to_play_description,
            style: AppTextStyle.subtitle3
                .copyWith(color: context.colorScheme.textSecondary),
          ),
          const SizedBox(height: 24),
          Center(
            child: QrImageView(
              data: userId,
              version: QrVersions.auto,
              size: 120.0,
              dataModuleStyle: QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: context.colorScheme.textPrimary),
              eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: context.colorScheme.textPrimary),
            ),
          ),
        ],
      ),
    );
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
