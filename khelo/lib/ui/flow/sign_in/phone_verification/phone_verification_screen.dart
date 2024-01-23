import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/sign_in/phone_verification/components/enter_otp_view.dart';
import 'package:khelo/ui/flow/sign_in/phone_verification/components/resend_code_view.dart';
import 'package:khelo/ui/flow/sign_in/phone_verification/phone_verification_view_model.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../domain/extensions/widget_extension.dart';

class PhoneVerificationScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const PhoneVerificationScreen(
      {super.key, required this.phoneNumber, required this.verificationId});

  @override
  ConsumerState createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState
    extends ConsumerState<PhoneVerificationScreen> {
  late PhoneVerificationViewNotifier notifier;

  @override
  void initState() {
    notifier = ref.read(phoneVerificationStateProvider.notifier);

    runPostFrame(
      () => notifier.updateVerificationIdAndPhone(
        verificationId: widget.verificationId,
        phone: widget.phoneNumber,
      ),
    );
    super.initState();
  }

  void _observeVerificationComplete() {
    ref.listen(
        phoneVerificationStateProvider
            .select((value) => value.verificationComplete), (previous, next) {
      if (next) {
        context.pop(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(phoneVerificationStateProvider);
    _observeVerificationComplete();

    return AppPage(
      body: Builder(builder: (context) {
        return Padding(
          padding: context.mediaQueryPadding +
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListView(
            children: [
              Text(
                context.l10n.otp_verification_enter_otp_text,
                style: AppTextStyle.header1
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              const SizedBox(
                height: 24,
              ),
              const EnterOTPView(
                count: 6,
              ),
              const SizedBox(
                height: 24,
              ),
              PrimaryButton(
                enabled: state.enableVerify,
                progress: state.verifying,
                context.l10n.otp_verification_verify_otp_text,
                onPressed: () {
                  notifier.verifyOTP();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              PhoneVerificationResendCodeView(phoneNumber: widget.phoneNumber),
            ],
          ),
        );
      }),
    );
  }
}
