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
      isActive: json['isActive'] as bool? ?? true,
      notifications: json['notifications'] as bool? ?? true,
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
      'isActive': instance.isActive,
      'notifications': instance.notifications,
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

_$ApiSessionImpl _$$ApiSessionImplFromJson(Map<String, dynamic> json) =>
    _$ApiSessionImpl(
      id: json['id'] as String,
      user_id: json['user_id'] as String,
      device_type: (json['device_type'] as num).toInt(),
      device_id: json['device_id'] as String,
      device_name: json['device_name'] as String,
      device_fcm_token: json['device_fcm_token'] as String?,
      app_version: (json['app_version'] as num).toInt(),
      os_version: json['os_version'] as String,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      is_active: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$ApiSessionImplToJson(_$ApiSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'device_type': instance.device_type,
      'device_id': instance.device_id,
      'device_name': instance.device_name,
      'device_fcm_token': instance.device_fcm_token,
      'app_version': instance.app_version,
      'os_version': instance.os_version,
      'created_at': instance.created_at?.toIso8601String(),
      'is_active': instance.is_active,
    };

_$UserStatsImpl _$$UserStatsImplFromJson(Map json) => _$UserStatsImpl(
      matches: (json['matches'] as num?)?.toInt() ?? 0,
      type: $enumDecodeNullable(_$UserStatTypeEnumMap, json['type']),
      batting: json['batting'] == null
          ? const Batting()
          : Batting.fromJson(Map<String, dynamic>.from(json['batting'] as Map)),
      bowling: json['bowling'] == null
          ? const Bowling()
          : Bowling.fromJson(Map<String, dynamic>.from(json['bowling'] as Map)),
      fielding: json['fielding'] == null
          ? const Fielding()
          : Fielding.fromJson(
              Map<String, dynamic>.from(json['fielding'] as Map)),
    );

Map<String, dynamic> _$$UserStatsImplToJson(_$UserStatsImpl instance) =>
    <String, dynamic>{
      'matches': instance.matches,
      'type': _$UserStatTypeEnumMap[instance.type],
      'batting': instance.batting.toJson(),
      'bowling': instance.bowling.toJson(),
      'fielding': instance.fielding.toJson(),
    };

const _$UserStatTypeEnumMap = {
  UserStatType.test: 'test',
  UserStatType.other: 'other',
};

_$BattingImpl _$$BattingImplFromJson(Map<String, dynamic> json) =>
    _$BattingImpl(
      innings: (json['innings'] as num?)?.toInt() ?? 0,
      runScored: (json['runScored'] as num?)?.toInt() ?? 0,
      average: (json['average'] as num?)?.toDouble() ?? 0.0,
      strikeRate: (json['strikeRate'] as num?)?.toDouble() ?? 0.0,
      ballFaced: (json['ballFaced'] as num?)?.toInt() ?? 0,
      fours: (json['fours'] as num?)?.toInt() ?? 0,
      sixes: (json['sixes'] as num?)?.toInt() ?? 0,
      fifties: (json['fifties'] as num?)?.toInt() ?? 0,
      hundreds: (json['hundreds'] as num?)?.toInt() ?? 0,
      ducks: (json['ducks'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$BattingImplToJson(_$BattingImpl instance) =>
    <String, dynamic>{
      'innings': instance.innings,
      'runScored': instance.runScored,
      'average': instance.average,
      'strikeRate': instance.strikeRate,
      'ballFaced': instance.ballFaced,
      'fours': instance.fours,
      'sixes': instance.sixes,
      'fifties': instance.fifties,
      'hundreds': instance.hundreds,
      'ducks': instance.ducks,
    };

_$BowlingImpl _$$BowlingImplFromJson(Map<String, dynamic> json) =>
    _$BowlingImpl(
      innings: (json['innings'] as num?)?.toInt() ?? 0,
      wicketTaken: (json['wicketTaken'] as num?)?.toInt() ?? 0,
      balls: (json['balls'] as num?)?.toInt() ?? 0,
      runsConceded: (json['runsConceded'] as num?)?.toInt() ?? 0,
      maiden: (json['maiden'] as num?)?.toInt() ?? 0,
      noBalls: (json['noBalls'] as num?)?.toInt() ?? 0,
      wideBalls: (json['wideBalls'] as num?)?.toInt() ?? 0,
      average: (json['average'] as num?)?.toDouble() ?? 0.0,
      strikeRate: (json['strikeRate'] as num?)?.toDouble() ?? 0.0,
      economyRate: (json['economyRate'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$BowlingImplToJson(_$BowlingImpl instance) =>
    <String, dynamic>{
      'innings': instance.innings,
      'wicketTaken': instance.wicketTaken,
      'balls': instance.balls,
      'runsConceded': instance.runsConceded,
      'maiden': instance.maiden,
      'noBalls': instance.noBalls,
      'wideBalls': instance.wideBalls,
      'average': instance.average,
      'strikeRate': instance.strikeRate,
      'economyRate': instance.economyRate,
    };

_$FieldingImpl _$$FieldingImplFromJson(Map<String, dynamic> json) =>
    _$FieldingImpl(
      catches: (json['catches'] as num?)?.toInt() ?? 0,
      runOut: (json['runOut'] as num?)?.toInt() ?? 0,
      stumping: (json['stumping'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FieldingImplToJson(_$FieldingImpl instance) =>
    <String, dynamic>{
      'catches': instance.catches,
      'runOut': instance.runOut,
      'stumping': instance.stumping,
    };
