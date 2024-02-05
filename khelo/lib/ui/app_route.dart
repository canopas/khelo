import 'dart:io';

import 'package:data/api/team/team_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/ui/flow/intro/intro_screen.dart';
import 'package:khelo/ui/flow/settings/edit_profile/edit_profile_screen.dart';
import 'package:khelo/ui/flow/sign_in/phone_verification/phone_verification_screen.dart';
import 'package:khelo/ui/flow/team/add_team/add_team_screen.dart';
import 'package:khelo/ui/flow/team/add_team_member/add_team_member_screen.dart';

import 'flow/main/main_screen.dart';
import 'flow/sign_in/sign_in_with_phone/sign_in_with_phone_screen.dart';

class AppRoute {
  static const pathPhoneNumberVerification = '/phone-number-verification';
  static const pathEditProfile = '/edit-profile';
  static const pathAddTeamMember = '/add-team-member';
  static const pathAddTeam = '/add-team';

  final String path;
  final String? name;
  final WidgetBuilder builder;

  const AppRoute(this.path, {this.name, required this.builder});

  void go(BuildContext context) {
    if (name != null) {
      GoRouter.of(context).goNamed(name!, extra: builder);
    } else {
      GoRouter.of(context).go(path, extra: builder);
    }
  }

  static void popTo(
    BuildContext context,
    String path, {
    bool inclusive = false,
  }) {
    while (GoRouter.of(context)
            .routerDelegate
            .currentConfiguration
            .matches
            .last
            .matchedLocation !=
        path) {
      if (!GoRouter.of(context).canPop()) {
        return;
      }
      GoRouter.of(context).pop();
    }

    if (inclusive && GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
  }

  Future<T?> push<T extends Object?>(BuildContext context) {
    if (name != null) {
      return GoRouter.of(context).pushNamed(name!, extra: builder);
    } else {
      return GoRouter.of(context).push(path, extra: builder);
    }
  }

  Future<T?> pushReplacement<T extends Object?>(BuildContext context) {
    if (name != null) {
      return GoRouter.of(context).pushReplacementNamed(name!, extra: builder);
    } else {
      return GoRouter.of(context).pushReplacement(path, extra: builder);
    }
  }

  Future<T?> pushNamed<T extends Object?>(BuildContext context) {
    if (name == null) {
      throw UnsupportedError('Name has to be set to use this feature!');
    }
    return GoRouter.of(context).pushNamed(name!, extra: builder);
  }

  bool isCurrent(BuildContext context) {
    final currentLocation = GoRouter.of(context).location();
    return currentLocation == path;
  }

  GoRoute goRoute() => GoRoute(
        path: path,
        name: path,
        builder: (context, state) => state.widget(context),
      );

  // Routes
  static AppRoute get main => AppRoute("/", builder: (_) => const MainScreen());

  static AppRoute get intro =>
      AppRoute("/intro", builder: (_) => const IntroScreen());

  static AppRoute get phoneLogin =>
      AppRoute("/phone-login", builder: (_) => SignInWithPhoneScreen());

  static AppRoute addTeam({TeamModel? team}) => AppRoute(pathAddTeam,
      builder: (_) => AddTeamScreen(
            editTeam: team,
          ));

  static AppRoute addTeamMember({required TeamModel team}) =>
      AppRoute(pathAddTeamMember,
          builder: (_) => AddTeamMemberScreen(team: team));

  static AppRoute verifyOTP({
    required String verificationId,
    required String phoneNumber,
  }) =>
      AppRoute(pathPhoneNumberVerification,
          builder: (_) => PhoneVerificationScreen(
                phoneNumber: phoneNumber,
                verificationId: verificationId,
              ));

  static AppRoute editProfile({bool isToCreateAccount = false}) => AppRoute(
      pathEditProfile,
      builder: (_) => EditProfileScreen(isToCreateAccount: isToCreateAccount));

  static final routes = [
    GoRoute(
      path: main.path,
      builder: (context, state) {
        return state.extra == null ? const MainScreen() : state.widget(context);
      },
    ),
    GoRoute(
      path: intro.path,
      builder: (context, state) {
        return state.extra == null
            ? const IntroScreen()
            : state.widget(context);
      },
    ),
    GoRoute(
      path: pathEditProfile,
      builder: (context, state) {
        return state.extra == null
            ? const EditProfileScreen(
                isToCreateAccount: true,
              )
            : state.widget(context);
      },
    ),
    phoneLogin.goRoute(),
    GoRoute(
      path: pathAddTeamMember,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathPhoneNumberVerification,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathAddTeam,
      pageBuilder: (context, state) => adaptivePage(
        child: state.widget(context),
        fullscreenDialog: true,
      ),
    ),
  ];

  static Page<T> adaptivePage<T>({
    required Widget child,
    bool fullscreenDialog = false,
  }) {
    if (Platform.isIOS) {
      return CupertinoPage<T>(child: child, fullscreenDialog: fullscreenDialog);
    } else {
      return MaterialPage<T>(child: child, fullscreenDialog: fullscreenDialog);
    }
  }
}

extension GoRouterStateExtensions on GoRouterState {
  Widget widget(BuildContext context) => (extra as WidgetBuilder)(context);
}

extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
