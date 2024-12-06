// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partnership_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartnershipModelImpl _$$PartnershipModelImplFromJson(Map json) =>
    _$PartnershipModelImpl(
      id: json['id'] as String,
      match_id: json['match_id'] as String,
      inning_id: json['inning_id'] as String,
      player_ids: (json['player_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => PartnershipPlayer.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      runs: (json['runs'] as num?)?.toInt() ?? 0,
      extras: (json['extras'] as num?)?.toInt() ?? 0,
      ball_faced: (json['ball_faced'] as num?)?.toInt() ?? 0,
      start_over: (json['start_over'] as num?)?.toDouble() ?? 0.0,
      end_over: (json['end_over'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$PartnershipModelImplToJson(
        _$PartnershipModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'match_id': instance.match_id,
      'inning_id': instance.inning_id,
      'player_ids': instance.player_ids,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'runs': instance.runs,
      'extras': instance.extras,
      'ball_faced': instance.ball_faced,
      'start_over': instance.start_over,
      'end_over': instance.end_over,
    };

_$PartnershipPlayerImpl _$$PartnershipPlayerImplFromJson(Map json) =>
    _$PartnershipPlayerImpl(
      player_id: json['player_id'] as String,
      runs: (json['runs'] as num?)?.toInt() ?? 0,
      ball_faced: (json['ball_faced'] as num?)?.toInt() ?? 0,
      fours: (json['fours'] as num?)?.toInt() ?? 0,
      sixes: (json['sixes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PartnershipPlayerImplToJson(
        _$PartnershipPlayerImpl instance) =>
    <String, dynamic>{
      'player_id': instance.player_id,
      'runs': instance.runs,
      'ball_faced': instance.ball_faced,
      'fours': instance.fours,
      'sixes': instance.sixes,
    };
