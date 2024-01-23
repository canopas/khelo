import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:khelo/ui/flow/sign_in/sign_in_with_phone/sign_in_with_phone_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import 'components/sign_in_with_phone_input_fields.dart';

class SignInWithPhoneScreen extends ConsumerStatefulWidget {
  const SignInWithPhoneScreen({super.key});

  @override
  ConsumerState createState() => _SignInWithPhoneScreenState();
}

class _SignInWithPhoneScreenState extends ConsumerState<SignInWithPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _observeOtp({required BuildContext context}) {
    ref.listen(
      signInWithPhoneStateProvider.select((value) => value.verificationId),
      (previous, current) async {
        if (current != null) {
          final state = ref.read(signInWithPhoneStateProvider);
          final bool? success = await AppRoute.verifyOTP(
            phoneNumber: state.code.dialCode + state.phone,
            verificationId: current,
          ).push(context);
          if (success == true && context.mounted) context.pop(true);

          //onSignInSuccess(); // in place of context.pop
        }
      },
    );
  }

  void _observeSignInSuccess({required BuildContext context}) {
    ref.listen(
      signInWithPhoneStateProvider.select((value) => value.signInSuccess),
      (previous, current) async {
        if (current && context.mounted) {
          context.pop(true);
          //onSignInSuccess(); // in place of context.pop
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(signInWithPhoneStateProvider.notifier);
    final loading = ref.watch(
      signInWithPhoneStateProvider.select((value) => value.verifying),
    );
    final enable = ref.watch(
      signInWithPhoneStateProvider.select((value) => value.enableNext),
    );

    _observeOtp(context: context);
    _observeSignInSuccess(context: context);

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
                  loading: false,
                  notifier: notifier),
              PrimaryButton(
                context.l10n.sign_in_get_otp_btn_text,
                enabled: enable,
                progress: loading,
                onPressed: () {
                  notifier.verifyPhoneNumber();
                },
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
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
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

  void onSignInSuccess() async {
    final user = ref.read(currentUserPod);
    if (user?.name == null || user!.name!.isEmpty) {
      // await AppRoute.editProfile(blockBackButton: true).push(context);
      await AppRoute.editProfile.push(context);
    }
    if (mounted) context.pop(true);
  }
}
