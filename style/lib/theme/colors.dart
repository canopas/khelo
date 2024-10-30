import 'package:flutter/material.dart';

import '../text/app_text_style.dart';

const primaryLightColor = Color(0xFF01579B);
const primaryDarkColor = Color(0xFF66BDFF);

const primaryVariantLightColor = Color(0x4D01579B);
const primaryVariantDarkColor = Color(0x6601579B);

const secondaryColor = Color(0xFFF57F17);

const containerHighLightColor = Color(0x1401345D);
const containerNormalLightColor = Color(0x0F01345D);
const containerLowLightColor = Color(0x0A01345D);

const containerHighDarkColor = Color(0x3DD1E1ED);
const containerNormalDarkColor = Color(0x29D1E1ED);
const containerLowDarkColor = Color(0x14D1E1ED);

const textPrimaryLightColor = Color(0xDE000000);
const textSecondaryLightColor = Color(0x99000000);
const textDisabledLightColor = Color(0x66000000);

const textPrimaryDarkColor = Color(0xFFFFFFFF);
const textSecondaryDarkColor = Color(0xDEFFFFFF);
const textDisabledDarkColor = Color(0x99FFFFFF);

const outlineLightColor = Color(0x14000000);
const outlineDarkColor = Color(0x1FFFFFFF);

const surfaceLightColor = Color(0xFFFFFFFF);
const surfaceDarkColor = Color(0xFF212121);

const awarenessAlertColor = Color(0xFFC62828);
const awarenessPositiveColor = Color(0xFF4CAF50);
const awarenessWarningColor = Color(0xFFF9A825);
const awarenessInfoColor = Color(0xFF0D47A1);

final ThemeData _materialLightTheme = ThemeData.light(useMaterial3: true);
final ThemeData _materialDarkTheme = ThemeData.dark(useMaterial3: true);

final ThemeData materialThemeDataLight = _materialLightTheme.copyWith(
  primaryColor: primaryLightColor,
  dividerColor: outlineLightColor,
  datePickerTheme: _materialLightTheme.datePickerTheme.copyWith(
    backgroundColor: surfaceLightColor,
    headerForegroundColor: textPrimaryLightColor,
    dividerColor: outlineLightColor,
    inputDecorationTheme:
        _materialLightTheme.datePickerTheme.inputDecorationTheme?.copyWith(
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: awarenessAlertColor)),
    ),
  ),
  timePickerTheme: _materialLightTheme.timePickerTheme.copyWith(
    backgroundColor: surfaceLightColor,
    dialBackgroundColor: containerLowLightColor,
    dayPeriodColor: primaryLightColor,
    hourMinuteColor: containerLowLightColor,
    inputDecorationTheme:
        _materialLightTheme.timePickerTheme.inputDecorationTheme?.copyWith(
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: awarenessAlertColor)),
    ),
  ),
  colorScheme: _materialLightTheme.colorScheme.copyWith(
    primary: primaryLightColor,
    secondary: secondaryColor,
    surface: surfaceLightColor,
    onPrimary: textPrimaryDarkColor,
    onSecondary: textSecondaryDarkColor,
    onSurface: textPrimaryLightColor,
  ),
  scaffoldBackgroundColor: surfaceLightColor,
  appBarTheme: _materialLightTheme.appBarTheme.copyWith(
    backgroundColor: surfaceLightColor,
    surfaceTintColor: containerLowLightColor,
    titleTextStyle: _materialLightTheme.appBarTheme.titleTextStyle?.copyWith(
      fontFamily: AppTextStyle.poppinsFontFamily,
      package: 'style',
    ),
  ),
);

final ThemeData materialThemeDataDark = _materialDarkTheme.copyWith(
  primaryColor: primaryDarkColor,
  dividerColor: outlineDarkColor,
  datePickerTheme: _materialDarkTheme.datePickerTheme.copyWith(
    backgroundColor: surfaceDarkColor,
    headerForegroundColor: textPrimaryDarkColor,
    dividerColor: outlineDarkColor,
    inputDecorationTheme:
        _materialDarkTheme.datePickerTheme.inputDecorationTheme?.copyWith(
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: awarenessAlertColor)),
    ),
  ),
  timePickerTheme: _materialDarkTheme.timePickerTheme.copyWith(
    backgroundColor: surfaceDarkColor,
    dialBackgroundColor: containerLowDarkColor,
    dayPeriodColor: primaryDarkColor,
    hourMinuteColor: containerLowDarkColor,
    inputDecorationTheme:
        _materialDarkTheme.timePickerTheme.inputDecorationTheme?.copyWith(
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: awarenessAlertColor)),
    ),
  ),
  colorScheme: _materialDarkTheme.colorScheme.copyWith(
    primary: primaryDarkColor,
    secondary: secondaryColor,
    surface: surfaceDarkColor,
    onPrimary: textPrimaryLightColor,
    onSecondary: textSecondaryLightColor,
    onSurface: textPrimaryDarkColor,
  ),
  scaffoldBackgroundColor: surfaceDarkColor,
  appBarTheme: _materialDarkTheme.appBarTheme.copyWith(
    backgroundColor: surfaceDarkColor,
    surfaceTintColor: containerLowDarkColor,
    titleTextStyle: _materialDarkTheme.appBarTheme.titleTextStyle?.copyWith(
      fontFamily: AppTextStyle.poppinsFontFamily,
      package: 'style',
    ),
  ),
);

class AppColorScheme {
  final Color primary;
  final Color primaryVariant;
  final Color secondary;
  final Color surface;
  final Color outline;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color textInversePrimary;
  final Color textInverseSecondary;
  final Color textInverseDisabled;
  final Color containerHigh;
  final Color containerNormal;
  final Color containerLow;
  final Color positive;
  final Color alert;
  final Color warning;
  final Color info;
  final Color onPrimary;
  final Color onSecondary;
  final Color onDisabled;
  final ThemeMode themeMode;

  AppColorScheme({
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.surface,
    required this.outline,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.textInversePrimary,
    required this.textInverseSecondary,
    required this.textInverseDisabled,
    required this.containerHigh,
    required this.containerNormal,
    required this.containerLow,
    required this.positive,
    required this.alert,
    required this.warning,
    required this.info,
    required this.onPrimary,
    required this.onSecondary,
    required this.onDisabled,
    required this.themeMode,
  });

  Color get containerNormalOnSurface =>
      Color.alphaBlend(containerNormal, surface);

  Color get containerHighOnSurface => Color.alphaBlend(containerHigh, surface);

  Color get containerLowOnSurface => Color.alphaBlend(containerLow, surface);

  Color get primaryVariantOnSurface =>
      Color.alphaBlend(primaryVariant, surface);
}

final appColorSchemeLight = AppColorScheme(
  primary: primaryLightColor,
  primaryVariant: primaryVariantLightColor,
  secondary: secondaryColor,
  surface: surfaceLightColor,
  outline: outlineLightColor,
  textPrimary: textPrimaryLightColor,
  textSecondary: textSecondaryLightColor,
  textDisabled: textDisabledLightColor,
  textInversePrimary: textPrimaryDarkColor,
  textInverseSecondary: textSecondaryDarkColor,
  textInverseDisabled: textDisabledDarkColor,
  containerHigh: containerHighLightColor,
  containerNormal: containerNormalLightColor,
  containerLow: containerLowLightColor,
  positive: awarenessPositiveColor,
  alert: awarenessAlertColor,
  warning: awarenessWarningColor,
  info: awarenessInfoColor,
  onPrimary: textPrimaryDarkColor,
  onSecondary: textSecondaryDarkColor,
  onDisabled: textDisabledLightColor,
  themeMode: ThemeMode.light,
);

final appColorSchemeDark = AppColorScheme(
  primary: primaryDarkColor,
  primaryVariant: primaryVariantDarkColor,
  secondary: secondaryColor,
  surface: surfaceDarkColor,
  outline: outlineDarkColor,
  textPrimary: textPrimaryDarkColor,
  textSecondary: textSecondaryDarkColor,
  textDisabled: textDisabledDarkColor,
  textInversePrimary: textPrimaryLightColor,
  textInverseSecondary: textSecondaryLightColor,
  textInverseDisabled: textDisabledLightColor,
  containerHigh: containerHighDarkColor,
  containerNormal: containerNormalDarkColor,
  containerLow: containerLowDarkColor,
  positive: awarenessPositiveColor,
  alert: awarenessAlertColor,
  warning: awarenessWarningColor,
  info: awarenessInfoColor,
  onPrimary: textPrimaryLightColor,
  onSecondary: textSecondaryDarkColor,
  onDisabled: textDisabledLightColor,
  themeMode: ThemeMode.dark,
);
