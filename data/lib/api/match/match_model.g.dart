// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchModelImpl _$$MatchModelImplFromJson(Map json) => _$MatchModelImpl(
      id: json['id'] as String,
      teams: (json['teams'] as List<dynamic>)
          .map((e) =>
              MatchTeamModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      match_type: $enumDecode(_$MatchTypeEnumMap, json['match_type']),
      number_of_over: (json['number_of_over'] as num).toInt(),
      over_per_bowler: (json['over_per_bowler'] as num).toInt(),
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      team_ids: (json['team_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      team_creator_ids: (json['team_creator_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      power_play_overs1: (json['power_play_overs1'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      power_play_overs2: (json['power_play_overs2'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      power_play_overs3: (json['power_play_overs3'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      city: json['city'] as String,
      ground: json['ground'] as String,
      start_time: json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String),
      start_at: _$JsonConverterFromJson<Object, DateTime>(
          json['start_at'], const TimeStampJsonConverter().fromJson),
      ball_type: $enumDecode(_$BallTypeEnumMap, json['ball_type']),
      pitch_type: $enumDecode(_$PitchTypeEnumMap, json['pitch_type']),
      created_by: json['created_by'] as String,
      umpire_ids: (json['umpire_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      scorer_ids: (json['scorer_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      commentator_ids: (json['commentator_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      referee_id: json['referee_id'] as String?,
      match_status: $enumDecode(_$MatchStatusEnumMap, json['match_status']),
      toss_decision:
          $enumDecodeNullable(_$TossDecisionEnumMap, json['toss_decision']),
      toss_winner_id: json['toss_winner_id'] as String?,
      current_playing_team_id: json['current_playing_team_id'] as String?,
      revised_target: json['revised_target'] == null
          ? null
          : RevisedTarget.fromJson(
              Map<String, dynamic>.from(json['revised_target'] as Map)),
      updated_at: _$JsonConverterFromJson<Object, DateTime>(
          json['updated_at'], const TimeStampJsonConverter().fromJson),
    );

Map<String, dynamic> _$$MatchModelImplToJson(_$MatchModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teams': instance.teams.map((e) => e.toJson()).toList(),
      'match_type': _$MatchTypeEnumMap[instance.match_type]!,
      'number_of_over': instance.number_of_over,
      'over_per_bowler': instance.over_per_bowler,
      'players': instance.players,
      'team_ids': instance.team_ids,
      'team_creator_ids': instance.team_creator_ids,
      'power_play_overs1': instance.power_play_overs1,
      'power_play_overs2': instance.power_play_overs2,
      'power_play_overs3': instance.power_play_overs3,
      'city': instance.city,
      'ground': instance.ground,
      'start_time': instance.start_time?.toIso8601String(),
      'start_at': _$JsonConverterToJson<Object, DateTime>(
          instance.start_at, const TimeStampJsonConverter().toJson),
      'ball_type': _$BallTypeEnumMap[instance.ball_type]!,
      'pitch_type': _$PitchTypeEnumMap[instance.pitch_type]!,
      'created_by': instance.created_by,
      'umpire_ids': instance.umpire_ids,
      'scorer_ids': instance.scorer_ids,
      'commentator_ids': instance.commentator_ids,
      'referee_id': instance.referee_id,
      'match_status': _$MatchStatusEnumMap[instance.match_status]!,
      'toss_decision': _$TossDecisionEnumMap[instance.toss_decision],
      'toss_winner_id': instance.toss_winner_id,
      'current_playing_team_id': instance.current_playing_team_id,
      'revised_target': instance.revised_target?.toJson(),
      'updated_at': _$JsonConverterToJson<Object, DateTime>(
          instance.updated_at, const TimeStampJsonConverter().toJson),
    };

const _$MatchTypeEnumMap = {
  MatchType.limitedOvers: 1,
  MatchType.testMatch: 2,
  MatchType.theHundred: 3,
  MatchType.pairCricket: 4,
  MatchType.boxCricket: 5,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$BallTypeEnumMap = {
  BallType.leather: 1,
  BallType.tennis: 2,
  BallType.other: 3,
};

const _$PitchTypeEnumMap = {
  PitchType.rough: 1,
  PitchType.cement: 2,
  PitchType.turf: 3,
  PitchType.astroturf: 4,
  PitchType.matting: 5,
};

const _$MatchStatusEnumMap = {
  MatchStatus.yetToStart: 1,
  MatchStatus.running: 2,
  MatchStatus.finish: 3,
  MatchStatus.abandoned: 4,
};

const _$TossDecisionEnumMap = {
  TossDecision.bat: 1,
  TossDecision.bowl: 2,
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$MatchTeamModelImpl _$$MatchTeamModelImplFromJson(Map json) =>
    _$MatchTeamModelImpl(
      team_id: json['team_id'] as String,
      captain_id: json['captain_id'] as String?,
      admin_id: json['admin_id'] as String?,
      over: (json['over'] as num?)?.toDouble() ?? 0,
      run: (json['run'] as num?)?.toInt() ?? 0,
      wicket: (json['wicket'] as num?)?.toInt() ?? 0,
      squad: (json['squad'] as List<dynamic>?)
              ?.map((e) =>
                  MatchPlayer.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MatchTeamModelImplToJson(
        _$MatchTeamModelImpl instance) =>
    <String, dynamic>{
      'team_id': instance.team_id,
      'captain_id': instance.captain_id,
      'admin_id': instance.admin_id,
      'over': instance.over,
      'run': instance.run,
      'wicket': instance.wicket,
      'squad': instance.squad.map((e) => e.toJson()).toList(),
    };

_$MatchPlayerImpl _$$MatchPlayerImplFromJson(Map json) => _$MatchPlayerImpl(
      id: json['id'] as String,
      performance: (json['performance'] as List<dynamic>?)
              ?.map((e) => PlayerPerformance.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$PlayerStatusEnumMap, json['status']) ??
          PlayerStatus.played,
    );

Map<String, dynamic> _$$MatchPlayerImplToJson(_$MatchPlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'performance': instance.performance.map((e) => e.toJson()).toList(),
      'status': _$PlayerStatusEnumMap[instance.status]!,
    };

const _$PlayerStatusEnumMap = {
  PlayerStatus.yetToPlay: 1,
  PlayerStatus.playing: 2,
  PlayerStatus.played: 3,
  PlayerStatus.injured: 4,
  PlayerStatus.substitute: 5,
  PlayerStatus.suspended: 6,
  PlayerStatus.withdrawn: 7,
};

_$PlayerPerformanceImpl _$$PlayerPerformanceImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerPerformanceImpl(
      inning_id: json['inning_id'] as String,
      status: $enumDecodeNullable(_$PlayerStatusEnumMap, json['status']),
      index: (json['index'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PlayerPerformanceImplToJson(
        _$PlayerPerformanceImpl instance) =>
    <String, dynamic>{
      'inning_id': instance.inning_id,
      'status': _$PlayerStatusEnumMap[instance.status],
      'index': instance.index,
    };

_$RevisedTargetImpl _$$RevisedTargetImplFromJson(Map<String, dynamic> json) =>
    _$RevisedTargetImpl(
      runs: (json['runs'] as num?)?.toInt() ?? 0,
      overs: (json['overs'] as num?)?.toDouble() ?? 0,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      revised_time: _$JsonConverterFromJson<Object, DateTime>(
          json['revised_time'], const TimeStampJsonConverter().fromJson),
    );

Map<String, dynamic> _$$RevisedTargetImplToJson(_$RevisedTargetImpl instance) =>
    <String, dynamic>{
      'runs': instance.runs,
      'overs': instance.overs,
      'time': instance.time?.toIso8601String(),
      'revised_time': _$JsonConverterToJson<Object, DateTime>(
          instance.revised_time, const TimeStampJsonConverter().toJson),
    };
