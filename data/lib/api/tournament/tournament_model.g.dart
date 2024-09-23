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
      type: json['type'] ?? TournamentType.other,
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => TournamentMember.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      start_date: DateTime.parse(json['start_date'] as String),
      end_date: DateTime.parse(json['end_date'] as String),
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
      'type': instance.type,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'start_date': instance.start_date.toIso8601String(),
      'end_date': instance.end_date.toIso8601String(),
      'team_ids': instance.team_ids,
      'match_ids': instance.match_ids,
    };

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
