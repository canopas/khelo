import 'package:flutter/material.dart';

import '../text/app_text_style.dart';

const primaryColor = Color(0xFF01579B);

const secondaryColor = Color(0xFFF57F17);

const containerHighColor = Color(0x1401345D);
const containerNormalColor = Color(0x0F01345D);
const containerLowColor = Color(0x0A01345D);

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
    surfaceTintColor: containerLowColor,
    titleTextStyle: _materialLightTheme.appBarTheme.titleTextStyle?.copyWith(
      fontFamily: AppTextStyle.poppinsFontFamily,
      package: 'style',
    ),
  ),
);

final ThemeData materialThemeDataDark = _materialDarkTheme.copyWith(
  primaryColor: primaryColor,
  dividerColor: outlineColor,
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
    surfaceTintColor: containerLowColor,
    titleTextStyle: _materialDarkTheme.appBarTheme.titleTextStyle?.copyWith(
      fontFamily: AppTextStyle.poppinsFontFamily,
      package: 'style',
    ),
  ),
);

class AppColorScheme {
  final Color primary;
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
  final Color onPrimary;
  final Color onPrimaryVariant;
  final Color onSecondary;
  final Color onDisabled;
  final ThemeMode themeMode;

  AppColorScheme({
    required this.primary,
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
}

final appColorSchemeLight = AppColorScheme(
  primary: primaryColor,
  secondary: secondaryColor,
  surface: surfaceLightColor,
  outline: outlineColor,
  textPrimary: textPrimaryLightColor,
  textSecondary: textSecondaryLightColor,
  textDisabled: textDisabledLightColor,
  textInversePrimary: textPrimaryDarkColor,
  textInverseSecondary: textSecondaryDarkColor,
  textInverseDisabled: textDisabledDarkColor,
  containerHigh: containerHighColor,
  containerNormal: containerNormalColor,
  containerLow: containerLowColor,
  positive: awarenessPositiveColor,
  alert: awarenessAlertColor,
  warning: awarenessWarningColor,
  onPrimary: textPrimaryDarkColor,
  onPrimaryVariant: textPrimaryLightColor,
  onSecondary: textSecondaryDarkColor,
  onDisabled: textDisabledLightColor,
  themeMode: ThemeMode.light,
);

final appColorSchemeDark = AppColorScheme(
  primary: primaryColor,
  secondary: secondaryColor,
  surface: surfaceDarkColor,
  outline: outlineColor,
  textPrimary: textPrimaryDarkColor,
  textSecondary: textSecondaryDarkColor,
  textDisabled: textDisabledDarkColor,
  textInversePrimary: textPrimaryLightColor,
  textInverseSecondary: textSecondaryLightColor,
  textInverseDisabled: textDisabledLightColor,
  containerHigh: containerHighColor,
  containerNormal: containerNormalColor,
  containerLow: containerLowColor,
  positive: awarenessPositiveColor,
  alert: awarenessAlertColor,
  warning: awarenessWarningColor,
  onPrimary: textPrimaryDarkColor,
  onPrimaryVariant: textPrimaryLightColor,
  onSecondary: textSecondaryDarkColor,
  onDisabled: textDisabledLightColor,
  themeMode: ThemeMode.dark,
);
