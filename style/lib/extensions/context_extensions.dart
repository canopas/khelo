import 'package:flutter/material.dart';
import 'package:style/theme/colors.dart';

import '../theme/theme.dart';

extension BuildContextExtensions on BuildContext {
  AppColorScheme get colorScheme => appColorSchemeOf(this);

  Brightness get brightness => MediaQuery.of(this).platformBrightness;

  Size get mediaQuerySize => MediaQuery.of(this).size;

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;
}
