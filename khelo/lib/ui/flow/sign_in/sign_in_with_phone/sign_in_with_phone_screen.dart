import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/sign_in/sign_in_with_phone/sign_in_with_phone_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import 'components/sign_in_with_phone_input_fields.dart';

class SignInWithPhoneScreen extends ConsumerWidget {
  SignInWithPhoneScreen({super.key});

  final TextEditingController _phoneController = TextEditingController();

  void _observeOtp({required BuildContext context, required WidgetRef ref}) {
    ref.listen(
      signInWithPhoneStateProvider.select((value) => value.verificationId),
      (previous, current) async {
        if (current != null) {
          final state = ref.watch(signInWithPhoneStateProvider);
          final bool? success = await AppRoute.verifyOTP(
            phoneNumber: state.code.dialCode + state.phone,
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(signInWithPhoneStateProvider.notifier);
    final loading = ref.watch(
      signInWithPhoneStateProvider.select((value) => value.verifying),
    );
    final enable = ref.watch(
      signInWithPhoneStateProvider.select((value) => value.enableBtn),
    );

    _observeOtp(context: context, ref: ref);
    _observeSignInSuccess(context: context, ref: ref);

    return AppPage(
      body: Builder(builder: (context) {
        return Padding(
          padding: context.mediaQueryPadding +
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListView(
            children: [
              Text(
                context.l10n.sign_in_enter_your_phone_number_text,
                style: AppTextStyle.header1
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              _phoneInputField(
                  context: context,
                  enable: true,
                  loading: loading,
                  notifier: notifier),
              PrimaryButton(
                context.l10n.sign_in_get_otp_btn_text,
                enabled: enable,
                progress: loading,
                onPressed: () => notifier.verifyPhoneNumber(),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _phoneInputField({
    required BuildContext context,
    required bool enable,
    required bool loading,
    required SignInWithPhoneViewNotifier notifier,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: CupertinoTextField(
        controller: _phoneController,
        onChanged: (phone) => notifier.onPhoneChange(phone),
        keyboardType: TextInputType.phone,
        onSubmitted: (value) {
          if (!loading && enable) notifier.verifyPhoneNumber();
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        style: AppTextStyle.subtitle1.copyWith(
          color: context.colorScheme.textPrimary,
        ),
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        placeholderStyle: AppTextStyle.subtitle1.copyWith(
          color: context.colorScheme.textDisabled,
        ),
        placeholder: context.l10n.sign_in_enter_phone_number_text,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
        ),
        prefix: const SignInWithPhoneCountryPicker(),
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
}
