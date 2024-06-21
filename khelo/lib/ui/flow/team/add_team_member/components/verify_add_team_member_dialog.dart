import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';

class VerifyAddTeamMemberDialog extends StatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required String phoneNumber,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return VerifyAddTeamMemberDialog(phoneNumber: phoneNumber);
      },
    );
  }

  final String phoneNumber;

  const VerifyAddTeamMemberDialog({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<VerifyAddTeamMemberDialog> createState() =>
      _VerifyAddTeamMemberDialogState();
}

class _VerifyAddTeamMemberDialogState extends State<VerifyAddTeamMemberDialog> {
  String verificationNumber = "";
  String? errorString;
  static const int verifyNumberCount = 4;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorScheme.containerLowOnSurface,
      title: Text(
        context.l10n.add_team_member_verify_title,
        style: AppTextStyle.header1
            .copyWith(color: context.colorScheme.textPrimary, fontSize: 26),
      ),
      content: IntrinsicHeight(
        child: Column(
          children: [
            Text(
              context.l10n
                  .add_team_member_verify_placeholder_text(verifyNumberCount),
              style: AppTextStyle.subtitle1.copyWith(
                color: context.colorScheme.textPrimary,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: AppTextField(
                maxLength: verifyNumberCount,
                autoFocus: true,
                keyboardType: TextInputType.phone,
                borderType: AppTextFieldBorderType.outline,
                borderColor: BorderColor(
                  focusColor: Colors.transparent,
                  unFocusColor: Colors.transparent,
                ),
                errorText: errorString,
                backgroundColor: context.colorScheme.containerLow,
                borderRadius: BorderRadius.circular(12),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                style: AppTextStyle.header1.copyWith(
                  color: context.colorScheme.textPrimary,
                ),
                textAlign: TextAlign.center,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                onChanged: (value) => setState(() {
                  verificationNumber = value;
                  errorString = null;
                }),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: context.pop,
            child: Text(
              context.l10n.common_cancel_title,
              style: AppTextStyle.button.copyWith(
                  color: context.colorScheme.textPrimary, fontSize: 18),
            )),
        TextButton(
            onPressed: verificationNumber.trim().length == verifyNumberCount
                ? () {
                    final lastDigits = widget.phoneNumber.substring(
                        widget.phoneNumber.length - verifyNumberCount);
                    if (lastDigits == verificationNumber) {
                      context.pop(lastDigits == verificationNumber);
                    } else {
                      setState(() {
                        errorString =
                            context.l10n.add_team_member_verify_error_text;
                      });
                    }
                  }
                : null,
            child: Text(
              context.l10n.add_team_member_verify_title,
              style: AppTextStyle.button.copyWith(
                  color: verificationNumber.trim().length == verifyNumberCount
                      ? context.colorScheme.textPrimary
                      : context.colorScheme.textDisabled,
                  fontSize: 18),
            )),
      ],
    );
  }
}
