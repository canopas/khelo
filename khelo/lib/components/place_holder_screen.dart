import 'package:flutter/cupertino.dart';
import 'package:style/button/primary_button.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class PlaceHolderScreen extends StatelessWidget {
  final Widget image;
  final String title;
  final String? message;
  final EdgeInsets padding;
  final String? actionBtnTitle;
  final Widget? messageWidget;
  final VoidCallback? onActionBtnTap;

  const PlaceHolderScreen({
    super.key,
    required this.image,
    required this.title,
    this.message,
    this.messageWidget,
    this.padding = const EdgeInsets.all(32),
    this.actionBtnTitle,
    this.onActionBtnTap,
  }) : assert(
          messageWidget != null || message != null,
          'Cannot provide both a message and a messageWidget',
        );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              image,
              SizedBox(
                height: 40,
                width: context.mediaQuerySize.width,
              ),
              Text(
                title,
                style: AppTextStyle.header1.copyWith(
                  color: context.colorScheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Visibility(
                visible: messageWidget != null,
                replacement: Text(
                  message ?? '',
                  style: AppTextStyle.subtitle1.copyWith(
                    color: context.colorScheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                child: messageWidget ?? const SizedBox(),
              ),
              const SizedBox(height: 40),
              if (actionBtnTitle != null) ...[
                PrimaryButton(
                  edgeInsets:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  actionBtnTitle ?? '',
                  onPressed: onActionBtnTap,
                  expanded: false,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
