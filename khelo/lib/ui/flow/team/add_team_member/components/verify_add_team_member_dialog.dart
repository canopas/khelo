import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class VerifyAddTeamMemberDialog extends StatefulWidget {
  final String phoneNumber;

  const VerifyAddTeamMemberDialog({super.key, required this.phoneNumber});

  @override
  State<VerifyAddTeamMemberDialog> createState() =>
      _VerifyAddTeamMemberDialogState();
}

class _VerifyAddTeamMemberDialogState extends State<VerifyAddTeamMemberDialog> {
  String verificationNumber = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.add_team_member_verify_title),
      content: Wrap(
        children: [
          Text(context.l10n.add_team_member_verify_placeholder_text),
          TextField(
            maxLength: 5,
            textAlign: TextAlign.center,
            style: AppTextStyle.subtitle1
                .copyWith(color: context.colorScheme.textPrimary, fontSize: 34),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            onChanged: (value) {
              setState(() {
                verificationNumber = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              "Cancel",
              style: AppTextStyle.button
                  .copyWith(color: context.colorScheme.textPrimary),
            )),
        TextButton(
            onPressed: verificationNumber.trim().length == 5
                ? () {
                    if (widget.phoneNumber == verificationNumber) {
                      context.pop(true);
                    } else {
                      context.pop();
                    }
                  }
                : null,
            child: Text(
              "Verify",
              style: AppTextStyle.button.copyWith(
                  color: verificationNumber.trim().length == 5
                      ? context.colorScheme.textPrimary
                      : context.colorScheme.textDisabled),
            )),
      ],
    );
  }
}
