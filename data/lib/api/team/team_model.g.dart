// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamModelImpl _$$TeamModelImplFromJson(Map<String, dynamic> json) =>
    _$TeamModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      name_lowercase: json['name_lowercase'] as String,
      city: json['city'] as String?,
      profile_img_url: json['profile_img_url'] as String?,
      created_by: json['created_by'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TeamModelImplToJson(_$TeamModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_lowercase': instance.name_lowercase,
      'city': instance.city,
      'profile_img_url': instance.profile_img_url,
      'created_by': instance.created_by,
      'created_at': instance.created_at?.toIso8601String(),
    };

_$TeamPlayerImpl _$$TeamPlayerImplFromJson(Map<String, dynamic> json) =>
    _$TeamPlayerImpl(
      id: json['id'] as String,
      role: $enumDecodeNullable(_$TeamPlayerRoleEnumMap, json['role']) ??
          TeamPlayerRole.player,
    );

Map<String, dynamic> _$$TeamPlayerImplToJson(_$TeamPlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': _$TeamPlayerRoleEnumMap[instance.role]!,
    };

const _$TeamPlayerRoleEnumMap = {
  TeamPlayerRole.admin: 'admin',
  TeamPlayerRole.player: 'player',
};
