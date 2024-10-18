import 'package:flutter/material.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class EmptyScreen extends StatelessWidget {
  final String title;
  final String description;
  final bool isShowButton;
  final String? buttonTitle;
  final VoidCallback? onTap;

  const EmptyScreen({
    super.key,
    required this.title,
    required this.description,
    this.isShowButton = true,
    this.buttonTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Text(
                title,
                style: AppTextStyle.header2
                    .copyWith(color: context.colorScheme.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textDisabled),
                textAlign: TextAlign.center,
              ),
              if (isShowButton) ...[
                const SizedBox(height: 24),
                PrimaryButton(
                  buttonTitle ?? '',
                  edgeInsets:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  expanded: false,
                  onPressed: onTap,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
