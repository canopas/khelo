import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class QrCodeSheet extends StatelessWidget {
  final String userId;

  static Future<T?> show<T>(
    BuildContext context, {
    required String userId,
  }) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.surface,
      builder: (context) => QrCodeSheet(userId: userId),
    );
  }

  const QrCodeSheet({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: context.mediaQuerySize.height * 0.8),
      padding: context.mediaQueryPadding +
          const EdgeInsets.only(top: 24, left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        color: context.colorScheme.surface,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: actionButton(context,
                    icon: Icon(
                      Icons.close,
                      color: context.colorScheme.textSecondary,
                    ),
                    onPressed: context.pop)),
            const SizedBox(height: 24),
            QrImageView(
              data: userId,
              version: QrVersions.auto,
              size: 240,
              dataModuleStyle: QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: context.colorScheme.textPrimary),
              eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: context.colorScheme.textPrimary),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.profile_setting_user_id_title,
              textAlign: TextAlign.center,
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
            const SizedBox(height: 4),
            Text(
              userId,
              textAlign: TextAlign.center,
              style: AppTextStyle.subtitle3
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
