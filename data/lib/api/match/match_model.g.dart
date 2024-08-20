// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchModelImpl _$$MatchModelImplFromJson(Map<String, dynamic> json) =>
    _$MatchModelImpl(
      id: json['id'] as String?,
      teams: (json['teams'] as List<dynamic>)
          .map((e) => MatchTeamModel.fromJson(e as Map<String, dynamic>))
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
      start_time: DateTime.parse(json['start_time'] as String),
      ball_type: $enumDecode(_$BallTypeEnumMap, json['ball_type']),
      pitch_type: $enumDecode(_$PitchTypeEnumMap, json['pitch_type']),
      created_by: json['created_by'] as String,
      umpires: (json['umpires'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      scorers: (json['scorers'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      commentators: (json['commentators'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      referee: json['referee'] == null
          ? null
          : UserModel.fromJson(json['referee'] as Map<String, dynamic>),
      match_status: $enumDecode(_$MatchStatusEnumMap, json['match_status']),
      toss_decision:
          $enumDecodeNullable(_$TossDecisionEnumMap, json['toss_decision']),
      toss_winner_id: json['toss_winner_id'] as String?,
      current_playing_team_id: json['current_playing_team_id'] as String?,
    );

Map<String, dynamic> _$$MatchModelImplToJson(_$MatchModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teams': instance.teams,
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
      'start_time': instance.start_time.toIso8601String(),
      'ball_type': _$BallTypeEnumMap[instance.ball_type]!,
      'pitch_type': _$PitchTypeEnumMap[instance.pitch_type]!,
      'created_by': instance.created_by,
      'umpires': instance.umpires,
      'scorers': instance.scorers,
      'commentators': instance.commentators,
      'referee': instance.referee,
      'match_status': _$MatchStatusEnumMap[instance.match_status]!,
      'toss_decision': _$TossDecisionEnumMap[instance.toss_decision],
      'toss_winner_id': instance.toss_winner_id,
      'current_playing_team_id': instance.current_playing_team_id,
    };

const _$MatchTypeEnumMap = {
  MatchType.limitedOvers: 1,
  MatchType.testMatch: 2,
  MatchType.theHundred: 3,
  MatchType.pairCricket: 4,
  MatchType.boxCricket: 5,
};

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

_$MatchTeamModelImpl _$$MatchTeamModelImplFromJson(Map<String, dynamic> json) =>
    _$MatchTeamModelImpl(
      team: TeamModel.fromJson(json['team'] as Map<String, dynamic>),
      captain_id: json['captain_id'] as String?,
      admin_id: json['admin_id'] as String?,
      over: (json['over'] as num?)?.toDouble() ?? 0,
      run: (json['run'] as num?)?.toInt() ?? 0,
      wicket: (json['wicket'] as num?)?.toInt() ?? 0,
      squad: (json['squad'] as List<dynamic>?)
              ?.map((e) => MatchPlayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MatchTeamModelImplToJson(
        _$MatchTeamModelImpl instance) =>
    <String, dynamic>{
      'team': instance.team,
      'captain_id': instance.captain_id,
      'admin_id': instance.admin_id,
      'over': instance.over,
      'run': instance.run,
      'wicket': instance.wicket,
      'squad': instance.squad,
    };

_$MatchPlayerImpl _$$MatchPlayerImplFromJson(Map<String, dynamic> json) =>
    _$MatchPlayerImpl(
      player: UserModel.fromJson(json['player'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$PlayerStatusEnumMap, json['status']) ??
          PlayerStatus.yetToPlay,
      index: (json['index'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MatchPlayerImplToJson(_$MatchPlayerImpl instance) =>
    <String, dynamic>{
      'player': instance.player,
      'status': _$PlayerStatusEnumMap[instance.status]!,
      'index': instance.index,
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

_$AddEditMatchRequestImpl _$$AddEditMatchRequestImplFromJson(Map json) =>
    _$AddEditMatchRequestImpl(
      id: json['id'] as String?,
      teams: (json['teams'] as List<dynamic>)
          .map((e) =>
              AddMatchTeamRequest.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      match_type: $enumDecode(_$MatchTypeEnumMap, json['match_type']),
      number_of_over: (json['number_of_over'] as num).toInt(),
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
      over_per_bowler: (json['over_per_bowler'] as num).toInt(),
      power_play_overs1: (json['power_play_overs1'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      power_play_overs2: (json['power_play_overs2'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      power_play_overs3: (json['power_play_overs3'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      city: json['city'] as String,
      ground: json['ground'] as String,
      start_time: DateTime.parse(json['start_time'] as String),
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
    );

Map<String, dynamic> _$$AddEditMatchRequestImplToJson(
        _$AddEditMatchRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teams': instance.teams.map((e) => e.toJson()).toList(),
      'match_type': _$MatchTypeEnumMap[instance.match_type]!,
      'number_of_over': instance.number_of_over,
      'players': instance.players,
      'team_ids': instance.team_ids,
      'team_creator_ids': instance.team_creator_ids,
      'over_per_bowler': instance.over_per_bowler,
      'power_play_overs1': instance.power_play_overs1,
      'power_play_overs2': instance.power_play_overs2,
      'power_play_overs3': instance.power_play_overs3,
      'city': instance.city,
      'ground': instance.ground,
      'start_time': instance.start_time.toIso8601String(),
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
    };

_$AddMatchTeamRequestImpl _$$AddMatchTeamRequestImplFromJson(Map json) =>
    _$AddMatchTeamRequestImpl(
      team_id: json['team_id'] as String,
      captain_id: json['captain_id'] as String?,
      admin_id: json['admin_id'] as String?,
      over: (json['over'] as num?)?.toDouble() ?? 0,
      run: (json['run'] as num?)?.toInt() ?? 0,
      wicket: (json['wicket'] as num?)?.toInt() ?? 0,
      squad: (json['squad'] as List<dynamic>?)
              ?.map((e) => MatchPlayerRequest.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AddMatchTeamRequestImplToJson(
        _$AddMatchTeamRequestImpl instance) =>
    <String, dynamic>{
      'team_id': instance.team_id,
      'captain_id': instance.captain_id,
      'admin_id': instance.admin_id,
      'over': instance.over,
      'run': instance.run,
      'wicket': instance.wicket,
      'squad': instance.squad.map((e) => e.toJson()).toList(),
    };

_$MatchPlayerRequestImpl _$$MatchPlayerRequestImplFromJson(Map json) =>
    _$MatchPlayerRequestImpl(
      id: json['id'] as String,
      status: $enumDecode(_$PlayerStatusEnumMap, json['status']),
      index: (json['index'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MatchPlayerRequestImplToJson(
        _$MatchPlayerRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$PlayerStatusEnumMap[instance.status]!,
      'index': instance.index,
    };
