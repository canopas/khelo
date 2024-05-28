import 'package:flutter/material.dart';

import '../text/app_text_style.dart';

const primaryColor = Color(0xFF01579B);

const primaryVariantLightColor = Color(0xFFEDF5FB);
const primaryVariantDarkColor = Color(0x6601579B);

const secondaryColor = Color(0xFFF57F17);

const containerHighLightColor = Color(0x1401345D);
const containerNormalLightColor = Color(0x0F01345D);
const containerLowLightColor = Color(0x0A01345D);

const containerHighDarkColor = Color(0x14D1E1ED);
const containerNormalDarkColor = Color(0x0FD1E1ED);
const containerLowDarkColor = Color(0x0AD1E1ED);

const textPrimaryLightColor = Color(0xDE000000);
const textSecondaryLightColor = Color(0x99000000);
const textDisabledLightColor = Color(0x66000000);

const textPrimaryDarkColor = Color(0xFFFFFFFF);
const textSecondaryDarkColor = Color(0xDEFFFFFF);
const textDisabledDarkColor = Color(0x99FFFFFF);

const outlineColor = Color(0xFFEBEBEB);

const surfaceLightColor = Color(0xFFFFFFFF);
const surfaceDarkColor = Color(0xFF212121);

const awarenessAlertColor = Color(0xFFC62828);
const awarenessPositiveColor = Color(0xFF4CAF50);
const awarenessWarningColor = Color(0xFFF9A825);
const awarenessInfoColor = Color(0xFF0D47A1);

final ThemeData _materialLightTheme = ThemeData.light(useMaterial3: true);
final ThemeData _materialDarkTheme = ThemeData.dark(useMaterial3: true);

final ThemeData materialThemeDataLight = _materialLightTheme.copyWith(
  primaryColor: primaryColor,
  dividerColor: outlineColor,
  datePickerTheme: _materialLightTheme.datePickerTheme.copyWith(
    backgroundColor: surfaceLightColor,
    headerForegroundColor: textPrimaryLightColor,
    dividerColor: outlineColor,
    inputDecorationTheme:
        _materialLightTheme.datePickerTheme.inputDecorationTheme?.copyWith(
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: awarenessAlertColor)),
    ),
  ),
  timePickerTheme: _materialLightTheme.timePickerTheme.copyWith(
    backgroundColor: surfaceLightColor,
    dialBackgroundColor: containerLowLightColor,
    dayPeriodColor: primaryColor,
    hourMinuteColor: containerLowLightColor,
    inputDecorationTheme:
        _materialLightTheme.timePickerTheme.inputDecorationTheme?.copyWith(
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: awarenessAlertColor)),
    ),
  ),
  colorScheme: _materialLightTheme.colorScheme.copyWith(
    primary: primaryColor,
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
  primaryColor: primaryColor,
  dividerColor: outlineColor,
  datePickerTheme: _materialDarkTheme.datePickerTheme.copyWith(
    backgroundColor: surfaceDarkColor,
    headerForegroundColor: textPrimaryDarkColor,
    dividerColor: outlineColor,
    inputDecorationTheme:
        _materialDarkTheme.datePickerTheme.inputDecorationTheme?.copyWith(
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: awarenessAlertColor)),
    ),
  ),
  timePickerTheme: _materialDarkTheme.timePickerTheme.copyWith(
    backgroundColor: surfaceDarkColor,
    dialBackgroundColor: containerLowDarkColor,
    dayPeriodColor: primaryColor,
    hourMinuteColor: containerLowDarkColor,
    inputDecorationTheme:
        _materialDarkTheme.timePickerTheme.inputDecorationTheme?.copyWith(
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: awarenessAlertColor)),
    ),
  ),
  colorScheme: _materialDarkTheme.colorScheme.copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    surface: surfaceDarkColor,
    onPrimary: textPrimaryDarkColor,
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
  final Color onPrimaryVariant;
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
    required this.onPrimaryVariant,
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
  primary: primaryColor,
  primaryVariant: primaryVariantLightColor,
  secondary: secondaryColor,
  surface: surfaceLightColor,
  outline: outlineColor,
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
  onPrimaryVariant: textPrimaryLightColor,
  onSecondary: textSecondaryDarkColor,
  onDisabled: textDisabledLightColor,
  themeMode: ThemeMode.light,
);

final appColorSchemeDark = AppColorScheme(
  primary: primaryColor,
  primaryVariant: primaryVariantDarkColor,
  secondary: secondaryColor,
  surface: surfaceDarkColor,
  outline: outlineColor,
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
  onPrimary: textPrimaryDarkColor,
  onPrimaryVariant: textPrimaryLightColor,
  onSecondary: textSecondaryDarkColor,
  onDisabled: textDisabledLightColor,
  themeMode: ThemeMode.dark,
);
