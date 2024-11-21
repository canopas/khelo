// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converter/timestamp_json_converter.dart';
import '../../extensions/double_extensions.dart';
import '../team/team_model.dart';
import '../user/user_models.dart';

part 'match_model.freezed.dart';

part 'match_model.g.dart';

@freezed
class MatchModel with _$MatchModel {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory MatchModel({
    required String id,
    required List<MatchTeamModel> teams,
    String? tournament_id,
    MatchGroup? match_group,
    int? match_group_number,
    required MatchType match_type,
    required int number_of_over,
    required int over_per_bowler,
    @Default([]) List<String> players,
    @Default([]) List<String> team_ids,
    @Default([]) List<String> team_creator_ids,
    @Default([]) List<int> power_play_overs1,
    @Default([]) List<int> power_play_overs2,
    @Default([]) List<int> power_play_overs3,
    required String city,
    required String ground,
    DateTime? start_time,
    @TimeStampJsonConverter() DateTime? start_at,
    required BallType ball_type,
    required PitchType pitch_type,
    required String created_by,
    @JsonKey(includeToJson: false, includeFromJson: false)
    List<UserModel>? umpires,
    @JsonKey(includeToJson: false, includeFromJson: false)
    List<UserModel>? scorers,
    @JsonKey(includeToJson: false, includeFromJson: false)
    List<UserModel>? commentators,
    @JsonKey(includeToJson: false, includeFromJson: false) UserModel? referee,
    List<String>? umpire_ids,
    List<String>? scorer_ids,
    List<String>? commentator_ids,
    String? referee_id,
    required MatchStatus match_status,
    TossDecision? toss_decision,
    String? toss_winner_id,
    String? current_playing_team_id,
    RevisedTarget? revised_target,
    @TimeStampJsonConverter() DateTime? updated_at,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);

  factory MatchModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      MatchModel.fromJson(snapshot.data()!);
}

@freezed
class MatchSetting with _$MatchSetting {
  const factory MatchSetting({
    @Default(true) bool continue_with_injured_player,
    @Default(true) bool show_wagon_wheel_for_less_run,
    @Default(true) bool show_wagon_wheel_for_dot_ball,
  }) = _MatchSetting;

  factory MatchSetting.fromJson(Map<String, dynamic> json) =>
      _$MatchSettingFromJson(json);

  factory MatchSetting.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      MatchSetting.fromJson(snapshot.data()!);
}

@freezed
class MatchTeamModel with _$MatchTeamModel {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory MatchTeamModel({
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(TeamModel(name: '', name_lowercase: '', id: ''))
    TeamModel team,
    required String team_id,
    String? captain_id,
    String? admin_id,
    @Default(0) double over,
    @Default(0) int run,
    @Default(0) int wicket,
    @Default([]) List<MatchPlayer> squad,
  }) = _MatchTeamModel;

  factory MatchTeamModel.fromJson(Map<String, dynamic> json) =>
      _$MatchTeamModelFromJson(json);
}

@freezed
class MatchPlayer with _$MatchPlayer {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory MatchPlayer({
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(UserModel(id: ''))
    UserModel player,
    required String id,
    @Default([]) List<PlayerPerformance> performance,
    @Default(PlayerStatus.played)
    PlayerStatus status, // TODO: Remove after release
  }) = _MatchPlayer;

  factory MatchPlayer.fromJson(Map<String, dynamic> json) =>
      _$MatchPlayerFromJson(json);
}

@freezed
class PlayerPerformance with _$PlayerPerformance {
  const factory PlayerPerformance({
    required String inning_id,
    PlayerStatus? status,
    int? index,
  }) = _PlayerPerformance;

  factory PlayerPerformance.fromJson(Map<String, dynamic> json) =>
      _$PlayerPerformanceFromJson(json);
}

@freezed
class RevisedTarget with _$RevisedTarget {
  const factory RevisedTarget({
    @Default(0) int runs,
    @Default(0) double overs,
    DateTime? time,
    @TimeStampJsonConverter() DateTime? revised_time,
  }) = _RevisedTarget;

  factory RevisedTarget.fromJson(Map<String, dynamic> json) =>
      _$RevisedTargetFromJson(json);
}

extension DataMatchModel on MatchModel {
  MatchResult? get matchResult {
    if (match_status != MatchStatus.finish) {
      return null;
    }

    final firstTeam = teams.firstWhere(
      (element) => toss_decision == TossDecision.bat
          ? element.team.id == toss_winner_id
          : element.team.id != toss_winner_id,
    );
    final secondTeam =
        teams.firstWhere((element) => element.team.id != firstTeam.team.id);

    final revisedRuns =
        revised_target?.runs != null ? revised_target!.runs - 1 : null;

    if ((revisedRuns ?? firstTeam.run) > secondTeam.run) {
      // first batting team won
      final teamName = firstTeam.team.name;
      final runDifference = (revisedRuns ?? firstTeam.run) - secondTeam.run;

      return MatchResult(
        teamId: firstTeam.team.id,
        teamName: teamName,
        difference: runDifference,
        winType: WinnerByType.run,
      );
    } else if ((revisedRuns ?? firstTeam.run) == secondTeam.run) {
      return MatchResult(
        teamId: "",
        teamName: "",
        difference: 0,
        winType: WinnerByType.tie,
      );
    } else {
      // second batting team won
      final teamName = secondTeam.team.name;
      final wicketDifference = secondTeam.squad.length - firstTeam.wicket;

      return MatchResult(
        teamId: secondTeam.team.id,
        teamName: teamName,
        difference: wicketDifference,
        winType: WinnerByType.wicket,
      );
    }
  }

  bool get isRevisedTargetApplicable {
    final secondInningTeam = teams.firstWhere(
      (element) => toss_decision == TossDecision.bat
          ? element.team.id != toss_winner_id
          : element.team.id == toss_winner_id,
    );
    final overRemained =
        number_of_over.toDouble().remove(secondInningTeam.over.toBalls());

    return match_status == MatchStatus.running &&
        current_playing_team_id == secondInningTeam.team.id &&
        overRemained >= 2 &&
        revised_target == null &&
        match_type == MatchType.limitedOvers;
  }

  double getRunRate(String teamId) {
    if (!team_ids.contains(teamId)) return 0;

    final team = teams.firstWhereOrNull((team) => team.team_id == teamId);
    if (team == null) return 0;

    final runs = team.run;
    final overs = team.over;

    if (overs == 0) {
      return 0.0;
    }

    final runRate = runs / overs;
    return double.parse(runRate.toStringAsFixed(2));
  }
}

enum WinnerByType {
  run,
  wicket,
  tie;
}

class MatchResult {
  String teamId;
  int difference;
  String teamName;
  WinnerByType winType;

  MatchResult({
    required this.teamId,
    required this.teamName,
    required this.difference,
    required this.winType,
  });
}

@JsonEnum(valueField: "value")
enum MatchType {
  limitedOvers(1),
  testMatch(2),
  theHundred(3),
  pairCricket(4),
  boxCricket(5);

  final int value;

  const MatchType(this.value);
}

@JsonEnum(valueField: "value")
enum BallType {
  leather(1),
  tennis(2),
  other(3);

  final int value;

  const BallType(this.value);
}

@JsonEnum(valueField: "value")
enum PitchType {
  rough(1),
  cement(2),
  turf(3),
  astroturf(4),
  matting(5);

  final int value;

  const PitchType(this.value);
}

@JsonEnum(valueField: "value")
enum MatchStatus {
  yetToStart(1),
  running(2),
  finish(3),
  abandoned(4);

  final int value;

  const MatchStatus(this.value);
}

@JsonEnum(valueField: "value")
enum PlayerStatus {
  yetToPlay(1),
  playing(2),
  played(3),
  injured(4),
  substitute(5),
  suspended(6),
  withdrawn(7);

  final int value;

  const PlayerStatus(this.value);
}

@JsonEnum(valueField: "value")
enum PlayerMatchRole {
  captain(1),
  admin(2);

  final int value;

  const PlayerMatchRole(this.value);
}

@JsonEnum(valueField: "value")
enum TossDecision {
  bat(1),
  bowl(2);

  final int value;

  const TossDecision(this.value);
}

@JsonEnum(valueField: "value")
enum MatchGroup {
  round(1),
  quarterfinal(2),
  semifinal(3),
  finals(4);

  final int value;

  const MatchGroup(this.value);
}

@freezed
class TeamMatchStatus with _$TeamMatchStatus {
  const factory TeamMatchStatus({
    @Default(0) int win,
    @Default(0) int tie,
    @Default(0) int lost,
  }) = _TeamMatchStatus;
}

@freezed
class TeamStat with _$TeamStat {
  const factory TeamStat({
    @Default(0) int played,
    @Default(TeamMatchStatus()) TeamMatchStatus status,
    @Default(0) int runs,
    @Default(0) int wickets,
    @Default(0.0) double batting_average,
    @Default(0.0) double bowling_average,
    @Default(0) int highest_runs,
    @Default(0) int lowest_runs,
    @Default(0.0) double run_rate,
  }) = _TeamStat;
}

extension TeamStatExtension on List<MatchModel> {
  TeamStat teamStat(String teamId) {
    if (isEmpty) return const TeamStat();

    var runs = 0;
    var wickets = 0;
    var battingAverageTotal = 0.0;
    var bowlingAverageTotal = 0.0;
    var highestRuns = 0;
    var lowestRuns = double.maxFinite.toInt();

    for (final match in this) {
      final team = _getTeam(match, teamId);
      final opponentTeam = _getOpponentTeam(match, teamId);

      runs += team.run;
      wickets += team.wicket;

      battingAverageTotal +=
          opponentTeam.wicket > 0 ? team.run / opponentTeam.wicket : 0;
      if (team.wicket > 0) {
        bowlingAverageTotal += opponentTeam.run / team.wicket;
      }

      if (team.run > highestRuns) highestRuns = team.run;
      if (team.run < lowestRuns) lowestRuns = team.run;
    }

    final bowlingAverage = length > 0.0 ? bowlingAverageTotal / length : 0.0;

    return TeamStat(
      played: length,
      status: _teamMatchStatus(teamId),
      run_rate: _runRate(teamId, runs),
      runs: runs,
      wickets: wickets,
      batting_average: battingAverageTotal,
      bowling_average: bowlingAverage,
      highest_runs: highestRuns,
      lowest_runs: lowestRuns == double.maxFinite.toInt() ? 0 : lowestRuns,
    );
  }

  TeamMatchStatus _teamMatchStatus(String teamId) {
    return fold<TeamMatchStatus>(
      const TeamMatchStatus(),
      (status, match) {
        final firstTeam = match.teams.firstWhere(
          (team) =>
              team.team.id ==
              (match.toss_decision == TossDecision.bat
                  ? match.toss_winner_id
                  : match.teams
                      .firstWhere(
                        (team) => team.team.id != match.toss_winner_id,
                      )
                      .team
                      .id),
        );

        final secondTeam =
            match.teams.firstWhere((team) => team.team.id != firstTeam.team.id);

        if (firstTeam.run == secondTeam.run) {
          return TeamMatchStatus(
            win: status.win,
            lost: status.lost,
            tie: status.tie + 1,
          );
        } else if ((firstTeam.run > secondTeam.run &&
                firstTeam.team.id == teamId) ||
            (firstTeam.run < secondTeam.run && secondTeam.team.id == teamId)) {
          return TeamMatchStatus(
            win: status.win + 1,
            lost: status.lost,
            tie: status.tie,
          );
        } else {
          return TeamMatchStatus(
            win: status.win,
            lost: status.lost + 1,
            tie: status.tie,
          );
        }
      },
    );
  }

  MatchTeamModel _getTeam(MatchModel match, String teamId) =>
      match.teams.firstWhere((team) => team.team.id == teamId);

  MatchTeamModel _getOpponentTeam(MatchModel match, String teamId) =>
      match.teams.firstWhere((team) => team.team.id != teamId);

  double _runRate(String teamId, int runs) {
    final totalOvers = map((match) => _getTeam(match, teamId))
        .fold<double>(0.0, (total, team) => total + team.over);

    return totalOvers > 0 ? runs / totalOvers : 0;
  }
}
