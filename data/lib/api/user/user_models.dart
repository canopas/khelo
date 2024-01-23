// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_models.freezed.dart';

part 'user_models.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    required int id,
    String? name,
    String? location,
    String? phone,
    String? dob,
    String? email,
    String? profile_img_url,
    UserGender? gender,
    DateTime? created_at,
    DateTime? updated_at,
    String? player_role,
    String? batting_style,
    String? bowling_style,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  String toJsonString() => jsonEncode(toJson());

  static User? fromJsonString(String json) =>
      User.fromJson(jsonDecode(json));
}

@JsonEnum(valueField: "value")
enum UserGender {
  unknown(0),
  male(1),
  female(2);

  final int value;

  const UserGender(this.value);
}

@JsonEnum(valueField: "value")
enum PlayerRole {
  unknown(0),
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
  unknown(0),
  rightHandBat(1),
  leftHandBat(2);

  final int value;

  const BattingStyle(this.value);
}

@JsonEnum(valueField: "value")
enum BowlingStyle {
  unknown(0),
  male(1),
  female(2);

  final int value;

  const BowlingStyle(this.value);
}
