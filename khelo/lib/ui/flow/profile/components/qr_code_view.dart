import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/components/app_page.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class QrCodeView extends StatelessWidget {
  final String id;
  final String description;

  const QrCodeView({
    super.key,
    required this.id,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: context.l10n.common_qr_code_title,
      automaticallyImplyLeading: false,
      leading: actionButton(context,
          onPressed: context.pop,
          icon: Icon(
            Icons.close,
            color: context.colorScheme.textPrimary,
          )),
      body: Builder(builder: (context) {
        return Center(
          child: SingleChildScrollView(
            padding: context.mediaQueryPadding +
                const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                QrImageView(
                  data: id,
                  version: QrVersions.auto,
                  size: 200,
                  dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: context.colorScheme.textPrimary),
                  eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: context.colorScheme.textPrimary),
                ),
                const SizedBox(height: 24),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textSecondary),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
