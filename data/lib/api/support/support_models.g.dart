// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddSupportCaseRequestImpl _$$AddSupportCaseRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AddSupportCaseRequestImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      attachment_urls: (json['attachment_urls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      user_id: json['user_id'] as String,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      created_time: _$JsonConverterFromJson<Object, DateTime>(
          json['created_time'], const TimeStampJsonConverter().fromJson),
    );

Map<String, dynamic> _$$AddSupportCaseRequestImplToJson(
        _$AddSupportCaseRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'attachment_urls': instance.attachment_urls,
      'user_id': instance.user_id,
      'created_at': instance.created_at?.toIso8601String(),
      'created_time': _$JsonConverterToJson<Object, DateTime>(
          instance.created_time, const TimeStampJsonConverter().toJson),
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
