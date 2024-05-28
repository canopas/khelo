import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/context_extensions.dart';
import 'app_text_style.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextStyle? style;
  final Color? backgroundColor;
  final bool expands;
  final bool enabled;
  final BorderRadius? borderRadius;
  final AppTextFieldBorderType borderType;
  final BorderColor? borderColor;
  final double borderWidth;
  final TextInputAction? textInputAction;
  final String? hintText;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isCollapsed;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;
  final bool autoFocus;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Function(PointerDownEvent)? onTapOutside;

  const AppTextField({
    super.key,
    this.label,
    this.labelStyle,
    this.controller,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.style,
    this.backgroundColor,
    this.expands = false,
    this.enabled = true,
    this.onChanged,
    this.borderType = AppTextFieldBorderType.underline,
    this.borderColor,
    this.borderWidth = 1,
    this.textInputAction,
    this.borderRadius,
    this.hintText,
    this.hintStyle,
    this.contentPadding,
    this.isDense,
    this.isCollapsed,
    this.autoFocus = false,
    this.keyboardType,
    this.focusNode,
    this.inputFormatters,
    this.prefixIcon,
    this.textAlign = TextAlign.start,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    if (label == null) {
      return _textField(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: labelStyle ??
              AppTextStyle.body2.copyWith(
                color: context.colorScheme.textDisabled,
              ),
        ),
        if (borderType == AppTextFieldBorderType.outline)
          const SizedBox(height: 12),
        _textField(context),
      ],
    );
  }

  Widget _textField(BuildContext context) => Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          enabled: enabled,
          maxLines: maxLines,
          minLines: minLines,
          inputFormatters: inputFormatters,
          expands: expands,
          textInputAction: textInputAction,
          autofocus: autoFocus,
          keyboardType: keyboardType,
          focusNode: focusNode,
          textAlign: textAlign,
          style: style ??
              AppTextStyle.subtitle2.copyWith(
                color: context.colorScheme.textPrimary,
              ),
          onTapOutside: onTapOutside ??
              (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
          buildCounter: (context,
                  {required currentLength,
                  required isFocused,
                  required maxLength}) =>
              const SizedBox(),
          maxLength: maxLength,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            isDense: isDense,
            isCollapsed: isCollapsed,
            hintText: hintText,
            hintStyle: hintStyle,
            fillColor: backgroundColor,
            filled: backgroundColor != null,
            focusedBorder: _border(context, true),
            enabledBorder: _border(context, false),
            contentPadding: contentPadding ??
                (borderType == AppTextFieldBorderType.outline
                    ? const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      )
                    : null),
          ),
        ),
      );

  InputBorder _border(BuildContext context, bool focused) {
    switch (borderType) {
      case AppTextFieldBorderType.none:
        return const UnderlineInputBorder(
          borderSide: BorderSide.none,
        );
      case AppTextFieldBorderType.outline:
        return OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          borderSide: BorderSide(
            color: focused
                ? borderColor?.focusColor ?? context.colorScheme.primary
                : borderColor?.unFocusColor ?? context.colorScheme.outline,
            width: borderWidth,
          ),
        );
      case AppTextFieldBorderType.underline:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: focused
                ? borderColor?.focusColor ?? context.colorScheme.primary
                : borderColor?.unFocusColor ?? context.colorScheme.outline,
            width: borderWidth,
          ),
        );
    }
  }
}

enum AppTextFieldBorderType {
  none,
  outline,
  underline,
}

class BorderColor {
  Color? focusColor;
  Color? unFocusColor;

  BorderColor({this.focusColor, this.unFocusColor});
}