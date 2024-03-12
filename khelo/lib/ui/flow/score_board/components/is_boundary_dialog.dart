import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class IsBoundaryDialog extends StatelessWidget {
  static Future<T?> show<T>(
    BuildContext context,
  ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const IsBoundaryDialog();
      },
    );
  }

  const IsBoundaryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorScheme.containerLowOnSurface,
      title: Text(
        context.l10n.score_board_boundary_text,
        style: AppTextStyle.subtitle1
            .copyWith(color: context.colorScheme.textPrimary),
      ),
      content: Text(context.l10n.score_board_is_boundary_text,
          style: AppTextStyle.subtitle1
              .copyWith(color: context.colorScheme.textPrimary)),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsOverflowButtonSpacing: 8,
      actions: [
        OnTapScale(
          onTap: () {
            context.pop(false);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              context.l10n.common_no_title,
              style: AppTextStyle.button
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ),
        ),
        OnTapScale(
          onTap: () {
            context.pop(true);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              context.l10n.common_yes_title,
              style: AppTextStyle.button
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ),
        ),
      ],
    );
  }
}
