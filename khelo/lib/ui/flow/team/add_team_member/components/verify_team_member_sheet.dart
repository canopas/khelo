import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/score_board/components/bottom_sheet_wrapper.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';
import 'package:style/text/app_text_style.dart';

class VerifyTeamMemberSheet extends StatefulWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required String phoneNumber,
  }) {
    HapticFeedback.mediumImpact();

    return showModalBottomSheet(
      context: context,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: VerifyTeamMemberSheet(phoneNumber: phoneNumber),
      ),
    );
  }

  final String phoneNumber;

  const VerifyTeamMemberSheet({super.key, required this.phoneNumber});

  @override
  State<VerifyTeamMemberSheet> createState() => _VerifyTeamMemberSheetState();
}

class _VerifyTeamMemberSheetState extends State<VerifyTeamMemberSheet> {
  String verificationNumber = "";
  String? errorString;
  static const int verifyNumberCount = 4;

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      contentBottomSpacing: 30,
      content: _verifyMemberContent(context),
      action: [
        PrimaryButton(
          context.l10n.common_cancel_title,
          expanded: false,
          background: context.colorScheme.containerLow,
          foreground: context.colorScheme.primary,
          onPressed: context.pop,
        ),
        PrimaryButton(
          context.l10n.common_verify_title,
          expanded: false,
          enabled: verificationNumber.trim().length == verifyNumberCount,
          onPressed: () {
            final lastDigits = widget.phoneNumber
                .substring(widget.phoneNumber.length - verifyNumberCount);
            if (lastDigits == verificationNumber) {
              context.pop(lastDigits == verificationNumber);
            } else {
              setState(() =>
                  errorString = context.l10n.add_team_member_verify_error_text);
            }
          },
        ),
      ],
    );
  }

  Widget _verifyMemberContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.common_verify_title,
          style: AppTextStyle.header3
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 16),
        Text(
          context.l10n
              .add_team_member_verify_placeholder_text(verifyNumberCount),
          style: AppTextStyle.subtitle2
              .copyWith(color: context.colorScheme.textSecondary),
        ),
        const SizedBox(height: 16),
        AppTextField(
          maxLength: verifyNumberCount,
          autoFocus: true,
          borderType: AppTextFieldBorderType.outline,
          borderColor: BorderColor(
            focusColor: Colors.transparent,
            unFocusColor: Colors.transparent,
          ),
          hintText: "0" * verifyNumberCount,
          hintStyle: AppTextStyle.header4.copyWith(
            color: context.colorScheme.outline,
            letterSpacing: 16,
          ),
          errorText: errorString,
          backgroundColor: context.colorScheme.containerLow,
          borderRadius: BorderRadius.circular(12),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          style: AppTextStyle.header4.copyWith(
            color: context.colorScheme.textPrimary,
            letterSpacing: 16,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) => setState(() {
            verificationNumber = value;
            errorString = null;
          }),
        ),
      ],
    );
  }
}
