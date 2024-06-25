import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_field.dart';

import 'app_text_style.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function() onChange;
  final Widget? suffixIcon;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChange,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      borderRadius: BorderRadius.circular(30),
      contentPadding: const EdgeInsets.all(16),
      borderType: AppTextFieldBorderType.outline,
      onChanged: (value) => onChange(),
      backgroundColor: context.colorScheme.containerLowOnSurface,
      hintText: hintText,
      style: AppTextStyle.subtitle2.copyWith(
        color: context.colorScheme.textPrimary,
      ),
      hintStyle: AppTextStyle.subtitle3.copyWith(
        color: context.colorScheme.textDisabled,
      ),
      borderColor: BorderColor(
        focusColor: Colors.transparent,
        unFocusColor: Colors.transparent,
      ),
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      prefixIcon: Icon(
        CupertinoIcons.search,
        color: context.colorScheme.textDisabled,
        size: 24,
      ),
      suffixIcon: suffixIcon,
    );
  }
}
