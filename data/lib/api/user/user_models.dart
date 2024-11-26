// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_models.freezed.dart';

part 'user_models.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    String? name,
    String? name_lowercase,
    String? location,
    String? phone,
    DateTime? dob,
    String? email,
    String? profile_img_url,
    UserGender? gender,
    DateTime? created_at,
    DateTime? updated_at,
    PlayerRole? player_role,
    BattingStyle? batting_style,
    BowlingStyle? bowling_style,
    @Default(true) bool isActive,
    @Default(true) bool notifications,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      UserModel.fromJson(snapshot.data()!);

  String toJsonString() => jsonEncode(toJson());

  String get nameInitial => name?[0].toUpperCase() ?? '?';

  static UserModel? fromJsonString(String json) =>
      UserModel.fromJson(jsonDecode(json));
}

@freezed
class ApiSession with _$ApiSession {
  const ApiSession._();

  const factory ApiSession({
    required String id,
    required String user_id,
    required int device_type,
    required String device_id,
    required String device_name,
    String? device_fcm_token,
    required int app_version,
    required String os_version,
    DateTime? created_at,
    @Default(true) bool is_active,
  }) = _ApiSession;

  factory ApiSession.fromJson(Map<String, dynamic> json) =>
      _$ApiSessionFromJson(json);

  factory ApiSession.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data = snapshot.data();
    return ApiSession.fromJson(data!);
  }

  String toJsonString() => jsonEncode(toJson());

  static ApiSession? fromJsonString(String json) =>
      ApiSession.fromJson(jsonDecode(json));
}

extension ProfileCompleteExtension on UserModel {
  double get progress {
    final fields = [
      profile_img_url,
      name,
      email,
      location,
      dob,
      gender,
      player_role,
      batting_style,
      bowling_style,
    ];

    final completedFields = fields
        .where((field) => field != null && field.toString().isNotEmpty)
        .length;

    return completedFields / fields.length;
  }
}

@JsonEnum(valueField: "value")
enum UserGender {
  unknown(0),
  male(1),
  female(2),
  other(3);

  final int value;

  const UserGender(this.value);
}

@JsonEnum(valueField: "value")
enum PlayerRole {
  topOrderBatter(1),
  middleOrderBatter(2),
  wickerKeeperBatter(3),
  wicketKeeper(4),
  bowler(5),
  allRounder(6),
  lowerOrderBatter(7),
  openingBatter(8),
  none(9);

  final int value;

  const PlayerRole(this.value);
}

@JsonEnum(valueField: "value")
enum BattingStyle {
  rightHandBat(1),
  leftHandBat(2);

  final int value;

  const BattingStyle(this.value);
}

@JsonEnum(valueField: "value")
enum BowlingStyle {
  rightArmFast(0),
  rightArmMedium(1),
  leftArmFast(2),
  leftArmMedium(3),
  slowLeftArmOrthodox(4),
  slowLeftArmChinaMan(5),
  rightArmOffBreak(6),
  rightArmLegBreak(7),
  none(8);

  final int value;

  const BowlingStyle(this.value);
}

enum UserStatType {
  test(1),
  other(2);

  final int value;

  const UserStatType(this.value);
}

@freezed
class UserStat with _$UserStat {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory UserStat({
    @Default(0) int matches,
    UserStatType? type,
    @Default(Batting()) Batting batting,
    @Default(Bowling()) Bowling bowling,
    @Default(Fielding()) Fielding fielding,
  }) = _UserStats;

  factory UserStat.fromJson(Map<String, dynamic> json) =>
      _$UserStatFromJson(json);

  factory UserStat.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      UserStat.fromJson(snapshot.data()!);
}

@freezed
class Batting with _$Batting {
  const factory Batting({
    @Default(0) int innings,
    @Default(0) int runScored,
    @Default(0.0) double average,
    @Default(0.0) double strikeRate,
    @Default(0) int ballFaced,
    @Default(0) int fours,
    @Default(0) int sixes,
    @Default(0) int fifties,
    @Default(0) int hundreds,
    @Default(0) int ducks,
  }) = _Batting;

  factory Batting.fromJson(Map<String, dynamic> json) =>
      _$BattingFromJson(json);
}

@freezed
class Bowling with _$Bowling {
  const factory Bowling({
    @Default(0) int innings,
    @Default(0) int wicketTaken,
    @Default(0) int balls,
    @Default(0) int runsConceded,
    @Default(0) int maiden,
    @Default(0) int noBalls,
    @Default(0) int wideBalls,
    @Default(0.0) double average,
    @Default(0.0) double strikeRate,
    @Default(0.0) double economyRate,
  }) = _Bowling;

  factory Bowling.fromJson(Map<String, dynamic> json) =>
      _$BowlingFromJson(json);
}

@freezed
class Fielding with _$Fielding {
  const factory Fielding({
    @Default(0) int catches,
    @Default(0) int runOut,
    @Default(0) int stumping,
  }) = _Fielding;

  factory Fielding.fromJson(Map<String, dynamic> json) =>
      _$FieldingFromJson(json);
}

extension UserStatsExtension on UserStat {
  UserStat addStats(UserStat other) {
    return UserStat(
      matches: matches + other.matches,
      type: type,
      batting: _addBattingStats(batting, other.batting),
      bowling: _addBowlingStats(bowling, other.bowling),
      fielding: _addFieldingStats(fielding, other.fielding),
    );
  }

  Batting _addBattingStats(Batting? oldBatting, Batting? newBatting) {
    if (oldBatting == null) return newBatting!;
    if (newBatting == null) return oldBatting;

    final combinedInnings = oldBatting.innings + newBatting.innings;
    final combinedRunsScored = oldBatting.runScored + newBatting.runScored;
    final combinedDismissals = oldBatting.ducks + newBatting.ducks;
    final combinedBallsFaced = oldBatting.ballFaced + newBatting.ballFaced;
    final combinedFours = oldBatting.fours + newBatting.fours;
    final combinedSixes = oldBatting.sixes + newBatting.sixes;
    final combinedDucks = oldBatting.ducks + newBatting.ducks;
    final combinedFifties = oldBatting.fifties + newBatting.fifties;
    final combinedHundreds = oldBatting.hundreds + newBatting.hundreds;

    final average =
        combinedDismissals == 0 ? 0.0 : combinedRunsScored / combinedDismissals;
    final strikeRate = combinedBallsFaced == 0
        ? 0.0
        : (combinedRunsScored / combinedBallsFaced) * 100.0;

    return Batting(
      innings: combinedInnings,
      average: average,
      strikeRate: strikeRate,
      ballFaced: combinedBallsFaced,
      runScored: combinedRunsScored,
      fours: combinedFours,
      sixes: combinedSixes,
      ducks: combinedDucks,
      fifties: combinedFifties,
      hundreds: combinedHundreds,
    );
  }

  Bowling _addBowlingStats(Bowling? oldBowling, Bowling? newBowling) {
    if (oldBowling == null) return newBowling!;
    if (newBowling == null) return oldBowling;

    final combinedInnings = oldBowling.innings + newBowling.innings;
    final combinedWickets = oldBowling.wicketTaken + newBowling.wicketTaken;
    final combinedBalls = oldBowling.balls + newBowling.balls;
    final combinedRunsConceded =
        oldBowling.runsConceded + newBowling.runsConceded;
    final combinedWideBalls = oldBowling.wideBalls + newBowling.wideBalls;
    final combinedNoBalls = oldBowling.noBalls + newBowling.noBalls;
    final combinedMaidenOvers = oldBowling.maiden + newBowling.maiden;

    final average =
        combinedWickets == 0 ? 0.0 : combinedRunsConceded / combinedWickets;
    final strikeRate =
        combinedWickets == 0 ? 0.0 : combinedBalls / combinedWickets;
    final economyRate =
        combinedBalls == 0 ? 0.0 : (combinedRunsConceded / combinedBalls) * 6;

    return Bowling(
      innings: combinedInnings,
      average: average,
      strikeRate: strikeRate,
      wicketTaken: combinedWickets,
      economyRate: economyRate,
      balls: combinedBalls,
      wideBalls: combinedWideBalls,
      runsConceded: combinedRunsConceded,
      noBalls: combinedNoBalls,
      maiden: combinedMaidenOvers,
    );
  }

  Fielding _addFieldingStats(Fielding? oldFielding, Fielding? newFielding) {
    if (oldFielding == null) return newFielding!;
    if (newFielding == null) return oldFielding;

    final combinedCatches = oldFielding.catches + newFielding.catches;
    final combinedRunOuts = oldFielding.runOut + newFielding.runOut;
    final combinedStumpings = oldFielding.stumping + newFielding.stumping;

    return Fielding(
      catches: combinedCatches,
      runOut: combinedRunOuts,
      stumping: combinedStumpings,
    );
  }
}
