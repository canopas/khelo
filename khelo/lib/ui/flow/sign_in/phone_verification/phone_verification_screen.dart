import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/components/intro_gradient_background.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/sign_in/phone_verification/components/enter_otp_view.dart';
import 'package:khelo/ui/flow/sign_in/phone_verification/components/resend_code_view.dart';
import 'package:khelo/ui/flow/sign_in/phone_verification/phone_verification_view_model.dart';
import 'package:style/button/action_button.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../domain/extensions/widget_extension.dart';

class PhoneVerificationScreen extends ConsumerStatefulWidget {
  final String countryCode;
  final String phoneNumber;
  final String verificationId;

  const PhoneVerificationScreen({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
    required this.verificationId,
  });

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
        code: widget.countryCode,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(phoneVerificationStateProvider);

    _observeActionError(context, ref);
    _observeVerificationComplete();

    return AppPage(
      body: IntroGradientBackground(
        child: PopScope(
          canPop: false,
          child: Builder(builder: (context) {
            return Padding(
              padding: context.mediaQueryPadding +
                  const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        context.l10n.otp_verification_enter_otp_text,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.header1
                            .copyWith(color: context.colorScheme.textPrimary),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          context.l10n.otp_verification_description,
                          style: AppTextStyle.body1.copyWith(
                              color: context.colorScheme.textSecondary),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _phoneNumberView(context),
                      const EnterOTPView(count: 6),
                      const SizedBox(height: 8),
                      if (state.showErrorVerificationCodeText) ...[
                        Text(
                            context
                                .l10n.otp_verification_incorrect_otp_error_text,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.body2
                                .copyWith(color: context.colorScheme.alert)),
                      ],
                      const SizedBox(height: 24),
                      PrimaryButton(
                        enabled: state.enableVerify,
                        progress: state.verifying,
                        context.l10n.otp_verification_verify_otp_text,
                        onPressed: () => notifier.verifyOTP(),
                      ),
                      const SizedBox(height: 16),
                      PhoneVerificationResendCodeView(
                          countryCode: widget.countryCode,
                          phoneNumber: widget.phoneNumber),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _phoneNumberView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${widget.countryCode} ${widget.phoneNumber}",
          style: AppTextStyle.subtitle2.copyWith(
            color: context.colorScheme.textPrimary,
          ),
        ),
        actionButton(
          context,
          onPressed: context.pop,
          icon: Icon(
            CupertinoIcons.pen,
            color: context.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  void _observeActionError(BuildContext context, WidgetRef ref) {
    ref.listen(
        phoneVerificationStateProvider.select((value) => value.actionError),
        (previous, next) {
      if (next != null) {
        showErrorSnackBar(context: context, error: next);
      }
    });
  }

  void _observeVerificationComplete() {
    ref.listen(
        phoneVerificationStateProvider
            .select((value) => value.isVerificationComplete), (previous, next) {
      if (next) {
        context.pop(next);
      }
    });
  }
}
