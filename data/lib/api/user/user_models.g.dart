// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      name_lowercase: json['name_lowercase'] as String?,
      location: json['location'] as String?,
      phone: json['phone'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      email: json['email'] as String?,
      profile_img_url: json['profile_img_url'] as String?,
      gender: $enumDecodeNullable(_$UserGenderEnumMap, json['gender']),
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      player_role:
          $enumDecodeNullable(_$PlayerRoleEnumMap, json['player_role']),
      batting_style:
          $enumDecodeNullable(_$BattingStyleEnumMap, json['batting_style']),
      bowling_style:
          $enumDecodeNullable(_$BowlingStyleEnumMap, json['bowling_style']),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_lowercase': instance.name_lowercase,
      'location': instance.location,
      'phone': instance.phone,
      'dob': instance.dob?.toIso8601String(),
      'email': instance.email,
      'profile_img_url': instance.profile_img_url,
      'gender': _$UserGenderEnumMap[instance.gender],
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'player_role': _$PlayerRoleEnumMap[instance.player_role],
      'batting_style': _$BattingStyleEnumMap[instance.batting_style],
      'bowling_style': _$BowlingStyleEnumMap[instance.bowling_style],
    };

const _$UserGenderEnumMap = {
  UserGender.unknown: 0,
  UserGender.male: 1,
  UserGender.female: 2,
  UserGender.other: 3,
};

const _$PlayerRoleEnumMap = {
  PlayerRole.topOrderBatter: 1,
  PlayerRole.middleOrderBatter: 2,
  PlayerRole.wickerKeeperBatter: 3,
  PlayerRole.wicketKeeper: 4,
  PlayerRole.bowler: 5,
  PlayerRole.allRounder: 6,
  PlayerRole.lowerOrderBatter: 7,
  PlayerRole.openingBatter: 8,
  PlayerRole.none: 9,
};

const _$BattingStyleEnumMap = {
  BattingStyle.rightHandBat: 1,
  BattingStyle.leftHandBat: 2,
};

const _$BowlingStyleEnumMap = {
  BowlingStyle.rightArmFast: 0,
  BowlingStyle.rightArmMedium: 1,
  BowlingStyle.leftArmFast: 2,
  BowlingStyle.leftArmMedium: 3,
  BowlingStyle.slowLeftArmOrthodox: 4,
  BowlingStyle.slowLeftArmChinaMan: 5,
  BowlingStyle.rightArmOffBreak: 6,
  BowlingStyle.rightArmLegBreak: 7,
  BowlingStyle.none: 8,
};
