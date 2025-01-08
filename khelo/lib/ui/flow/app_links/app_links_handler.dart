import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/widgets.dart';

import '../../app_route.dart';

const String _routePrefixTournament = 'tournament';
const String _routePrefixMatch = 'match';
const String _routePrefixTeam = 'team';

class AppLinksHandler {
  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  void init(BuildContext context) {
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      if (!context.mounted) return;
      try {
        final pathSegments = uri.pathSegments;

        if (pathSegments.isEmpty) {
          return;
        }

        if (pathSegments.first == _routePrefixTournament) {
          final tournamentId = pathSegments[1];
          AppRoute.main.go(context);
          AppRoute.tournamentDetail(tournamentId: tournamentId).push(context);
        }

        if (pathSegments.first == _routePrefixMatch) {
          final matchId = pathSegments[1];
          AppRoute.main.go(context);
          AppRoute.matchDetailTab(matchId: matchId).push(context);
        }

        if (pathSegments.first == _routePrefixTeam) {
          final teamId = pathSegments[1];
          AppRoute.main.go(context);
          AppRoute.teamDetail(teamId: teamId).push(context);
        }
      } catch (e, s) {
        debugPrint('Error handling app link $e $s');
      }
    });
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
