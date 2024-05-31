// ignore_for_file: non_constant_identifier_names

import 'package:data/api/team/team_model.dart';
import 'package:data/api/user/user_models.dart';
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
class MatchPlayer with _$MatchPlayer {
  const factory MatchPlayer({
    required UserModel player,
    PlayerStatus? status,
    int? index,
  }) = _MatchPlayer;

  factory MatchPlayer.fromJson(Map<String, dynamic> json) =>
      _$MatchPlayerFromJson(json);
}

@freezed
class AddEditMatchRequest with _$AddEditMatchRequest {
  const factory AddEditMatchRequest({
    String? id,
    required List<AddMatchTeamRequest> teams,
    required MatchType match_type,
    required int number_of_over,
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
  }) = _AddEditMatchRequest;

  factory AddEditMatchRequest.fromJson(Map<String, dynamic> json) =>
      _$AddEditMatchRequestFromJson(json);
}

@freezed
class AddMatchTeamRequest with _$AddMatchTeamRequest {
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
  const factory MatchPlayerRequest({
    required String id,
    required PlayerStatus status,
    int? index,
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
