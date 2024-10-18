import 'package:flutter/cupertino.dart';
import 'package:style/extensions/context_extensions.dart';

Widget dragHandle(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      height: 4,
      width: 32,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: context.colorScheme.outline,
          borderRadius: BorderRadius.circular(10)),
    ),
  );
}
