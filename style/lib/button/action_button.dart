import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget actionButton(
  BuildContext context, {
  void Function()? onPressed,
  required Widget icon,
  EdgeInsets padding = EdgeInsets.zero,
}) {
  if (Platform.isIOS) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: padding,
      child: icon,
    );
  } else {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      padding: padding,
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
