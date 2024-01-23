import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/ui/flow/sign_in/phone_verification/phone_verification_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < widget.count; i++) ...[
          otpCellTextField(context, notifier, i),
        ],
      ],
    );
  }

  Widget otpCellTextField(
      BuildContext context, PhoneVerificationViewNotifier notifier, int index) {
    return SizedBox(
        width: 50,
        child: CupertinoTextField(
          maxLength: 1,
          autofocus: index == 0,
          textAlign: TextAlign.center,
          style: AppTextStyle.header1
              .copyWith(color: context.colorScheme.textPrimary, fontSize: 26),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          onChanged: (value) {
            if (value.isNotEmpty) {
              if (index != widget.count - 1 && otpValues[index + 1].isEmpty) {
                FocusScope.of(context).nextFocus();
              }
              otpValues[index] = value;
            } else {
              otpValues[index] = "";
            }
            notifier.updateOTP(otpValues.join());
          },
        ));
  }
}
