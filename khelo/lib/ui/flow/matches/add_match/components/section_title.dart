import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionTitle({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 24.0,
        bottom: 16.0,
      ),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: AppTextStyle.header4
                .copyWith(color: context.colorScheme.textPrimary),
          )),
          trailing ?? const SizedBox()
        ],
      ),
    );
  }
}
