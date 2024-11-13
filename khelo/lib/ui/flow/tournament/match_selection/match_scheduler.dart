import 'dart:collection';
import 'dart:math';

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
        return scheduleKnockOutMatchesWithArguments(scheduledMatches, teams,
            addInitialRound: true);
      case TournamentType.miniRobin:
        return scheduleMiniRoundRobinMatches();
      case TournamentType.boxLeague:
        return scheduleBoxLeagueMatches();
      case TournamentType.doubleOut:
        return scheduleDoubleEliminationMatches();
      case TournamentType.superOver:
        return scheduleSuperOverMatches();
      case TournamentType.bestOf:
        return scheduleBestOfMatches();
      case TournamentType.custom:
        return scheduledMatches;
    }
  }

  GroupedMatchMap scheduleKnockOutMatchesWithArguments(
    GroupedMatchMap matches,
    List<TeamModel> teams, {
    bool addInitialRound = false,
  }) {
    final List<TeamModel> teamPool = List.of(teams);
    if (addInitialRound && !matches.containsKey(MatchGroup.round)) {
      matches.addAll({
        MatchGroup.round: {1: []}
      });
    }
    final GroupedMatchMap additionalScheduledMatches =
        SplayTreeMap<MatchGroup, Map<int, List<MatchModel>>>.from(
            matches, (a, b) => a.index.compareTo(b.index));
    final GroupedMatchMap tempScheduledMatches = {};
    while (teamPool.length > 1) {
      additionalScheduledMatches.forEach((group, groupNumbers) {
        groupNumbers.forEach((number, matches) {
          removeAlreadyScheduledTeams(matches, teamPool);

          final teamPairs = createTeamPairsForKnockout(teamPool);
          addMatches(matches, teamPairs, group, number);

          teamPool.removeWhere((team) => teamPairs
              .any((element) => element.length == 2 && element.contains(team)));

          addWinnerTeamsBackToTeam(matches, teamPool);

          if (teamPool.length <= 1) {
            return;
          }
          final expectedQualifier = matches.length;
          if (expectedQualifier > 8) {
            addRoundToGroupMap(tempScheduledMatches, number);
          } else if (expectedQualifier > 4) {
            addNewGroupToGroupMap(
                tempScheduledMatches, MatchGroup.quarterfinal);
          } else if (expectedQualifier > 2) {
            addNewGroupToGroupMap(tempScheduledMatches, MatchGroup.semifinal);
          } else if (expectedQualifier == 2) {
            addNewGroupToGroupMap(tempScheduledMatches, MatchGroup.finals);
          }
        });
      });

      additionalScheduledMatches.addAll(tempScheduledMatches);
      tempScheduledMatches.clear();
    }

    return additionalScheduledMatches;
  }

  GroupedMatchMap scheduleMiniRoundRobinMatches() {
    final GroupedMatchMap additionalScheduledMatches = scheduledMatches;
    final List<TeamModel> teamPool = List.of(teams);

    final int totalTeams = teamPool.length;
    int matchesPerTeam;

    if (totalTeams <= 4) {
      matchesPerTeam = totalTeams - 1;
    } else if (totalTeams <= 8) {
      matchesPerTeam = 4;
    } else {
      matchesPerTeam = 3;
    }

    final rounds = scheduledMatches[MatchGroup.round] ?? {1: []};
    final Map<int, List<MatchModel>> tempRound = {};

    List<List<TeamPoints>> teamPoints = [];
    while (teamPool.length > 1) {
      rounds.forEach((number, matches) {
        removeTeamsThatReachedLimit(matches, teamPool, matchesPerTeam);

        final teamPairs = createTeamPairsForRoundRobin(
            teamPool,
            matchesPerTeam,
            matches
                .map((element) => element.teams.map((e) => e.team).toList())
                .toList());
        addMatches(matches, teamPairs, MatchGroup.round, number);

        teamPool.removeWhere(
            (team) => teamPairs.any((pair) => pair.contains(team)));
      });

      tempRound.forEach((key, value) {
        rounds.putIfAbsent(key, () => value);
      });
      tempRound.clear();
    }
    rounds.forEach((key, matches) {
      final teams =
          matches.expand((e) => e.teams.map((e) => e.team)).toSet().toList();

      final points = calculateTeamPoints(matches, teams);
      teamPoints.add(points);
    });

    teamPoints.sort((a, b) {
      if (a.first.points != b.first.points) {
        return b.first.points.compareTo(a.first.points);
      } else {
        return b.first.runRate.compareTo(a.first.runRate);
      }
    });

    final expectedQualifier = teams.length;
    final List<TeamModel> teamsToAdd;
    if (expectedQualifier > 4) {
      addNewGroupToGroupMap(
          additionalScheduledMatches, MatchGroup.quarterfinal);
      teamsToAdd = teamPoints.first.take(8).map((e) => e.team).toList();
    } else if (expectedQualifier > 2) {
      addNewGroupToGroupMap(additionalScheduledMatches, MatchGroup.semifinal);
      teamsToAdd = teamPoints.first.take(4).map((e) => e.team).toList();
    } else if (expectedQualifier == 2) {
      addNewGroupToGroupMap(additionalScheduledMatches, MatchGroup.finals);
      teamsToAdd = teamPoints.first.take(2).map((e) => e.team).toList();
    } else {
      teamsToAdd = [];
    }

    teamPool.addAll(teamsToAdd);
    final copyMatches = additionalScheduledMatches;
    copyMatches.remove(MatchGroup.round);
    final knockOutPhaseMatches =
        scheduleKnockOutMatchesWithArguments(copyMatches, teamPool);

    additionalScheduledMatches
        .addAll({MatchGroup.round: rounds, ...knockOutPhaseMatches});

    return additionalScheduledMatches;
  }

  GroupedMatchMap scheduleBoxLeagueMatches() {
    final GroupedMatchMap additionalScheduledMatches = scheduledMatches;
    final teamPool = teams;
    final int boxSize = 3;

    final rounds = scheduledMatches[MatchGroup.round] ?? {1: []};
    final Map<int, List<MatchModel>> tempRound = {};

    List<List<TeamPoints>> teamPoints = [];
    while (teamPool.length > 1) {
      rounds.forEach((number, matches) {
        final teams =
            matches.expand((e) => e.teams.map((e) => e.team)).toSet().toList();

        int remainingTeam = teamPool.length % boxSize;
        removeAlreadyScheduledTeams(matches, teamPool);
        if (teams.length < boxSize || remainingTeam > 0) {
          teams.addAll(teamPool.take(boxSize - teams.length + 1));
        }

        final teamPairs = createTeamPairsForRoundRobin(
            teams,
            teams.length - 1,
            matches
                .map((element) => element.teams.map((e) => e.team).toList())
                .toList());

        addMatches(matches, teamPairs, MatchGroup.round, number);

        teamPool.removeWhere((team) =>
            teamPairs.any((pair) => pair.length == 2 && pair.contains(team)));

        if (teamPool.length > 1 && !rounds.containsKey(number + 1)) {
          tempRound[number + 1] = [];
        }
      });

      tempRound.forEach((key, value) {
        rounds.putIfAbsent(key, () => value);
      });
      tempRound.clear();
    }
    rounds.forEach((key, matches) {
      final teams =
          matches.expand((e) => e.teams.map((e) => e.team)).toSet().toList();

      final points = calculateTeamPoints(matches, teams);
      teamPoints.add(points);
    });

    teamPoints.sort((a, b) {
      if (a.first.points != b.first.points) {
        return b.first.points.compareTo(a.first.points);
      } else {
        return b.first.runRate.compareTo(a.first.runRate);
      }
    });

    final expectedQualifier =
        additionalScheduledMatches[MatchGroup.round]?.length ?? 0;
    int pickTeamNumber = 0;
    if (expectedQualifier > 4) {
      addNewGroupToGroupMap(
          additionalScheduledMatches, MatchGroup.quarterfinal);
      pickTeamNumber = 8;
    } else if (expectedQualifier > 2) {
      addNewGroupToGroupMap(additionalScheduledMatches, MatchGroup.semifinal);
      pickTeamNumber = 4;
    } else if (expectedQualifier == 2) {
      addNewGroupToGroupMap(additionalScheduledMatches, MatchGroup.finals);
      pickTeamNumber = 2;
    }

    int round = 0;

    while (teamPool.length < pickTeamNumber) {
      final teamsToAdd = teamPoints
          .map((e) => e.elementAtOrNull(round)?.team)
          .whereType<TeamModel>()
          .toList();

      if (teamsToAdd.isEmpty) break;

      final remainingSlots = pickTeamNumber - teamPool.length;

      teamPool.addAll(teamsToAdd.take(remainingSlots));

      round++;
    }

    final copyMatches = additionalScheduledMatches;
    copyMatches.remove(MatchGroup.round);
    final knockOutPhaseMatches =
        scheduleKnockOutMatchesWithArguments(copyMatches, teamPool);

    additionalScheduledMatches
        .addAll({MatchGroup.round: rounds, ...knockOutPhaseMatches});

    return additionalScheduledMatches;
  }

  GroupedMatchMap scheduleDoubleEliminationMatches() {
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

  GroupedMatchMap scheduleSuperOverMatches() {
    return {};
  }

  GroupedMatchMap scheduleBestOfMatches() {
    return {};
  }

  // Helper functions
  int calculateMatchesPerTeam(int teamCount) {
    if (teamCount <= 1) {
      throw ArgumentError("Team count must be greater than 1.");
    }

    const double maxPercentage = 0.75;
    int matchesPerTeam =
        (teamCount * maxPercentage / log(teamCount + 1)).round();
    matchesPerTeam = max(1, matchesPerTeam);

    return matchesPerTeam;
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

    for (var match in matches) {
      if (match.matchResult == null) {
        continue;
      }
      MatchResult result = match.matchResult!;

      var team1Data = match.teams.first;
      var team2Data = match.teams.last;

      var team1Points =
          teamPoints.firstWhere((team) => team.team.id == team1Data.team_id);
      var team2Points =
          teamPoints.firstWhere((team) => team.team.id == team2Data.team_id);

      team1Points.runs += team1Data.run;
      team1Points.oversFaced.add(team1Data.over.toBalls());
      team1Points.wickets += team1Data.wicket;

      team2Points.runs += team2Data.run;
      team2Points.oversFaced.add(team2Data.over.toBalls());
      team2Points.wickets += team2Data.wicket;

      switch (result.winType) {
        case WinnerByType.run:
          var winningTeamPoints =
              teamPoints.firstWhere((team) => team.team.id == result.teamId);
          winningTeamPoints.points += 2;
          break;

        case WinnerByType.wicket:
          var winningTeamPoints =
              teamPoints.firstWhere((team) => team.team.id == result.teamId);
          winningTeamPoints.points += 2;
          break;

        case WinnerByType.tie:
          team1Points.points += 1;
          team2Points.points += 1;
          break;
      }
    }

    for (var team in teamPoints) {
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

  List<List<TeamModel>> createTeamPairsForRoundRobin(List<TeamModel> teamPool,
      int matchesPerTeam, List<List<TeamModel>> scheduledMatches) {
    final List<List<TeamModel>> teamPairs = [];

    // Initialize match count based on the existing scheduled matches
    final Map<TeamModel, int> matchCount = {for (var team in teamPool) team: 0};

    // Update match count based on already scheduled matches
    for (var match in scheduledMatches) {
      for (var team in match) {
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

  List<List<TeamModel>> createTeamPairsForKnockout(List<TeamModel> teams) {
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

  void addRoundToGroupMap(
      GroupedMatchMap additionalScheduledMatches, int currentRoundNumber) {
    if (!additionalScheduledMatches.containsKey(MatchGroup.round)) {
      return;
    }
    if (additionalScheduledMatches[MatchGroup.round]!
        .containsKey(currentRoundNumber + 1)) {
      return;
    }
    additionalScheduledMatches[MatchGroup.round]![currentRoundNumber + 1] = [];
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

    final chunks = createTeamPairsForKnockout(teams);
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
}
