import 'dart:io';
import 'package:flutter/material.dart';
import 'package:style/button/action_button.dart';
import 'package:style/extensions/context_extensions.dart';

Widget moreOptionButton(
  BuildContext context, {
  Function()? onPressed,
  double size = 24,
  Color? tintColor,
  Color? backgroundColor,
}) {
  return actionButton(context,
      onPressed: onPressed,
      icon: CircleAvatar(
        radius: 16,
        backgroundColor: backgroundColor ?? Colors.transparent,
        child: Icon(
          Platform.isIOS ? Icons.more_horiz_rounded : Icons.more_vert_rounded,
          size: size,
          color: tintColor ?? context.colorScheme.textPrimary,
        ),
      ));
}
