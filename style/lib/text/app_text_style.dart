import 'package:flutter/material.dart';

class AppTextStyle {
  static const String interFontFamily = 'Inter';

  static const TextStyle header1 = TextStyle(
    fontFamily: interFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    letterSpacing: -0.96,
    package: 'style',
  );

  static const TextStyle header2 = TextStyle(
    fontFamily: interFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 22,
    letterSpacing: -0.88,
    height: 1.4,
    package: 'style',
  );

  static const TextStyle header3 = TextStyle(
    fontFamily: interFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    letterSpacing: -0.8,
    height: 1.4,
    package: 'style',
  );

  static const TextStyle header4 = TextStyle(
    fontFamily: interFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    letterSpacing: -0.72,
    height: 1.4,
    package: 'style',
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: interFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.4,
    letterSpacing: -0.72,
    package: 'style',
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: interFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.4,
    letterSpacing: -0.64,
    package: 'style',
  );

  static const TextStyle button = TextStyle(
    fontFamily: interFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.2,
    package: 'style',
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: interFontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 15,
    height: 1.4,
    package: 'style',
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: interFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.2,
    package: 'style',
  );
}