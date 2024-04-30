import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/ui/flow/sign_in/phone_verification/phone_verification_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';
import 'package:style/text/app_text_field.dart';

class EnterOTPView extends ConsumerStatefulWidget {
  final int count;

  const EnterOTPView({super.key, required this.count});

  @override
  ConsumerState createState() => _EnterOTPViewState();
}

class _EnterOTPViewState extends ConsumerState<EnterOTPView> {
  List<String> otpValues = [];

  @override
  void initState() {
    super.initState();
    otpValues = List.generate(widget.count, (index) => "", growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(phoneVerificationStateProvider.notifier);

    return AppTextField(
      autoFocus: true,
      maxLength: 6,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      style: AppTextStyle.header1
          .copyWith(color: context.colorScheme.textPrimary, fontSize: 26),
      onChanged: notifier.updateOTP,
    );
  }
}
