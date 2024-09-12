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
      attachmentUrls: (json['attachmentUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      userId: json['userId'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      createdTime: _$JsonConverterFromJson<Object, DateTime>(
          json['createdTime'], const TimeStampJsonConverter().fromJson),
    );

Map<String, dynamic> _$$AddSupportCaseRequestImplToJson(
        _$AddSupportCaseRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'attachmentUrls': instance.attachmentUrls,
      'userId': instance.userId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'createdTime': _$JsonConverterToJson<Object, DateTime>(
          instance.createdTime, const TimeStampJsonConverter().toJson),
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
