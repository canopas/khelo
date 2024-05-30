// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ball_score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BallScoreModelImpl _$$BallScoreModelImplFromJson(Map<String, dynamic> json) =>
    _$BallScoreModelImpl(
      id: json['id'] as String?,
      inning_id: json['inning_id'] as String,
      over_number: json['over_number'] as int,
      ball_number: json['ball_number'] as int,
      bowler_id: json['bowler_id'] as String,
      batsman_id: json['batsman_id'] as String,
      non_striker_id: json['non_striker_id'] as String,
      runs_scored: json['runs_scored'] as int,
      extras_type:
          $enumDecodeNullable(_$ExtrasTypeEnumMap, json['extras_type']),
      extras_awarded: json['extras_awarded'] as int?,
      wicket_type:
          $enumDecodeNullable(_$WicketTypeEnumMap, json['wicket_type']),
      player_out_id: json['player_out_id'] as String?,
      wicket_taker_id: json['wicket_taker_id'] as String?,
      is_four: json['is_four'] as bool,
      is_six: json['is_six'] as bool,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$$BallScoreModelImplToJson(
        _$BallScoreModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inning_id': instance.inning_id,
      'over_number': instance.over_number,
      'ball_number': instance.ball_number,
      'bowler_id': instance.bowler_id,
      'batsman_id': instance.batsman_id,
      'non_striker_id': instance.non_striker_id,
      'runs_scored': instance.runs_scored,
      'extras_type': _$ExtrasTypeEnumMap[instance.extras_type],
      'extras_awarded': instance.extras_awarded,
      'wicket_type': _$WicketTypeEnumMap[instance.wicket_type],
      'player_out_id': instance.player_out_id,
      'wicket_taker_id': instance.wicket_taker_id,
      'is_four': instance.is_four,
      'is_six': instance.is_six,
      'time': instance.time.toIso8601String(),
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
