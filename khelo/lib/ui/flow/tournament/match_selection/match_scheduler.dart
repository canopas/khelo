import 'dart:math';

import 'package:collection/collection.dart';
import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/extensions/list_extensions.dart';
import 'package:data/utils/grouping_utils.dart';

import 'match_selection_view_model.dart';

class DataClass {
  final List<TeamModel> teams = [
    TeamModel(id: "1", name: "A", name_lowercase: "a"),
    TeamModel(id: "2", name: "B", name_lowercase: "b"),
    TeamModel(id: "3", name: "C", name_lowercase: "c"),
    TeamModel(id: "4", name: "D", name_lowercase: "d"),
    TeamModel(id: "5", name: "E", name_lowercase: "e"),
    TeamModel(id: "6", name: "F", name_lowercase: "f"),
    TeamModel(id: "7", name: "G", name_lowercase: "g"),
    TeamModel(id: "8", name: "H", name_lowercase: "h"),
    TeamModel(id: "9", name: "I", name_lowercase: "i"),
    TeamModel(id: "10", name: "J", name_lowercase: "j"),
    TeamModel(id: "11", name: "K", name_lowercase: "k"),
    TeamModel(id: "12", name: "L", name_lowercase: "l"),
    TeamModel(id: "13", name: "M", name_lowercase: "m"),
    // TeamModel(id: "14", name: "N", name_lowercase: "n"),
    // TeamModel(id: "15", name: "O", name_lowercase: "o"),
    // TeamModel(id: "16", name: "P", name_lowercase: "p"),
    // TeamModel(id: "17", name: "Q", name_lowercase: "q"),
    // TeamModel(id: "18", name: "R", name_lowercase: "r"),
    // TeamModel(id: "19", name: "S", name_lowercase: "s"),
    // TeamModel(id: "20", name: "T", name_lowercase: "t"),
    // TeamModel(id: "21", name: "U", name_lowercase: "u"),
    // TeamModel(id: "22", name: "V", name_lowercase: "v"),
    // TeamModel(id: "23", name: "W", name_lowercase: "w"),
    // TeamModel(id: "24", name: "X", name_lowercase: "x"),
    // TeamModel(id: "25", name: "Y", name_lowercase: "y"),
    // TeamModel(id: "26", name: "Z", name_lowercase: "z"),
  ];

  final MatchModel defaultMatchModel = MatchModel(
    id: "",
    teams: [],
    match_type: MatchType.limitedOvers,
    number_of_over: 4,
    over_per_bowler: 2,
    city: "Surat",
    ground: "Surat",
    ball_type: BallType.leather,
    pitch_type: PitchType.cement,
    created_by: "",
    match_status: MatchStatus.yetToStart,
    match_group: MatchGroup.round,
    match_group_number: 1,
  );
  late List<MatchModel> matches;

  DataClass() {
    matches = [
      defaultMatchModel.copyWith(
        match_group: MatchGroup.round,
        match_group_number: 1,
        teams: [
          MatchTeamModel(
              team_id: teams[0].id,
              team: teams[0],
              over: 2,
              run: 20,
              wicket: 2),
          MatchTeamModel(
              team_id: teams[1].id,
              team: teams[1],
              over: 1.4,
              run: 22,
              wicket: 3)
        ],
        match_status: MatchStatus.finish,
        toss_winner_id: teams[0].id,
        toss_decision: TossDecision.bat,
      ),
      defaultMatchModel.copyWith(
        match_group: MatchGroup.round,
        match_group_number: 1,
        teams: [
          MatchTeamModel(
              team_id: teams[2].id,
              team: teams[2],
              over: 2,
              run: 20,
              wicket: 2),
          MatchTeamModel(
              team_id: teams[3].id,
              team: teams[3],
              over: 1.4,
              run: 22,
              wicket: 3)
        ],
        match_status: MatchStatus.finish,
        toss_winner_id: teams[3].id,
        toss_decision: TossDecision.bat,
      ),
      defaultMatchModel.copyWith(
        match_group: MatchGroup.round,
        match_group_number: 1,
        teams: [
          MatchTeamModel(
              team_id: teams[4].id,
              team: teams[4],
              over: 2,
              run: 20,
              wicket: 2),
          MatchTeamModel(
              team_id: teams[5].id,
              team: teams[5],
              over: 1.4,
              run: 22,
              wicket: 3)
        ],
        match_status: MatchStatus.finish,
        toss_winner_id: teams[4].id,
        toss_decision: TossDecision.bat,
      ),
      defaultMatchModel.copyWith(
        match_group: MatchGroup.semifinal,
        match_group_number: 1,
        teams: [teams[1], teams[3]]
            .map((e) => MatchTeamModel(team_id: e.id, team: e))
            .toList(),
      ),
    ];
  }
}

class TeamPoints {
  TeamModel team;
  int points;
  int runRate;
  int wickets;

  TeamPoints({
    required this.team,
    required this.points,
    required this.runRate,
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
        return scheduleDoubleEliminationMatches();
      case TournamentType.superOver:
        return scheduleSuperOverMatches();
      case TournamentType.bestOf:
        return scheduleBestOfMatches();
      default:
        throw Exception('Unsupported match type');
    }
  }

  GroupedMatchMap scheduleKnockOutMatches() {
    final GroupedMatchMap additionalScheduledMatches = scheduledMatches;
    final List<TeamModel> teamPool = List.of(teams);

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
      final matchResults =
          matches.map((e) => e.matchResult).whereType<MatchResult>().toList();

      final teams =
          matches.expand((e) => e.teams.map((e) => e.team)).toSet().toList();

      final points = calculateTeamPoints(matchResults, teams);
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
      final matchResults =
          matches.map((e) => e.matchResult).whereType<MatchResult>().toList();

      final teams =
          matches.expand((e) => e.teams.map((e) => e.team)).toSet().toList();

      final points = calculateTeamPoints(matchResults, teams);
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
    return {};
  }

  GroupedMatchMap scheduleSuperOverMatches() {
    return {};
  }

  GroupedMatchMap scheduleBestOfMatches() {
    return {};
  }

  GroupedMatchMap scheduleKnockOutMatchesWithArguments(
    GroupedMatchMap matches,
    List<TeamModel> teams,
  ) {
    final GroupedMatchMap additionalScheduledMatches = matches;
    final List<TeamModel> teamPool = List.of(teams);

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
      List<MatchResult> roundsResults, List<TeamModel> teams) {
    List<TeamPoints> teamPoints = teams
        .map(
            (team) => TeamPoints(team: team, points: 0, runRate: 0, wickets: 0))
        .toList();

    for (var match in roundsResults) {
      if (match.winType == WinnerByType.run) {
        var winningTeam =
            teamPoints.firstWhere((team) => team.team.id == match.teamId);
        winningTeam.points += 2;
        winningTeam.runRate += match.difference;
      } else if (match.winType == WinnerByType.wicket) {
        var winningTeam =
            teamPoints.firstWhere((team) => team.team.id == match.teamId);
        winningTeam.points += 2;
        winningTeam.wickets += match.difference;
      } else if (match.winType == WinnerByType.tie) {
        var team1 =
            teamPoints.firstWhere((team) => team.team.id == match.teamId);
        var team2 =
            teamPoints.firstWhere((team) => team.team.id != match.teamId);
        team1.points += 1;
        team2.points += 1;
      }
    }

    // Sort teams first by points, then by run rate (or wickets for tiebreaker)
    teamPoints.sort((a, b) {
      if (a.points != b.points) {
        return b.points.compareTo(a.points); // Sort by points descending
      } else {
        return b.runRate
            .compareTo(a.runRate); // Tiebreak by run rate (descending)
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
    // TODO: handle tie and point system
    final winner = matches
        .where((match) => match.matchResult != null)
        .map((match) => match.teams
            .firstWhere((team) => team.team.id == match.matchResult!.teamId)
            .team)
        .toList();

    teams.addAll(winner);
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
}
