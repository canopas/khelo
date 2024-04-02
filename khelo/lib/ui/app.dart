import 'dart:io';

import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/theme/colors.dart';
import 'package:style/theme/theme.dart';

import 'app_route.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    final AppRoute initialRoute;
    if (ref.read(hasUserSession)) {
      final currentUser = ref.read(currentUserPod);
      if (currentUser?.name == null || currentUser!.name!.isEmpty) {
        initialRoute = AppRoute.editProfile(isToCreateAccount: true);
      } else {
        initialRoute = AppRoute.main;
      }
    } else {
      initialRoute = AppRoute.intro;
    }

    _router = GoRouter(
      initialLocation: initialRoute.path,
      routes: AppRoute.routes,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.brightness == Brightness.dark;
    final colorScheme = isDarkMode ? appColorSchemeDark : appColorSchemeLight;

    return AppTheme(
        colorScheme: colorScheme,
        child: Builder(
          builder: (context) {
            if (Platform.isIOS) {
              return CupertinoApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: _router,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: CupertinoThemeData(
                  brightness: context.brightness,
                  primaryColor: colorScheme.primary,
                  primaryContrastingColor: colorScheme.onPrimary,
                  barBackgroundColor: colorScheme.surface,
                  scaffoldBackgroundColor: colorScheme.surface,
                  applyThemeToAll: true,
                ),
              );
            } else {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: _router,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: materialThemeDataLight,
                darkTheme: materialThemeDataDark,
              );
            }
          },
        ));
  }
}
