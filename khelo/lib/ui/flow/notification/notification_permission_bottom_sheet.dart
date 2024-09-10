import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../gen/assets.gen.dart';

Future<void> showPermissionBottomSheet(BuildContext context) async {
  return await showModalBottomSheet(
    context: context,
    backgroundColor: context.colorScheme.surface,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              (context.brightness == Brightness.dark)
                  ? Assets.images.icNotificationDark
                  : Assets.images.icNotificationLight,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.notification_popup_title,
              style: AppTextStyle.header2
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            const SizedBox(height: 4),
            Text(
              context.l10n.notification_popup_description,
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: PrimaryButton(
                  context.l10n.notification_popup_later,
                  foreground: context.colorScheme.primary,
                  background: context.colorScheme.containerLow,
                  onPressed: () => Navigator.pop(context),
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: PrimaryButton(
                  context.l10n.common_yes_title,
                  onPressed: () async {
                    if (context.mounted) Navigator.pop(context);

                    final isDeniedForever =
                        await Permission.notification.isPermanentlyDenied;
                    if (isDeniedForever) {
                      await openAppSettings();
                    } else {
                      await Permission.notification.request();
                    }
                  },
                ))
              ],
            ),
          ],
        ),
      );
    },
  );
}
