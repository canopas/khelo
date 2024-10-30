import 'package:data/api/match/match_model.dart';
import 'package:data/api/team/team_model.dart';
import 'package:data/extensions/list_extensions.dart';

class MatchScheduler {
  final List<TeamModel> teams;
  final Map<int, List<MatchModel>> groupMatches;

  MatchScheduler(this.teams, this.groupMatches);

  Map<int, List<MatchModel>> scheduleKnockOutMatch() {
    final teamPool = List.of(teams);

    // Initialize rounds if not already done
    if (groupMatches.isEmpty) {
      groupMatches[1] = [];
    }

    while (teamPool.length > 1) {
      for (final round in groupMatches.entries) {
        // Remove teams that are already scheduled in this round
        teamPool.removeWhere((team) => round.value.any(
            (match) => match.teams.map((e) => e.team.id).contains(team.id)));

        // Shuffle teams to create random matchups and split them into pairs
        teamPool.shuffle();
        final chunked = teamPool.chunked(2);
        for (var pair in chunked) {
          if (pair.length == 2) {
            // Schedule a match only if we have two teams
            round.value.add(MatchModel(
              teams: pair
                  .map((e) => MatchTeamModel(team_id: e.id, team: e))
                  .toList(),
              id: '',
              match_type: MatchType.limitedOvers,
              number_of_over: 10,
              over_per_bowler: 2,
              city: 'surat',
              ground: 'surat',
              ball_type: BallType.leather,
              pitch_type: PitchType.astroturf,
              created_by: '',
              start_at: DateTime.now(),
              start_time: DateTime.now(),
              match_status: MatchStatus.yetToStart,
            ));
          }
        }

        // Collect winning teams from completed matches in this round
        final finishedMatchesWinners = round.value
            .where((match) => match.matchResult != null)
            .map((match) => match.teams
                .firstWhere(
                    (element) => element.team.id == match.matchResult!.teamId)
                .team)
            .toList();
        teamPool.addAll(finishedMatchesWinners);
      }

      // Check if there are teams left to schedule and create a new round if needed
      if (teamPool.length > 1) {
        final newRound = groupMatches.length + 1;
        groupMatches[newRound] = [];
      }
    }

    return groupMatches;
  }

  Map<int, List<MatchModel>> scheduleKnockOutMatchV2() {
    final teamPool = List.of(teams);
    final Map<int, List<MatchModel>> knockoutRounds =
        {}; // Mutable map for storing rounds

    // Initialize first round if empty
    knockoutRounds[1] = [];

    int currentRound = 1;

    // While there's more than one team, continue creating rounds
    while (teamPool.length > 1) {
      // Shuffle and create matches for the current round
      teamPool.shuffle();
      final chunked = teamPool.chunked(2);
      for (var pair in chunked) {
        if (pair.length == 2) {
          // Schedule a match if we have two teams
          knockoutRounds[currentRound]!.add(
            MatchModel(
              teams: pair
                  .map((e) => MatchTeamModel(team_id: e.id, team: e))
                  .toList(),
              id: '',
              match_type: MatchType.limitedOvers,
              match_group: MatchGroup.round,
              match_group_number: currentRound,
              number_of_over: 10,
              over_per_bowler: 2,
              city: 'surat',
              ground: 'surat',
              ball_type: BallType.leather,
              pitch_type: PitchType.astroturf,
              created_by: '',
              start_at: DateTime.now(),
              start_time: DateTime.now(),
              match_status: MatchStatus.yetToStart,
            ),
          );
        }
      }

      // Collect winners and reset teamPool for the next round
      final finishedMatchesWinners = knockoutRounds[currentRound]!
          .where((match) => match.matchResult != null)
          .map((match) => match.teams
              .firstWhere(
                  (element) => element.team.id == match.matchResult!.teamId)
              .team)
          .toList();

      teamPool.clear();
      teamPool.addAll(finishedMatchesWinners);

      // If more than one team remains, prepare for the next round
      if (teamPool.length > 1) {
        currentRound++;
        knockoutRounds[currentRound] = [];
      }
    }

    return knockoutRounds;
  }

  void scheduleMiniRoundRobinV2() {
    final teamPool = List.of(teams);

    const int minMatchesPerTeam = 3;
    const int maxMatchesPerTeam = 4;

    // Initialize rounds if not already done
    if (groupMatches.isEmpty) {
      groupMatches[1] = [];
    }

    int currentRound = groupMatches.length;
    final Map<String, int> scheduledMatches = {}; // Track match count per team

    // Initialize match count for each team
    for (var team in teamPool) {
      scheduledMatches[team.id] = 0;
    }

    while (teamPool.isNotEmpty) {
      // Prepare teams for current round based on match limits
      final List<String> availableTeams = teamPool
          .where((team) => scheduledMatches[team.id]! < maxMatchesPerTeam)
          .map((e) => e.id)
          .toList();

      // Skip if no available teams meet the match count requirements
      if (availableTeams.length < 2) break;

      // Create new round if needed
      currentRound++;
      groupMatches[currentRound] = [];

      // Shuffle teams and start scheduling pairs
      availableTeams.shuffle();
      while (availableTeams.length > 1) {
        final team1 = availableTeams.removeLast();
        final team2 = availableTeams.removeLast();

        // Only schedule if both teams haven’t reached max matches
        if (scheduledMatches[team1]! < maxMatchesPerTeam &&
            scheduledMatches[team2]! < maxMatchesPerTeam) {
          groupMatches[currentRound]!.add(MatchModel(
            teams:
                [team1, team2].map((e) => MatchTeamModel(team_id: e)).toList(),
            id: '',
            match_type: MatchType.limitedOvers,
            number_of_over: 10,
            over_per_bowler: 2,
            city: 'surat',
            ground: 'surat',
            ball_type: BallType.leather,
            pitch_type: PitchType.astroturf,
            created_by: '',
            start_at: DateTime.now(),
            start_time: DateTime.now(),
            match_status: MatchStatus.yetToStart,
          ));
          scheduledMatches[team1] = scheduledMatches[team1]! + 1;
          scheduledMatches[team2] = scheduledMatches[team2]! + 1;
        }
      }

      // Check for any team below min match count and add back to the pool
      teamPool
        ..clear()
        ..addAll(scheduledMatches.entries
            .where((entry) => entry.value < minMatchesPerTeam)
            .map((entry) => TeamModel(
                id: entry.key,
                name: "name",
                name_lowercase: "name_lowercase")));

      // Ensure fairness by re-adding remaining teams for the next round
      if (availableTeams.isNotEmpty) {
        teamPool.addAll(availableTeams.map(
          (e) =>
              TeamModel(id: e, name: "name", name_lowercase: "name_lowercase"),
        ));
      }
    }
  }
}
