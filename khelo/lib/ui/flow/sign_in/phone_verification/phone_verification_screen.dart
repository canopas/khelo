import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/components/error_snackbar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/sign_in/phone_verification/phone_verification_view_model.dart';
import 'package:style/button/bottom_sticky_overlay.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
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
      title: "",
      body: Builder(builder: (context) {
        return Stack(
          children: [
            ListView(
              padding: context.mediaQueryPadding +
                  const EdgeInsets.symmetric(horizontal: 16.0) +
                  BottomStickyOverlay.padding,
              children: [
                Text(
                  context.l10n.otp_verification_verification_title,
                  style: AppTextStyle.header1
                      .copyWith(color: context.colorScheme.textPrimary),
                ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.otp_verification_verification_description(
                      "${widget.countryCode} ${widget.phoneNumber}"),
                  style: AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textDisabled),
                ),
                _phoneInputField(context, state),
              ],
            ),
            BottomStickyOverlay(
              child: PrimaryButton(
                enabled: state.enableVerify,
                progress: state.verifying,
                context.l10n.common_verify_title,
                onPressed: notifier.verifyOTP,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _phoneInputField(
    BuildContext context,
    PhoneVerificationState state,
  ) {
    return MediaQuery.withNoTextScaling(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: AppTextField(
          autoFocus: true,
          maxLength: 6,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: notifier.updateOTP,
          style: AppTextStyle.header2.copyWith(
            color: context.colorScheme.textSecondary,
            letterSpacing: 16,
          ),
          hintStyle: AppTextStyle.header2.copyWith(
            color: context.colorScheme.outline,
          ),
          hintText: context.l10n.otp_verification_verify_placeholder,
          backgroundColor: context.colorScheme.containerLowOnSurface,
          errorText: state.showErrorVerificationCodeText
              ? context.l10n.otp_verification_incorrect_otp_error_text
              : null,
          borderRadius: BorderRadius.circular(40),
          borderType: AppTextFieldBorderType.outline,
          borderColor: BorderColor(
              focusColor: Colors.transparent, unFocusColor: Colors.transparent),
          onSubmitted: (value) => (!state.verifying && state.enableVerify)
              ? notifier.verifyOTP
              : null,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
        ),
      ),
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
