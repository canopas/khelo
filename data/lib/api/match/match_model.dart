// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../extensions/double_extensions.dart';
import '../team/team_model.dart';
import '../user/user_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_model.freezed.dart';

part 'match_model.g.dart';

@freezed
class MatchModel with _$MatchModel {
  const factory MatchModel({
    String? id,
    required List<MatchTeamModel> teams,
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
    required DateTime start_time,
    required BallType ball_type,
    required PitchType pitch_type,
    required String created_by,
    List<UserModel>? umpires,
    List<UserModel>? scorers,
    List<UserModel>? commentators,
    UserModel? referee,
    required MatchStatus match_status,
    TossDecision? toss_decision,
    String? toss_winner_id,
    String? current_playing_team_id,
    RevisedTarget? revised_target,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);
}

@freezed
class MatchTeamModel with _$MatchTeamModel {
  const factory MatchTeamModel({
    required TeamModel team,
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
class RevisedTarget with _$RevisedTarget {
  const factory RevisedTarget({
    @Default(0) int runs,
    @Default(0) double overs,
    DateTime? time,
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
        teamId: firstTeam.team.id ?? "",
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
        teamId: secondTeam.team.id ?? "",
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

@freezed
class MatchPlayer with _$MatchPlayer {
  const factory MatchPlayer({
    required UserModel player,
    @Default([]) List<PlayerPerformance> performance,
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
class AddEditMatchRequest with _$AddEditMatchRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory AddEditMatchRequest({
    String? id,
    required List<AddMatchTeamRequest> teams,
    required MatchType match_type,
    required int number_of_over,
    @Default([]) List<String> players,
    @Default([]) List<String> team_ids,
    @Default([]) List<String> team_creator_ids,
    required int over_per_bowler,
    List<int>? power_play_overs1,
    List<int>? power_play_overs2,
    List<int>? power_play_overs3,
    required String city,
    required String ground,
    required DateTime start_time,
    required BallType ball_type,
    required PitchType pitch_type,
    required String created_by,
    List<String>? umpire_ids,
    List<String>? scorer_ids,
    List<String>? commentator_ids,
    String? referee_id,
    required MatchStatus match_status,
    TossDecision? toss_decision,
    String? toss_winner_id,
    String? current_playing_team_id,
    RevisedTarget? revised_target,
  }) = _AddEditMatchRequest;

  factory AddEditMatchRequest.fromJson(Map<String, dynamic> json) =>
      _$AddEditMatchRequestFromJson(json);

  factory AddEditMatchRequest.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      AddEditMatchRequest.fromJson(snapshot.data()!);
}

@freezed
class AddMatchTeamRequest with _$AddMatchTeamRequest {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory AddMatchTeamRequest({
    required String team_id,
    String? captain_id,
    String? admin_id,
    @Default(0) double over,
    @Default(0) int run,
    @Default(0) int wicket,
    @Default([]) List<MatchPlayerRequest> squad,
  }) = _AddMatchTeamRequest;

  factory AddMatchTeamRequest.fromJson(Map<String, dynamic> json) =>
      _$AddMatchTeamRequestFromJson(json);
}

@freezed
class MatchPlayerRequest with _$MatchPlayerRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory MatchPlayerRequest({
    required String id,
    @Default(PlayerStatus.played)
    PlayerStatus status, // TODO: Remove after release
    @Default([]) List<PlayerPerformance> performance,
  }) = _MatchPlayerRequest;

  factory MatchPlayerRequest.fromJson(Map<String, dynamic> json) =>
      _$MatchPlayerRequestFromJson(json);
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
    @Default(0.0) double bating_average,
    @Default(0.0) double bowling_average,
    @Default(0) int highest_runs,
    @Default(0) int lowest_runts,
    @Default(0.0) double run_rate,
  }) = _TeamStat;
}
