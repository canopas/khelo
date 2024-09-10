// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ball_score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BallScoreModelImpl _$$BallScoreModelImplFromJson(Map<String, dynamic> json) =>
    _$BallScoreModelImpl(
      id: json['id'] as String,
      inning_id: json['inning_id'] as String,
      match_id: json['match_id'] as String,
      over_number: (json['over_number'] as num).toInt(),
      ball_number: (json['ball_number'] as num).toInt(),
      bowler_id: json['bowler_id'] as String,
      batsman_id: json['batsman_id'] as String,
      non_striker_id: json['non_striker_id'] as String,
      runs_scored: (json['runs_scored'] as num).toInt(),
      extras_type:
          $enumDecodeNullable(_$ExtrasTypeEnumMap, json['extras_type']),
      extras_awarded: (json['extras_awarded'] as num?)?.toInt(),
      wicket_type:
          $enumDecodeNullable(_$WicketTypeEnumMap, json['wicket_type']),
      fielding_position: $enumDecodeNullable(
          _$FieldingPositionTypeEnumMap, json['fielding_position']),
      player_out_id: json['player_out_id'] as String?,
      wicket_taker_id: json['wicket_taker_id'] as String?,
      is_four: json['is_four'] as bool,
      is_six: json['is_six'] as bool,
      time2: _$JsonConverterFromJson<Object, DateTime>(
          json['time2'], const TimeStampJsonConverter().fromJson),
    );

Map<String, dynamic> _$$BallScoreModelImplToJson(
        _$BallScoreModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inning_id': instance.inning_id,
      'match_id': instance.match_id,
      'over_number': instance.over_number,
      'ball_number': instance.ball_number,
      'bowler_id': instance.bowler_id,
      'batsman_id': instance.batsman_id,
      'non_striker_id': instance.non_striker_id,
      'runs_scored': instance.runs_scored,
      'extras_type': _$ExtrasTypeEnumMap[instance.extras_type],
      'extras_awarded': instance.extras_awarded,
      'wicket_type': _$WicketTypeEnumMap[instance.wicket_type],
      'fielding_position':
          _$FieldingPositionTypeEnumMap[instance.fielding_position],
      'player_out_id': instance.player_out_id,
      'wicket_taker_id': instance.wicket_taker_id,
      'is_four': instance.is_four,
      'is_six': instance.is_six,
      'time2': _$JsonConverterToJson<Object, DateTime>(
          instance.time2, const TimeStampJsonConverter().toJson),
    };

const _$ExtrasTypeEnumMap = {
  ExtrasType.wide: 1,
  ExtrasType.noBall: 2,
  ExtrasType.bye: 3,
  ExtrasType.legBye: 4,
  ExtrasType.penaltyRun: 5,
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

_$OverStatModelImpl _$$OverStatModelImplFromJson(Map<String, dynamic> json) =>
    _$OverStatModelImpl(
      run: (json['run'] as num?)?.toInt() ?? 0,
      wicket: (json['wicket'] as num?)?.toInt() ?? 0,
      extra: (json['extra'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$OverStatModelImplToJson(_$OverStatModelImpl instance) =>
    <String, dynamic>{
      'run': instance.run,
      'wicket': instance.wicket,
      'extra': instance.extra,
    };

_$TeamRunStatImpl _$$TeamRunStatImplFromJson(Map<String, dynamic> json) =>
    _$TeamRunStatImpl(
      teamName: json['teamName'] as String? ?? "",
      run: (json['run'] as num?)?.toInt() ?? 0,
      wicket: (json['wicket'] as num?)?.toInt() ?? 0,
      over: (json['over'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$TeamRunStatImplToJson(_$TeamRunStatImpl instance) =>
    <String, dynamic>{
      'teamName': instance.teamName,
      'run': instance.run,
      'wicket': instance.wicket,
      'over': instance.over,
    };
