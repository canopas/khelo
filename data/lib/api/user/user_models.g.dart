// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as int,
      name: json['name'] as String?,
      location: json['location'] as String?,
      phone: json['phone'] as String?,
      dob: json['dob'] as String?,
      email: json['email'] as String?,
      profile_img_url: json['profile_img_url'] as String?,
      gender: $enumDecodeNullable(_$UserGenderEnumMap, json['gender']),
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      player_role: json['player_role'] as String?,
      batting_style: json['batting_style'] as String?,
      bowling_style: json['bowling_style'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'phone': instance.phone,
      'dob': instance.dob,
      'email': instance.email,
      'profile_img_url': instance.profile_img_url,
      'gender': _$UserGenderEnumMap[instance.gender],
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'player_role': instance.player_role,
      'batting_style': instance.batting_style,
      'bowling_style': instance.bowling_style,
    };

const _$UserGenderEnumMap = {
  UserGender.unknown: 0,
  UserGender.male: 1,
  UserGender.female: 2,
};
