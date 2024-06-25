import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/extensions/context_extensions.dart';

void showConfirmationDialog(
  BuildContext context, {
  String? title,
  String? message,
  String? confirmBtnText,
  bool isDestructiveAction = true,
  String? cancelBtnText,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
}) {
  HapticFeedback.mediumImpact();
  showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog.adaptive(
        surfaceTintColor: context.colorScheme.containerNormalOnSurface,
        title: (title != null) ? Text(title) : null,
        content: Text(message ?? context.l10n.alert_confirm_default_title),
        actions: [
          adaptiveAction(
            context,
            onPressed: () async {
              context.pop();
              onCancel?.call();
            },
            child: Text(cancelBtnText ?? context.l10n.common_cancel_title),
          ),
          adaptiveAction(
            context,
            isDestructiveAction: isDestructiveAction,
            onPressed: () async {
              context.pop();
              onConfirm();
            },
            child: Text(
              confirmBtnText ?? context.l10n.common_yes_title,
            ),
          ),
        ],
      );
    },
  );
}

Widget adaptiveAction(
  BuildContext context, {
  VoidCallback? onPressed,
  required Widget child,
  bool isDestructiveAction = false,
}) {
  final ThemeData theme = Theme.of(context);
  switch (theme.platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return TextButton(
        onPressed: onPressed,
        child: DefaultTextStyle(
          style: TextStyle(
            inherit: true,
            color: isDestructiveAction
                ? context.colorScheme.alert
                : context.colorScheme.textSecondary,
          ),
          child: child,
        ),
      );
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return CupertinoDialogAction(
        onPressed: onPressed,
        isDestructiveAction: isDestructiveAction,
        textStyle: isDestructiveAction
            ? null
            : TextStyle(
                color: isDestructiveAction
                    ? context.colorScheme.textPrimary
                    : context.colorScheme.textSecondary,
              ),
        child: child,
      );
  }
}
