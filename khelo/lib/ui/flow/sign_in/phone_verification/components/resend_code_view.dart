import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../domain/extensions/context_extensions.dart';
import '../phone_verification_view_model.dart';

class PhoneVerificationResendCodeView extends ConsumerWidget {
  final String countryCode;
  final String phoneNumber;

  const PhoneVerificationResendCodeView({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(phoneVerificationStateProvider.notifier);

    final duration = ref.watch(
      phoneVerificationStateProvider
          .select((value) => value.activeResendDuration),
    );

    final activeResendCodeBtn = duration.inSeconds < 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OnTapScale(
          enabled: activeResendCodeBtn,
          onTap: () async {
            await notifier.resendCode(
                countryCode: countryCode, phone: phoneNumber);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.l10n.otp_verification_resend_code_text,
              style: AppTextStyle.caption.copyWith(
                color: context.colorScheme.info,
              ),
            ),
          ),
        ),
        const SizedBox(width: 2),
        Visibility(
          visible: !activeResendCodeBtn,
          child: Text(
            '00 : ${duration.inSeconds.toString().padLeft(2, '0')}',
            style: AppTextStyle.caption.copyWith(
              color: context.colorScheme.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
