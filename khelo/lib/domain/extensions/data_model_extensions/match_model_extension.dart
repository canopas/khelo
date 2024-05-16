import 'package:data/api/match/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';

extension MatchModelString on MatchModel {
  ({String teamName, int difference, String wonByText})? getWinnerSummary(
      BuildContext context) {
    if (match_status != MatchStatus.finish) {
      return null;
    }

    final firstTeam = toss_decision == TossDecision.bat
        ? teams.firstWhere((element) => element.team.id == toss_winner_id)
        : teams.firstWhere((element) => element.team.id != toss_winner_id);
    final secondTeam =
        teams.firstWhere((element) => element.team.id != firstTeam.team.id);

    if (firstTeam.run > secondTeam.run) {
      // first batting team won
      final teamName = firstTeam.team.name;

      final runDifference = firstTeam.run  - secondTeam.run;

      return (
        teamName: teamName,
        difference: runDifference,
        wonByText: context.l10n.common_runs_dot_title,
      );
    } else if (firstTeam.run == secondTeam.run) {
      return (teamName: "", difference: 0, wonByText: "");
    } else {
      // second batting team won
      final teamName = secondTeam.team.name;

      final wicketDifference =
          secondTeam.squad.length - firstTeam.wicket;

      return (
        teamName: teamName,
        difference: wicketDifference,
        wonByText: context.l10n.common_wickets_dot_title,
      );
    }
  }
}
