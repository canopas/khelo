import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class ConfirmActionDialog extends StatelessWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required String description,
    required String primaryButtonText,
    final String? secondaryButtonText,
    required Function() onConfirmation,
  }) {
    return showAdaptiveDialog(
      context: context,
      builder: (context) {
        return ConfirmActionDialog(
          title: title,
          description: description,
          primaryButtonText: primaryButtonText,
          secondaryButtonText: secondaryButtonText,
          onConfirmation: onConfirmation,
        );
      },
    );
  }

  final String title;
  final String description;
  final String primaryButtonText;
  final String? secondaryButtonText;
  final Function() onConfirmation;

  const ConfirmActionDialog({
    super.key,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    this.secondaryButtonText,
    required this.onConfirmation,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(
        title,
        style: AppTextStyle.header4
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      content: Text(
        description,
        style: AppTextStyle.subtitle2
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(
            secondaryButtonText ?? context.l10n.common_cancel_title,
            style: AppTextStyle.button
                .copyWith(color: context.colorScheme.textSecondary),
          ),
        ),
        TextButton(
          onPressed: () {
            context.pop();
            onConfirmation();
          },
          child: Text(
            primaryButtonText,
            style:
                AppTextStyle.button.copyWith(color: context.colorScheme.alert),
          ),
        ),
      ],
    );
  }
}