// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddSupportCaseRequestImpl _$$AddSupportCaseRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AddSupportCaseRequestImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      attachmentUrls: (json['attachmentUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AddSupportCaseRequestImplToJson(
        _$AddSupportCaseRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'attachmentUrls': instance.attachmentUrls,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
