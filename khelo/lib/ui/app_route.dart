import 'dart:io';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/ui/flow/home/home_view_model.dart';
import 'package:khelo/ui/flow/home/search/search_screen.dart';
import 'package:khelo/ui/flow/intro/intro_screen.dart';
import 'package:khelo/ui/flow/matches/add_match/add_match_screen.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/add_match_officials_screen.dart';
import 'package:khelo/ui/flow/matches/add_match/match_officials/add_match_officials_view_model.dart';
import 'package:khelo/ui/flow/matches/add_match/power_play/power_play_screen.dart';
import 'package:khelo/ui/flow/matches/add_match/select_squad/select_squad_screen.dart';
import 'package:khelo/ui/flow/matches/match_detail/match_detail_tab_screen.dart';
import 'package:khelo/ui/flow/profile/components/qr_code_view.dart';
import 'package:khelo/ui/flow/score_board/add_toss_detail/add_toss_detail_screen.dart';
import 'package:khelo/ui/flow/score_board/score_board_screen.dart';
import 'package:khelo/ui/flow/settings/edit_profile/edit_profile_screen.dart';
import 'package:khelo/ui/flow/sign_in/phone_verification/phone_verification_screen.dart';
import 'package:khelo/ui/flow/team/add_team/add_team_screen.dart';
import 'package:khelo/ui/flow/team/add_team_member/add_team_member_screen.dart';
import 'package:khelo/ui/flow/team/add_team_member/contact_selection/contact_selection_screen.dart';
import 'package:khelo/ui/flow/team/detail/make_admin/make_team_admin_screen.dart';
import 'package:khelo/ui/flow/team/detail/team_detail_screen.dart';
import 'package:khelo/ui/flow/team/scanner/scanner_screen.dart';
import 'package:khelo/ui/flow/team/search_team/search_team_screen.dart';

import 'package:khelo/ui/flow/tournament/add/add_tournament_screen.dart';
import 'flow/home/view_all/home_view_all_screen.dart';
import 'flow/main/main_screen.dart';
import 'flow/settings/support/contact_support_screen.dart';
import 'flow/sign_in/sign_in_with_phone/sign_in_with_phone_screen.dart';
import 'flow/team/user_detail/user_detail_screen.dart';

class AppRoute {
  static const pathPhoneNumberVerification = '/phone-number-verification';
  static const pathEditProfile = '/edit-profile';
  static const pathAddTeamMember = '/add-team-member';
  static const pathAddTeam = '/add-team';
  static const pathPowerPlay = '/power-play';
  static const pathSelectSquad = '/select-squad';
  static const pathAddMatchOfficials = '/add-match-officials';
  static const pathMakeTeamAdmin = "/make-admin";
  static const pathSearchTeam = '/search-team';
  static const pathAddMatch = '/add-match';
  static const pathAddTossDetail = '/add-toss-detail';
  static const pathScoreBoard = '/score-board';
  static const pathScannerScreen = '/scanner-screen';
  static const pathQrCode = '/qr-code';
  static const pathTeamDetail = '/team-detail';
  static const pathUserDetail = '/user-detail';
  static const pathMatchDetailTab = '/match-detail-tab';
  static const pathSearchHome = "/search-home";
  static const pathViewAll = "/view-all";
  static const pathContactSelection = "/contact-selection";

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
      AppRoute("/phone-login", builder: (_) => const SignInWithPhoneScreen());

  static AppRoute get contactSupport => AppRoute(
        "/contact-support",
        builder: (_) => const ContactSupportScreen(),
      );

  static AppRoute scoreBoard({required String matchId}) => AppRoute(
        pathScoreBoard,
        builder: (_) => ScoreBoardScreen(matchId: matchId),
      );

  static AppRoute searchHome({required List<MatchModel> matches}) =>
      AppRoute(pathSearchHome,
          builder: (_) => SearchHomeScreen(matches: matches));

  static AppRoute viewAll(MatchStatusLabel status) =>
      AppRoute(pathViewAll, builder: (_) => HomeViewAllScreen(status: status));

  static AppRoute addTossDetail({required String matchId}) => AppRoute(
        pathAddTossDetail,
        builder: (_) => AddTossDetailScreen(matchId: matchId),
      );

  static AppRoute addMatch({String? matchId, TeamModel? defaultTeam}) =>
      AppRoute(
        pathAddMatch,
        builder: (_) => AddMatchScreen(
          matchId: matchId,
          defaultTeam: defaultTeam,
        ),
      );

  static AppRoute addTournament() => AppRoute(
        pathAddTournament,
        builder: (_) => const AddTournamentScreen(),
      );

  static AppRoute matchDetailTab({required String matchId}) => AppRoute(
        pathMatchDetailTab,
        builder: (_) => MatchDetailTabScreen(matchId: matchId),
      );

  static AppRoute addTeam({TeamModel? team}) => AppRoute(
        pathAddTeam,
        builder: (_) => AddTeamScreen(editTeam: team),
      );

  static AppRoute makeTeamAdmin({required TeamModel team}) =>
      AppRoute(pathMakeTeamAdmin,
          builder: (context) => MakeTeamAdminScreen(team: team));

  static AppRoute searchTeam(
          {List<String>? excludedIds, required bool onlyUserTeams}) =>
      AppRoute(
        pathSearchTeam,
        builder: (_) => SearchTeamScreen(
          excludedIds: excludedIds,
          onlyUserTeams: onlyUserTeams,
        ),
      );

  static AppRoute powerPlay(
          {required int totalOvers,
          List<int>? firstPowerPlay,
          List<int>? secondPowerPlay,
          List<int>? thirdPowerPlay}) =>
      AppRoute(
        pathPowerPlay,
        builder: (_) => PowerPlayScreen(
            totalOvers: totalOvers,
            firstPowerPlay: firstPowerPlay,
            secondPowerPlay: secondPowerPlay,
            thirdPowerPlay: thirdPowerPlay),
      );

  static AppRoute addTeamMember({required TeamModel team}) => AppRoute(
        pathAddTeamMember,
        builder: (_) => AddTeamMemberScreen(team: team),
      );

  static AppRoute addMatchOfficials({List<Officials>? officials}) => AppRoute(
        pathAddMatchOfficials,
        builder: (_) => AddMatchOfficialsScreen(officials: officials),
      );

  static AppRoute selectSquad({
    required TeamModel team,
    List<MatchPlayer>? squad,
    String? captainId,
    String? adminId,
  }) =>
      AppRoute(
        pathSelectSquad,
        builder: (_) => SelectSquadScreen(
          team: team,
          squad: squad,
          captainId: captainId,
          adminId: adminId,
        ),
      );

  static AppRoute verifyOTP(
          {required String countryCode,
          required String verificationId,
          required String phoneNumber}) =>
      AppRoute(pathPhoneNumberVerification,
          builder: (_) => PhoneVerificationScreen(
              countryCode: countryCode,
              phoneNumber: phoneNumber,
              verificationId: verificationId));

  static AppRoute editProfile({bool isToCreateAccount = false}) => AppRoute(
      pathEditProfile,
      builder: (_) => EditProfileScreen(isToCreateAccount: isToCreateAccount));

  static AppRoute teamDetail({required String teamId}) =>
      AppRoute(pathTeamDetail,
          builder: (_) => TeamDetailScreen(teamId: teamId));

  static AppRoute userDetail({
    required String userId,
    bool showAddButton = false,
  }) =>
      AppRoute(pathUserDetail,
          builder: (_) => UserDetailScreen(
                userId: userId,
                showAddButton: showAddButton,
              ));

  static AppRoute scannerScreen({required List<String> addedMembers}) =>
      AppRoute(
        pathScannerScreen,
        builder: (_) => ScannerScreen(addedMembers: addedMembers),
      );

  static AppRoute qrCodeView(
          {required String id, required String description}) =>
      AppRoute(
        pathQrCode,
        builder: (_) => QrCodeView(id: id, description: description),
      );

  static AppRoute contactSelection({required List<String> memberIds}) =>
      AppRoute(pathContactSelection,
          builder: (_) => ContactSelectionScreen(memberIds: memberIds));

  static final routes = [
    GoRoute(
      path: main.path,
      builder: (context, state) {
        return state.extra == null ? const MainScreen() : state.widget(context);
      },
    ),
    GoRoute(
      path: pathSearchHome,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathViewAll,
      builder: (context, state) => state.widget(context),
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
            ? const EditProfileScreen(isToCreateAccount: true)
            : state.widget(context);
      },
    ),
    contactSupport.goRoute(),
    phoneLogin.goRoute(),
    GoRoute(
      path: pathScoreBoard,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathAddTossDetail,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathAddMatch,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathAddTournament,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathMatchDetailTab,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathAddTeamMember,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathSearchTeam,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathPhoneNumberVerification,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathSelectSquad,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathTeamDetail,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathUserDetail,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathContactSelection,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathScannerScreen,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathMakeTeamAdmin,
      builder: (context, state) => state.widget(context),
    ),
    GoRoute(
      path: pathAddTeam,
      pageBuilder: (context, state) => adaptivePage(
        child: state.widget(context),
        fullscreenDialog: true,
      ),
    ),
    GoRoute(
      path: pathPowerPlay,
      pageBuilder: (context, state) => adaptivePage(
        child: state.widget(context),
        fullscreenDialog: true,
      ),
    ),
    GoRoute(
      path: pathAddMatchOfficials,
      pageBuilder: (context, state) => adaptivePage(
        child: state.widget(context),
        fullscreenDialog: true,
      ),
    ),
    GoRoute(
      path: pathQrCode,
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
