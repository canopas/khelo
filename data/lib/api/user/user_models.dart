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
