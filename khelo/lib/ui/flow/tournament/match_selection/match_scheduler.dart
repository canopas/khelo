import 'package:collection/collection.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/extensions/double_extensions.dart';
import 'package:data/extensions/list_extensions.dart';
import 'package:data/utils/grouping_utils.dart';

import 'match_selection_view_model.dart';

class TeamPoints {
  TeamModel team;
  int points;
  double runRate;
  int runs;
  double oversFaced;
  int wickets;

  TeamPoints({
    required this.team,
    required this.points,
    required this.runRate,
    required this.runs,
    required this.oversFaced,
    required this.wickets,
  });
}

class MatchScheduler {
  late final GroupedMatchMap scheduledMatches;
  final List<TeamModel> teams;
  final TournamentType matchType;

  MatchScheduler(this.teams, List<MatchModel> matches, this.matchType) {
    if (matches.isEmpty) {
      scheduledMatches = {
        MatchGroup.round: {1: []}
      };
      return;
    }
    scheduledMatches = groupByTwoFields<MatchModel, MatchGroup, int>(
      matches,
      primaryGroupByKey: (match) => match.match_group ?? MatchGroup.round,
      secondaryGroupByKey: (match) => match.match_group_number ?? 1,
    );
  }

  GroupedMatchMap scheduleMatchesByType() {
    switch (matchType) {
      case TournamentType.knockOut:
        return scheduleKnockOutMatches();
      case TournamentType.miniRobin:
        return scheduleMiniRoundRobinMatches();
      case TournamentType.boxLeague:
        return scheduleBoxLeagueMatches();
      case TournamentType.doubleOut:
        return scheduleDoubleOutMatches();
      case TournamentType.bestOfThree:
        return scheduleBestOfThreeMatches();
      case TournamentType.custom:
        return scheduledMatches;
    }
  }

  GroupedMatchMap scheduleKnockOutMatches() {
    final GroupedMatchMap additionalScheduledMatches =
        Map.from(scheduledMatches);
    final List<TeamModel> teamPool = List.of(teams);

    MatchGroup currentGroup = MatchGroup.round;
    int currentRound = 1;

    while (teamPool.length > 1) {
      final group =
          additionalScheduledMatches.putIfAbsent(currentGroup, () => {1: []});
      final matches = group[currentRound] ?? [];
      final expectedQualifier = handleSingleKnockoutPhase(
          matches, teamPool, currentGroup, currentRound);
      if (expectedQualifier > 8) {
        currentRound++;
      } else if (expectedQualifier > 4) {
        currentRound = 1;
        currentGroup = MatchGroup.quarterfinal;
      } else if (expectedQualifier > 2) {
        currentRound = 1;
        currentGroup = MatchGroup.semifinal;
      } else if (expectedQualifier == 2) {
        currentRound = 1;
        currentGroup = MatchGroup.finals;
      }
    }

    return additionalScheduledMatches;
  }

  GroupedMatchMap scheduleMiniRoundRobinMatches() {
    final GroupedMatchMap additionalScheduledMatches =
        Map.from(scheduledMatches);
    final List<TeamModel> teamPool = List.of(teams);

    MatchGroup currentGroup = MatchGroup.round;
    int currentRound = 1;
    final int totalTeams = teamPool.length;
    int matchesPerTeam;

    if (totalTeams <= 4) {
      matchesPerTeam = totalTeams - 1;
    } else if (totalTeams <= 8) {
      matchesPerTeam = 4;
    } else {
      matchesPerTeam = 3;
    }

    while (teamPool.length > 1) {
      final group =
          additionalScheduledMatches.putIfAbsent(currentGroup, () => {1: []});
      final matches = group[currentRound] ?? [];
      int expectedQualifiers = 0;

      if (currentGroup == MatchGroup.round) {
        handleSingleMiniRobinMatches(
            matches, teamPool, matchesPerTeam, currentGroup, currentRound);
        group[currentRound] = matches;

        expectedQualifiers = teams.length;
        final List<List<TeamPoints>> teamPoints = [];

        additionalScheduledMatches[MatchGroup.round]!.forEach((key, matches) {
          final teams = matches
              .expand((e) => e.teams.map((e) => e.team))
              .toSet()
              .toList();

          final List<TeamPoints> points = calculateTeamPoints(matches, teams);
          teamPoints.add(points);
        });

        teamPoints.sort((a, b) {
          if (a.firstOrNull?.points != b.firstOrNull?.points) {
            return (b.firstOrNull?.points ?? 0)
                .compareTo(a.firstOrNull?.points ?? 0);
          } else {
            return (b.firstOrNull?.runRate ?? 0)
                .compareTo(a.firstOrNull?.runRate ?? 0);
          }
        });

        final List<TeamModel> teamsToAdd;

        if (expectedQualifiers > 4) {
          teamsToAdd = teamPoints.first.take(8).map((e) => e.team).toList();
        } else if (expectedQualifiers > 2) {
          teamsToAdd = teamPoints.first.take(4).map((e) => e.team).toList();
        } else if (expectedQualifiers == 2) {
          teamsToAdd = teamPoints.first.take(2).map((e) => e.team).toList();
        } else {
          teamsToAdd = [];
        }

        teamPool.addAll(teamsToAdd);
      } else {
        expectedQualifiers = handleSingleKnockoutPhase(
          matches,
          teamPool,
          currentGroup,
          currentRound,
        );
        group[currentRound] = matches;
      }

      if (expectedQualifiers > 4) {
        currentRound = 1;
        currentGroup = MatchGroup.quarterfinal;
      } else if (expectedQualifiers > 2) {
        currentRound = 1;
        currentGroup = MatchGroup.semifinal;
      } else if (expectedQualifiers == 2) {
        currentRound = 1;
        currentGroup = MatchGroup.finals;
      }
    }

    return additionalScheduledMatches;
  }

  GroupedMatchMap scheduleBoxLeagueMatches() {
    final GroupedMatchMap additionalScheduledMatches =
        Map.from(scheduledMatches);
    final List<TeamModel> teamPool = List.of(teams);

    MatchGroup currentGroup = MatchGroup.round;
    int currentRound = 1;
    final int boxSize = 3;

    while (teamPool.length > 1) {
      final group =
          additionalScheduledMatches.putIfAbsent(currentGroup, () => {1: []});
      final matches = group[currentRound] ?? [];
      int expectedQualifiers = 0;

      if (currentGroup == MatchGroup.round) {
        handleSingleBoxLeague(
          additionalScheduledMatches[MatchGroup.round]!
              .values
              .expand((element) => element)
              .toList(),
          matches,
          teamPool,
          currentGroup,
          currentRound,
          boxSize,
        );
        group[currentRound] = matches;

        if (teamPool.length <= 1) {
          final List<List<TeamPoints>> teamPoints = [];
          additionalScheduledMatches[MatchGroup.round]!.forEach((key, matches) {
            final teams = matches
                .expand((e) => e.teams.map((e) => e.team))
                .toSet()
                .toList();

            final List<TeamPoints> points = calculateTeamPoints(matches, teams);
            teamPoints.add(points);
          });

          teamPoints.sort((a, b) {
            if (a.firstOrNull?.points != b.firstOrNull?.points) {
              return (b.firstOrNull?.points ?? 0)
                  .compareTo(a.firstOrNull?.points ?? 0);
            } else {
              return (b.firstOrNull?.runRate ?? 0)
                  .compareTo(a.firstOrNull?.runRate ?? 0);
            }
          });

          int teamsTobeAdded =
              additionalScheduledMatches[MatchGroup.round]?.length ?? 0;
          if (teamsTobeAdded > 4) {
            expectedQualifiers = 8;
          } else if (teamsTobeAdded > 2) {
            expectedQualifiers = 4;
          } else if (teamsTobeAdded == 2) {
            expectedQualifiers = 2;
          }

          int round = 0;
          while (teamPool.length < expectedQualifiers) {
            final List<TeamModel> teamsToAdd = teamPoints
                .map((e) => e.elementAtOrNull(round)?.team)
                .whereType<TeamModel>()
                .toList();
            if (teamsToAdd.isEmpty) break;
            final remainingSlots = expectedQualifiers - teamPool.length;

            teamPool.addAll(teamsToAdd.take(remainingSlots));

            round++;
          }
        } else {
          currentRound++;
        }
      } else {
        expectedQualifiers = handleSingleKnockoutPhase(
          matches,
          teamPool,
          currentGroup,
          currentRound,
        );
        group[currentRound] = matches;
      }

      if (expectedQualifiers > 4) {
        currentRound = 1;
        currentGroup = MatchGroup.quarterfinal;
      } else if (expectedQualifiers > 2) {
        currentRound = 1;
        currentGroup = MatchGroup.semifinal;
      } else if (expectedQualifiers == 2) {
        currentRound = 1;
        currentGroup = MatchGroup.finals;
      }
    }

    return additionalScheduledMatches;
  }

  GroupedMatchMap scheduleDoubleOutMatches() {
    final GroupedMatchMap additionalScheduledMatches = scheduledMatches;
    final teamPool = List.of(teams);

    final roundOne = additionalScheduledMatches[MatchGroup.round]?[1] ?? [];
    final roundTwo = additionalScheduledMatches[MatchGroup.round]?[2] ?? [];

    final win = scheduleSingleBracketTeams(roundOne, teamPool, true);
    final los = scheduleSingleBracketTeams(roundTwo, teamPool, false);
    final rounds = {1: roundOne};
    if (roundTwo.isNotEmpty) {
      rounds.addAll({2: roundTwo});
    }

    additionalScheduledMatches.addAll({MatchGroup.round: rounds});
    if (win != null && los != null) {
      addNewGroupToGroupMap(additionalScheduledMatches, MatchGroup.finals);
      final finalRounds =
          additionalScheduledMatches[MatchGroup.finals]![1] ?? [];
      bool isMatchAdded = finalRounds.any((match) =>
          match.teams.map((e) => e.team_id).contains(win.id) &&
          match.teams.map((e) => e.team_id).contains(los.id));
      if (!isMatchAdded) {
        addMatches(
            additionalScheduledMatches[MatchGroup.finals]![1] ?? [],
            [
              [win, los]
            ],
            MatchGroup.finals,
            1);
      }
    }
    return additionalScheduledMatches;
  }

  GroupedMatchMap scheduleBestOfThreeMatches() {
    final GroupedMatchMap additionalScheduledMatches =
        Map.from(scheduledMatches);
    final List<TeamModel> teamPool = List.of(teams);

    MatchGroup currentGroup = MatchGroup.round;
    int currentRound = 1;

    while (teamPool.length > 1) {
      final group =
          additionalScheduledMatches.putIfAbsent(currentGroup, () => {1: []});
      final matches = group[currentRound] ?? [];
      int expectedQualifiers = 0;

      if (currentGroup == MatchGroup.round) {
        expectedQualifiers = handleSingleBestOfThreePhase(
            matches, teamPool, currentGroup, currentRound);
      } else {
        expectedQualifiers = handleSingleKnockoutPhase(
          matches,
          teamPool,
          currentGroup,
          currentRound,
        );
      }

      group[currentRound] = matches;

      if (expectedQualifiers > 8) {
        currentRound++;
      } else if (expectedQualifiers > 4) {
        currentRound = 1;
        currentGroup = MatchGroup.quarterfinal;
      } else if (expectedQualifiers > 2) {
        currentRound = 1;
        currentGroup = MatchGroup.semifinal;
      } else if (expectedQualifiers == 2) {
        currentRound = 1;
        currentGroup = MatchGroup.finals;
      }
    }

    return additionalScheduledMatches;
  }

  List<TeamPoints> calculateTeamPoints(
      List<MatchModel> matches, List<TeamModel> teams) {
    List<TeamPoints> teamPoints = teams
        .map((team) => TeamPoints(
              team: team,
              points: 0,
              runRate: 0,
              wickets: 0,
              runs: 0,
              oversFaced: 0,
            ))
        .toList();

    for (final match in matches) {
      if (match.matchResult == null) {
        continue;
      }
      MatchResult result = match.matchResult!;

      MatchTeamModel team1Data = match.teams.first;
      MatchTeamModel team2Data = match.teams.last;

      TeamPoints team1Points =
          teamPoints.firstWhere((team) => team.team.id == team1Data.team_id);
      TeamPoints team2Points =
          teamPoints.firstWhere((team) => team.team.id == team2Data.team_id);

      team1Points.runs += team1Data.run;
      team1Points.oversFaced.add(team1Data.over.toBalls());
      team1Points.wickets += team1Data.wicket;

      team2Points.runs += team2Data.run;
      team2Points.oversFaced.add(team2Data.over.toBalls());
      team2Points.wickets += team2Data.wicket;

      switch (result.winType) {
        case WinnerByType.run:
          TeamPoints winningTeamPoints =
              teamPoints.firstWhere((team) => team.team.id == result.teamId);
          winningTeamPoints.points += 2;
          break;

        case WinnerByType.wicket:
          TeamPoints winningTeamPoints =
              teamPoints.firstWhere((team) => team.team.id == result.teamId);
          winningTeamPoints.points += 2;
          break;

        case WinnerByType.tie:
          team1Points.points += 1;
          team2Points.points += 1;
          break;
      }
    }

    for (final team in teamPoints) {
      if (team.oversFaced > 0) {
        team.runRate = team.runs / team.oversFaced;
      }
    }

    teamPoints.sort((a, b) {
      if (a.points != b.points) {
        return b.points.compareTo(a.points);
      } else {
        return b.runRate.compareTo(a.runRate);
      }
    });

    return teamPoints;
  }

  List<List<TeamModel>> createRoundRobinTeamPairs(List<TeamModel> teamPool,
      int matchesPerTeam, List<List<TeamModel>> scheduledMatches) {
    final List<List<TeamModel>> teamPairs = [];

    // Initialize match count based on the existing scheduled matches
    final Map<TeamModel, int> matchCount = {
      for (final team in teamPool) team: 0
    };

    // Update match count based on already scheduled matches
    for (final match in scheduledMatches) {
      for (final team in match) {
        if (teamPool.contains(team)) {
          matchCount[team] = (matchCount[team] ?? 0) + 1;
        }
      }
    }

    // Create pairs while respecting the matchesPerTeam limit
    for (int i = 0; i < teamPool.length; i++) {
      for (int j = i + 1; j < teamPool.length; j++) {
        final teamA = teamPool[i];
        final teamB = teamPool[j];

        // Check if this pair is already in the scheduled matches
        final alreadyScheduled = scheduledMatches
            .any((pair) => pair.contains(teamA) && pair.contains(teamB));

        // Only add the pair if not already scheduled and both teams are within limit
        if (!alreadyScheduled &&
            (matchCount[teamA]! < matchesPerTeam) &&
            (matchCount[teamB]! < matchesPerTeam)) {
          // Schedule the new match and update match counts
          teamPairs.add([teamA, teamB]);
          matchCount[teamA] = matchCount[teamA]! + 1;
          matchCount[teamB] = matchCount[teamB]! + 1;
        }
      }
    }

    return teamPairs;
  }

  List<List<TeamModel>> createKnockoutTeamPairs(List<TeamModel> teams) {
    final List<TeamModel> shuffledTeams = List.from(teams)..shuffle();
    return shuffledTeams.chunked(2);
  }

  void addMatches(
    List<MatchModel> existingMatches,
    List<List<TeamModel>> teamPairs,
    MatchGroup group,
    int groupNumber,
  ) {
    for (final pair in teamPairs) {
      if ((group == MatchGroup.quarterfinal && existingMatches.length >= 4) ||
          (group == MatchGroup.semifinal && existingMatches.length >= 2) ||
          (group == MatchGroup.finals && existingMatches.isNotEmpty)) {
        return;
      }
      if (pair.length == 2) {
        existingMatches.add(MatchModel(
          id: '',
          teams: pair
              .map((team) => MatchTeamModel(team_id: team.id, team: team))
              .toList(),
          match_type: MatchType.limitedOvers,
          match_group: group,
          match_group_number: groupNumber,
          number_of_over: 10,
          over_per_bowler: 2,
          city: "",
          ground: "",
          ball_type: BallType.leather,
          pitch_type: PitchType.rough,
          created_by: '',
          match_status: MatchStatus.yetToStart,
        ));
      }
    }
  }

  void removeAlreadyScheduledTeams(
      List<MatchModel> matches, List<TeamModel> teams) {
    teams.removeWhere((element) => matches
        .any((match) => match.teams.any((team) => team.team_id == element.id)));
  }

  void removeTeamsThatReachedLimit(
      List<MatchModel> matches, List<TeamModel> teamPool, int matchesPerTeam) {
    // Remove teams that have already played the maximum allowed number of matches
    teamPool.removeWhere((team) =>
        matches
            .where((match) =>
                match.teams.any((teamModel) => teamModel.team.id == team.id))
            .length >=
        matchesPerTeam);
  }

  void addWinnerTeamsBackToTeam(
    List<MatchModel> matches,
    List<TeamModel> teams,
  ) {
    final winners =
        matches.where((match) => match.matchResult != null).expand((match) {
      if (match.matchResult!.winType == WinnerByType.tie) {
        final teamWithHigherRunRate = match.teams.reduce((team1, team2) {
          double runRate1 = team1.over > 0 ? team1.run / team1.over : 0;
          double runRate2 = team2.over > 0 ? team2.run / team2.over : 0;
          return runRate1 >= runRate2 ? team1 : team2;
        });
        return [teamWithHigherRunRate.team];
      } else {
        return [
          match.teams
              .firstWhere((team) => team.team.id == match.matchResult!.teamId)
              .team
        ];
      }
    }).toList();

    teams.addAll(winners);
  }

  void addNewGroupToGroupMap(
      GroupedMatchMap additionalScheduledMatches, MatchGroup newGroup) {
    if (additionalScheduledMatches.containsKey(newGroup)) {
      return;
    }
    additionalScheduledMatches.addEntries([
      MapEntry(newGroup, {1: []})
    ]);
  }

  TeamModel? scheduleSingleBracketTeams(
    List<MatchModel> matches,
    List<TeamModel> teams,
    bool isWinBracket,
  ) {
    final finishedMatches =
        matches.where((element) => element.match_status == MatchStatus.finish);

    final loserTeams = finishedMatches.map((e) => e.teams
        .firstWhere((element) => element.team_id != e.matchResult!.teamId)
        .team);
    final unFinishedMatches =
        matches.where((element) => element.match_status != MatchStatus.finish);
    teams.removeWhere((team) =>
        loserTeams.contains(team) ||
        unFinishedMatches
            .any((element) => element.teams.map((e) => e.team).contains(team)));

    final chunks = createKnockoutTeamPairs(teams);
    addMatches(matches, chunks, MatchGroup.round, isWinBracket ? 1 : 2);
    TeamModel? teamToReturn;
    if (unFinishedMatches.isEmpty && teams.length == 1) {
      teamToReturn = teams.first;
    }
    teams
        .removeWhere((team) => chunks.any((element) => element.contains(team)));

    if (isWinBracket) {
      teams.addAll(loserTeams);
    }
    return teamToReturn;
  }

  int handleSingleKnockoutPhase(
    List<MatchModel> matches,
    List<TeamModel> teamPool,
    MatchGroup group,
    int number,
  ) {
    removeAlreadyScheduledTeams(matches, teamPool);

    final teamPairs = createKnockoutTeamPairs(teamPool);

    if ((group == MatchGroup.quarterfinal && matches.length < 4) ||
        (group == MatchGroup.semifinal && matches.length < 2) ||
        (group == MatchGroup.finals && matches.isEmpty)) {
      addMatches(matches, teamPairs, group, number);
    }

    teamPool.removeWhere((team) => teamPairs
        .any((element) => element.length == 2 && element.contains(team)));
    if (group != MatchGroup.finals) {
      addWinnerTeamsBackToTeam(matches, teamPool);
    }
    if (group == MatchGroup.quarterfinal && matches.length >= 4) {
      return 4;
    } else if (group == MatchGroup.semifinal && matches.length >= 2) {
      return 2;
    } else if (group == MatchGroup.finals && matches.isNotEmpty) {
      return 1;
    } else {
      return matches.length;
    }
  }

  int handleSingleBestOfThreePhase(
      List<MatchModel> matches, List<TeamModel> teamPool, group, number) {
    final existingPairs = getExistingTeamPairs(matches);
    final remainedTeams = teamPool
        .where((team) => !existingPairs.expand((pair) => pair).contains(team))
        .toList();

    final newPairs = createKnockoutTeamPairs(remainedTeams);
    final allPairs = [...existingPairs, ...newPairs];

    final winners =
        handleBestOfThreeMatchesAndItsWinner(matches, allPairs, group, number);

    teamPool.removeWhere((team) => allPairs.any((pair) =>
        pair.length == 2 && pair.contains(team) && !winners.contains(team.id)));
    return allPairs.length;
  }

  void handleSingleMiniRobinMatches(
      List<MatchModel> matches,
      List<TeamModel> teamPool,
      int matchesPerTeam,
      MatchGroup group,
      int number) {
    removeTeamsThatReachedLimit(matches, teamPool, matchesPerTeam);

    final teamPairs = createRoundRobinTeamPairs(
        teamPool,
        matchesPerTeam,
        matches
            .map((element) => element.teams.map((e) => e.team).toList())
            .toList());
    addMatches(matches, teamPairs, group, number);

    teamPool
        .removeWhere((team) => teamPairs.any((pair) => pair.contains(team)));
  }

  void handleSingleBoxLeague(
    List<MatchModel> allMatches,
    List<MatchModel> matches,
    List<TeamModel> teamPool,
    MatchGroup group,
    int number,
    int boxSize,
  ) {
    final teams =
        matches.expand((e) => e.teams.map((e) => e.team)).toSet().toList();
    completeTeamSet(allMatches, teamPool, teams, boxSize);
    teamPool.removeWhere((element) => teams.contains(element));

    final teamPairs = createRoundRobinTeamPairs(
        teams,
        teams.length - 1,
        matches
            .map((element) => element.teams.map((e) => e.team).toList())
            .toList());
    addMatches(matches, teamPairs, group, number);

    teamPool.removeWhere((team) =>
        teamPairs.any((pair) => pair.length == 2 && pair.contains(team)));
  }

  void completeTeamSet(
    List<MatchModel> allMatches,
    List<TeamModel> sourceTeams,
    List<TeamModel> destinationTeams,
    int boxSize,
  ) {
    final teams = sourceTeams.toList();
    int remainingTeam = sourceTeams.length % boxSize;
    teams.removeWhere((srcTeam) => allMatches
        .any((match) => match.teams.any((team) => team.team_id == srcTeam.id)));
    if (destinationTeams.length < boxSize || remainingTeam > 0) {
      final pick =
          boxSize - destinationTeams.length + (remainingTeam > 0 ? 1 : 0);
      destinationTeams.addAll(teams.take(pick));
    }
  }

  List<List<TeamModel>> getExistingTeamPairs(List<MatchModel> matches) {
    final List<List<TeamModel>> pairs = [];
    for (final match in matches) {
      final pair = match.teams.map((e) => e.team).toList();
      if (!pairs.map((e) => e.map((e) => e.id)).any((element) =>
          element.contains(pair.first.id) && element.contains(pair.last.id))) {
        pairs.add(pair);
      }
    }

    return pairs;
  }

  List<String> handleBestOfThreeMatchesAndItsWinner(
    List<MatchModel> groupMatches,
    List<List<TeamModel>> pair,
    MatchGroup group,
    int number,
  ) {
    final List<String> winnerTeams = [];
    for (final p in pair) {
      final matchesForPair = groupMatches
          .where((element) =>
              element.team_ids.contains(p.first.id) &&
              element.team_ids.contains(p.last.id))
          .toList();
      if (matchesForPair.isEmpty) {
        addMatches(groupMatches, [p], group, number);
        addMatches(groupMatches, [p], group, number);
      } else if (matchesForPair.length == 1) {
        addMatches(groupMatches, [p], group, number);
      } else {
        final finishedMatches =
            matchesForPair.where((element) => element.matchResult != null);
        if (finishedMatches.length >= 2) {
          final winner = getWinnerTeam(
            matchesForPair.toList(),
            p.first.id,
            p.last.id,
          );
          if (winner == null && matchesForPair.length == 2) {
            addMatches(groupMatches, [p], group, number);
          } else if (winner != null) {
            winnerTeams.add(winner);
          }
        }
      }
    }
    return winnerTeams;
  }

  String? getWinnerTeam(
    List<MatchModel> matches,
    String teamOne,
    String teamTwo,
  ) {
    Map<String, int> winner = {teamOne: 0, teamTwo: 0};
    for (final element in matches) {
      final result = element.matchResult;
      if (result == null) continue;

      if (result.winType != WinnerByType.tie &&
          winner.containsKey(result.teamId)) {
        winner[result.teamId] = winner[result.teamId]! + 1;
      } else if (result.winType == WinnerByType.tie) {
        final runRateOne = element.getRunRate(teamOne);
        final runRateTwo = element.getRunRate(teamTwo);
        String? win;
        if (runRateOne != runRateTwo) {
          win = (runRateOne > runRateTwo ? teamOne : teamTwo);
        } else {
          final wicketsOne = element.teams
              .firstWhere((team) => team.team.id == teamOne)
              .wicket;
          final wicketsTwo = element.teams
              .firstWhere((team) => team.team.id == teamTwo)
              .wicket;
          win = (wicketsOne > wicketsTwo ? teamOne : teamTwo);
        }
        if (winner.containsKey(win)) {
          winner[win] = winner[win]! + 1;
        }
      }
    }
    final maxWin = winner.values.max;

    final maxWinners =
        winner.entries.where((element) => element.value == maxWin);

    if (maxWinners.length == 1) {
      return maxWinners.first.key;
    } else {
      return null;
    }
  }
}
