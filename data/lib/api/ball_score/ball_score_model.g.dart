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
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      score_time: _$JsonConverterFromJson<Object, DateTime>(
          json['score_time'], const TimeStampJsonConverter().fromJson),
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
      'time': instance.time?.toIso8601String(),
      'score_time': _$JsonConverterToJson<Object, DateTime>(
          instance.score_time, const TimeStampJsonConverter().toJson),
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

_$UserStatImpl _$$UserStatImplFromJson(Map<String, dynamic> json) =>
    _$UserStatImpl(
      battingStat: json['battingStat'] == null
          ? null
          : BattingStat.fromJson(json['battingStat'] as Map<String, dynamic>),
      bowlingStat: json['bowlingStat'] == null
          ? null
          : BowlingStat.fromJson(json['bowlingStat'] as Map<String, dynamic>),
      fieldingStat: json['fieldingStat'] == null
          ? null
          : FieldingStat.fromJson(json['fieldingStat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserStatImplToJson(_$UserStatImpl instance) =>
    <String, dynamic>{
      'battingStat': instance.battingStat,
      'bowlingStat': instance.bowlingStat,
      'fieldingStat': instance.fieldingStat,
    };

_$BattingStatImpl _$$BattingStatImplFromJson(Map<String, dynamic> json) =>
    _$BattingStatImpl(
      innings: (json['innings'] as num?)?.toInt() ?? 0,
      runScored: (json['runScored'] as num?)?.toInt() ?? 0,
      average: (json['average'] as num?)?.toDouble() ?? 0.0,
      strikeRate: (json['strikeRate'] as num?)?.toDouble() ?? 0.0,
      ballFaced: (json['ballFaced'] as num?)?.toInt() ?? 0,
      fours: (json['fours'] as num?)?.toInt() ?? 0,
      sixes: (json['sixes'] as num?)?.toInt() ?? 0,
      fifties: (json['fifties'] as num?)?.toInt() ?? 0,
      hundreds: (json['hundreds'] as num?)?.toInt() ?? 0,
      ducks: (json['ducks'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$BattingStatImplToJson(_$BattingStatImpl instance) =>
    <String, dynamic>{
      'innings': instance.innings,
      'runScored': instance.runScored,
      'average': instance.average,
      'strikeRate': instance.strikeRate,
      'ballFaced': instance.ballFaced,
      'fours': instance.fours,
      'sixes': instance.sixes,
      'fifties': instance.fifties,
      'hundreds': instance.hundreds,
      'ducks': instance.ducks,
    };

_$BowlingStatImpl _$$BowlingStatImplFromJson(Map<String, dynamic> json) =>
    _$BowlingStatImpl(
      innings: (json['innings'] as num?)?.toInt() ?? 0,
      wicketTaken: (json['wicketTaken'] as num?)?.toInt() ?? 0,
      balls: (json['balls'] as num?)?.toInt() ?? 0,
      runsConceded: (json['runsConceded'] as num?)?.toInt() ?? 0,
      maiden: (json['maiden'] as num?)?.toInt() ?? 0,
      noBalls: (json['noBalls'] as num?)?.toInt() ?? 0,
      wideBalls: (json['wideBalls'] as num?)?.toInt() ?? 0,
      average: (json['average'] as num?)?.toDouble() ?? 0.0,
      strikeRate: (json['strikeRate'] as num?)?.toDouble() ?? 0.0,
      economyRate: (json['economyRate'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$BowlingStatImplToJson(_$BowlingStatImpl instance) =>
    <String, dynamic>{
      'innings': instance.innings,
      'wicketTaken': instance.wicketTaken,
      'balls': instance.balls,
      'runsConceded': instance.runsConceded,
      'maiden': instance.maiden,
      'noBalls': instance.noBalls,
      'wideBalls': instance.wideBalls,
      'average': instance.average,
      'strikeRate': instance.strikeRate,
      'economyRate': instance.economyRate,
    };

_$FieldingStatImpl _$$FieldingStatImplFromJson(Map<String, dynamic> json) =>
    _$FieldingStatImpl(
      catches: (json['catches'] as num?)?.toInt() ?? 0,
      runOut: (json['runOut'] as num?)?.toInt() ?? 0,
      stumping: (json['stumping'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FieldingStatImplToJson(_$FieldingStatImpl instance) =>
    <String, dynamic>{
      'catches': instance.catches,
      'runOut': instance.runOut,
      'stumping': instance.stumping,
    };

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
