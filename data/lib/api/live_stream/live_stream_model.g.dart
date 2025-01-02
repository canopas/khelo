// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_stream_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LiveStreamModelImpl _$$LiveStreamModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LiveStreamModelImpl(
      id: json['id'] as String,
      match_id: json['match_id'] as String,
      rtmp_url: json['rtmp_url'] as String,
      stream_id: json['stream_id'] as String,
      broadcast_id: json['broadcast_id'] as String,
      title: json['title'] as String,
      start_time: _$JsonConverterFromJson<Object, DateTime>(
          json['start_time'], const TimeStampJsonConverter().fromJson),
      status: $enumDecodeNullable(_$LiveStreamStatusEnumMap, json['status']) ??
          LiveStreamStatus.pending,
    );

Map<String, dynamic> _$$LiveStreamModelImplToJson(
        _$LiveStreamModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'match_id': instance.match_id,
      'rtmp_url': instance.rtmp_url,
      'stream_id': instance.stream_id,
      'broadcast_id': instance.broadcast_id,
      'title': instance.title,
      'start_time': _$JsonConverterToJson<Object, DateTime>(
          instance.start_time, const TimeStampJsonConverter().toJson),
      'status': _$LiveStreamStatusEnumMap[instance.status]!,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$LiveStreamStatusEnumMap = {
  LiveStreamStatus.pending: 'pending',
  LiveStreamStatus.live: 'live',
  LiveStreamStatus.paused: 'paused',
  LiveStreamStatus.completed: 'completed',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
