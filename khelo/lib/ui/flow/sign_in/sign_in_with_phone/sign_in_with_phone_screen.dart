import 'package:data/storage/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/country_code_view.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/sign_in/sign_in_with_phone/sign_in_with_phone_view_model.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';

class SignInWithPhoneScreen extends ConsumerWidget {
  const SignInWithPhoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(signInWithPhoneStateProvider.notifier);
    final state = ref.watch(signInWithPhoneStateProvider);

    _observeActionError(context, ref);
    _observeOtp(context: context, ref: ref);
    _observeSignInSuccess(context: context, ref: ref);

    return AppPage(
      title: "",
      body: Builder(builder: (context) {
        return Stack(
          children: [
            ListView(
              padding: context.mediaQueryPadding +
                  const EdgeInsets.symmetric(horizontal: 16) +
                  BottomStickyOverlay.padding,
              children: [
                Text(
                  context.l10n.sign_in_verify_phone_number_title,
                  style: AppTextStyle.header1
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.sign_in_verify_phone_number_description,
                  style: AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textDisabled),
                ),
                _phoneInputField(context, notifier, state),
              ],
            ),
            BottomStickyOverlay(
              child: PrimaryButton(
                context.l10n.sign_in_get_otp_btn_text,
                enabled: state.enableBtn && !state.verifying,
                progress: state.verifying,
                onPressed: notifier.verifyPhoneNumber,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _phoneInputField(
    BuildContext context,
    SignInWithPhoneViewNotifier notifier,
    SignInWithPhoneState state,
  ) {
    return MediaQuery.withNoTextScaling(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CountryCodeView(
              countryCode: state.code,
              onCodeChange: notifier.changeCountryCode,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTextField(
                controller: state.phoneController,
                autoFocus: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                style: AppTextStyle.header2.copyWith(
                  color: context.colorScheme.textSecondary,
                ),
                hintStyle: AppTextStyle.header2.copyWith(
                  color: context.colorScheme.outline,
                ),
                hintText: context.l10n.sign_in_phone_number_placeholder,
                backgroundColor: context.colorScheme.containerLowOnSurface,
                borderRadius: BorderRadius.circular(40),
                borderType: AppTextFieldBorderType.outline,
                borderColor: BorderColor(
                    focusColor: Colors.transparent,
                    unFocusColor: Colors.transparent),
                prefixIcon: _inputFieldPrefix(context, state),
                prefixIconConstraints: const BoxConstraints.tightFor(),
                onChanged: (phone) => notifier.onPhoneChange(phone),
                onSubmitted: (value) => (!state.verifying && state.enableBtn)
                    ? notifier.verifyPhoneNumber()
                    : null,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputFieldPrefix(
    BuildContext context,
    SignInWithPhoneState state,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.code.dialCode,
              style: AppTextStyle.header2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            VerticalDivider(
              width: 24,
              color: context.colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }

  void onSignInSuccess(BuildContext context, WidgetRef ref) async {
    final user = ref.read(currentUserPod);
    if (user?.name == null || user!.name!.trim().isEmpty) {
      AppRoute.editProfile(isToCreateAccount: true).go(context);
    } else {
      AppRoute.main.go(context);
    }
  }

  void _observeActionError(BuildContext context, WidgetRef ref) {
    ref.listen(
        signInWithPhoneStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observeOtp({required BuildContext context, required WidgetRef ref}) {
    ref.listen(
      signInWithPhoneStateProvider.select((value) => value.verificationId),
      (previous, current) async {
        if (current != null) {
          final state = ref.watch(signInWithPhoneStateProvider);
          final bool? success = await AppRoute.verifyOTP(
            countryCode: state.code.dialCode,
            phoneNumber: state.phone,
            verificationId: current,
          ).push<bool>(context);
          if (success != null && success && context.mounted) {
            onSignInSuccess(context, ref);
          }
        }
      },
    );
  }

  void _observeSignInSuccess({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    ref.listen(
      signInWithPhoneStateProvider.select((value) => value.signInSuccess),
      (previous, current) async {
        if (current && context.mounted) onSignInSuccess(context, ref);
      },
    );
  }
}
