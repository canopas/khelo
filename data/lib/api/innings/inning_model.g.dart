// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inning_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InningModelImpl _$$InningModelImplFromJson(Map<String, dynamic> json) =>
    _$InningModelImpl(
      id: json['id'] as String?,
      match_id: json['match_id'] as String,
      team_id: json['team_id'] as String,
      overs: (json['overs'] as num?)?.toDouble() ?? 0,
      total_runs: json['total_runs'] as int? ?? 0,
      total_wickets: json['total_wickets'] as int? ?? 0,
      innings_status:
          $enumDecodeNullable(_$InningStatusEnumMap, json['innings_status']),
    );

Map<String, dynamic> _$$InningModelImplToJson(_$InningModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'match_id': instance.match_id,
      'team_id': instance.team_id,
      'overs': instance.overs,
      'total_runs': instance.total_runs,
      'total_wickets': instance.total_wickets,
      'innings_status': _$InningStatusEnumMap[instance.innings_status],
    };

const _$InningStatusEnumMap = {
  InningStatus.yetToStart: 1,
  InningStatus.running: 2,
  InningStatus.finish: 3,
};
