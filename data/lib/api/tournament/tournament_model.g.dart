// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TournamentModelImpl _$$TournamentModelImplFromJson(Map json) =>
    _$TournamentModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      profile_img_url: json['profile_img_url'] as String?,
      banner_img_url: json['banner_img_url'] as String?,
      type: $enumDecode(_$TournamentTypeEnumMap, json['type']),
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => TournamentMember.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      created_by: json['created_by'] as String,
      created_at: _$JsonConverterFromJson<Object, DateTime>(
          json['created_at'], const TimeStampJsonConverter().fromJson),
      start_date:
          const TimeStampJsonConverter().fromJson(json['start_date'] as Object),
      end_date:
          const TimeStampJsonConverter().fromJson(json['end_date'] as Object),
      team_ids: (json['team_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      match_ids: (json['match_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TournamentModelImplToJson(
        _$TournamentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_img_url': instance.profile_img_url,
      'banner_img_url': instance.banner_img_url,
      'type': _$TournamentTypeEnumMap[instance.type]!,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'created_by': instance.created_by,
      'created_at': _$JsonConverterToJson<Object, DateTime>(
          instance.created_at, const TimeStampJsonConverter().toJson),
      'start_date': const TimeStampJsonConverter().toJson(instance.start_date),
      'end_date': const TimeStampJsonConverter().toJson(instance.end_date),
      'team_ids': instance.team_ids,
      'match_ids': instance.match_ids,
    };

const _$TournamentTypeEnumMap = {
  TournamentType.knockOut: 1,
  TournamentType.miniRobin: 2,
  TournamentType.boxLeague: 3,
  TournamentType.doubleOut: 4,
  TournamentType.bestOfThree: 6,
  TournamentType.custom: 7,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$TournamentMemberImpl _$$TournamentMemberImplFromJson(
        Map<String, dynamic> json) =>
    _$TournamentMemberImpl(
      id: json['id'] as String,
      role: $enumDecodeNullable(_$TournamentMemberRoleEnumMap, json['role']) ??
          TournamentMemberRole.admin,
    );

Map<String, dynamic> _$$TournamentMemberImplToJson(
        _$TournamentMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': _$TournamentMemberRoleEnumMap[instance.role]!,
    };

const _$TournamentMemberRoleEnumMap = {
  TournamentMemberRole.organizer: 'organizer',
  TournamentMemberRole.admin: 'admin',
};

_$PlayerKeyStatImpl _$$PlayerKeyStatImplFromJson(Map<String, dynamic> json) =>
    _$PlayerKeyStatImpl(
      teamName: json['teamName'] as String,
      player: UserModel.fromJson(json['player'] as Map<String, dynamic>),
      stats: UserStat.fromJson(json['stats'] as Map<String, dynamic>),
      tag: $enumDecodeNullable(_$KeyStatTagEnumMap, json['tag']),
      value: (json['value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PlayerKeyStatImplToJson(_$PlayerKeyStatImpl instance) =>
    <String, dynamic>{
      'teamName': instance.teamName,
      'player': instance.player.toJson(),
      'stats': instance.stats.toJson(),
      'tag': _$KeyStatTagEnumMap[instance.tag],
      'value': instance.value,
    };

const _$KeyStatTagEnumMap = {
  KeyStatTag.mostRuns: 'mostRuns',
  KeyStatTag.mostWickets: 'mostWickets',
  KeyStatTag.mostFours: 'mostFours',
  KeyStatTag.mostSixes: 'mostSixes',
};
