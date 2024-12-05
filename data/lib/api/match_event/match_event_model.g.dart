// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchEventModelImpl _$$MatchEventModelImplFromJson(Map json) =>
    _$MatchEventModelImpl(
      id: json['id'] as String,
      match_id: json['match_id'] as String,
      inning_id: json['inning_id'] as String,
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      bowler_id: json['bowler_id'] as String?,
      ball_ids: (json['ball_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      wickets: (json['wickets'] as List<dynamic>?)
              ?.map((e) => MatchEventWicket.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      milestone: (json['milestone'] as List<dynamic>?)
              ?.map((e) => MatchEventMilestone.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      time: const TimeStampJsonConverter().fromJson(json['time'] as Object),
      batsman_id: json['batsman_id'] as String?,
      over: (json['over'] as num?)?.toDouble() ?? 0,
      fielding_position: $enumDecodeNullable(
          _$FieldingPositionTypeEnumMap, json['fielding_position']),
    );

Map<String, dynamic> _$$MatchEventModelImplToJson(
    _$MatchEventModelImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'match_id': instance.match_id,
    'inning_id': instance.inning_id,
    'type': _$EventTypeEnumMap[instance.type]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bowler_id', instance.bowler_id);
  val['ball_ids'] = instance.ball_ids;
  val['wickets'] = instance.wickets.map((e) => e.toJson()).toList();
  val['milestone'] = instance.milestone.map((e) => e.toJson()).toList();
  val['time'] = const TimeStampJsonConverter().toJson(instance.time);
  writeNotNull('batsman_id', instance.batsman_id);
  val['over'] = instance.over;
  writeNotNull('fielding_position',
      _$FieldingPositionTypeEnumMap[instance.fielding_position]);
  return val;
}

const _$EventTypeEnumMap = {
  EventType.hatTrick: 1,
  EventType.century: 2,
  EventType.fifty: 3,
  EventType.wicket: 4,
  EventType.six: 5,
  EventType.four: 6,
};

const _$FieldingPositionTypeEnumMap = {
  FieldingPositionType.deepMidWicket: 1,
  FieldingPositionType.longOn: 2,
  FieldingPositionType.longOff: 3,
  FieldingPositionType.deepCover: 4,
  FieldingPositionType.deepPoint: 5,
  FieldingPositionType.thirdMan: 6,
  FieldingPositionType.deepFineLeg: 7,
  FieldingPositionType.deepSquareLeg: 8,
};

_$MatchEventWicketImpl _$$MatchEventWicketImplFromJson(Map json) =>
    _$MatchEventWicketImpl(
      time: const TimeStampJsonConverter().fromJson(json['time'] as Object),
      ball_id: json['ball_id'] as String,
      batsman_id: json['batsman_id'] as String,
      wicket_type: $enumDecode(_$WicketTypeEnumMap, json['wicket_type']),
      over: (json['over'] as num).toDouble(),
      wicket_taker_id: json['wicket_taker_id'] as String?,
    );

Map<String, dynamic> _$$MatchEventWicketImplToJson(
        _$MatchEventWicketImpl instance) =>
    <String, dynamic>{
      'time': const TimeStampJsonConverter().toJson(instance.time),
      'ball_id': instance.ball_id,
      'batsman_id': instance.batsman_id,
      'wicket_type': _$WicketTypeEnumMap[instance.wicket_type]!,
      'over': instance.over,
      'wicket_taker_id': instance.wicket_taker_id,
    };

const _$WicketTypeEnumMap = {
  WicketType.bowled: 1,
  WicketType.caught: 2,
  WicketType.caughtBehind: 3,
  WicketType.caughtAndBowled: 4,
  WicketType.lbw: 5,
  WicketType.stumped: 6,
  WicketType.runOut: 7,
  WicketType.hitWicket: 8,
  WicketType.hitBallTwice: 9,
  WicketType.handledBall: 10,
  WicketType.obstructingField: 11,
  WicketType.timedOut: 12,
  WicketType.retired: 13,
  WicketType.retiredHurt: 14,
};

_$MatchEventMilestoneImpl _$$MatchEventMilestoneImplFromJson(Map json) =>
    _$MatchEventMilestoneImpl(
      time: const TimeStampJsonConverter().fromJson(json['time'] as Object),
      ball_id: json['ball_id'] as String,
      over: (json['over'] as num?)?.toDouble() ?? 0.0,
      runs: (json['runs'] as num?)?.toInt() ?? 0,
      ball_faced: (json['ball_faced'] as num?)?.toInt() ?? 0,
      fours: (json['fours'] as num?)?.toInt() ?? 0,
      sixes: (json['sixes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$MatchEventMilestoneImplToJson(
        _$MatchEventMilestoneImpl instance) =>
    <String, dynamic>{
      'time': const TimeStampJsonConverter().toJson(instance.time),
      'ball_id': instance.ball_id,
      'over': instance.over,
      'runs': instance.runs,
      'ball_faced': instance.ball_faced,
      'fours': instance.fours,
      'sixes': instance.sixes,
    };
