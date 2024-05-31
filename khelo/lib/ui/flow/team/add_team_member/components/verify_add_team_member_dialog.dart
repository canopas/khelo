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
        return VerifyAddTeamMemberDialog(
          phoneNumber: phoneNumber,
        );
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
              context.l10n.add_team_member_verify_placeholder_text,
              style: AppTextStyle.subtitle1.copyWith(
                color: context.colorScheme.textPrimary,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: AppTextField(
                maxLength: 5,
                autoFocus: true,
                keyboardType: TextInputType.phone,
                borderType: AppTextFieldBorderType.outline,
                borderColor: BorderColor(
                  focusColor: Colors.transparent,
                  unFocusColor: Colors.transparent,
                ),
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
                onChanged: (value) {
                  setState(() {
                    verificationNumber = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => context.pop(),
            child: Text(
              context.l10n.common_cancel_title,
              style: AppTextStyle.button.copyWith(
                  color: context.colorScheme.textPrimary, fontSize: 18),
            )),
        TextButton(
            onPressed: verificationNumber.trim().length == 5
                ? () => context.pop(widget.phoneNumber == verificationNumber)
                : null,
            child: Text(
              context.l10n.add_team_member_verify_title,
              style: AppTextStyle.button.copyWith(
                  color: verificationNumber.trim().length == 5
                      ? context.colorScheme.textPrimary
                      : context.colorScheme.textDisabled,
                  fontSize: 18),
            )),
      ],
    );
  }
}
