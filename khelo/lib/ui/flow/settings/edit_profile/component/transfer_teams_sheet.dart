import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class TransferTeamsSheet extends StatelessWidget {
  static Future<T?> show<T>(
    BuildContext context, {
    required Function() onButtonTap,
  }) {
    HapticFeedback.mediumImpact();

    return showModalBottomSheet(
      context: context,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) {
        return TransferTeamsSheet(onButtonTap: onButtonTap);
      },
    );
  }

  final Function() onButtonTap;

  const TransferTeamsSheet({super.key, required this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: context.colorScheme.containerLow,
            radius: 35,
            child: Icon(
              Icons.handshake_outlined,
              size: 50,
              color: context.colorScheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.transfer_teams_title,
            style: AppTextStyle.header2
                .copyWith(color: context.colorScheme.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.transfer_teams_description,
            style: AppTextStyle.body1
                .copyWith(color: context.colorScheme.textSecondary),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            context.l10n.transfer_teams_go_to_my_cricket,
            onPressed: onButtonTap,
          ),
        ],
      ),
    );
  }
}
