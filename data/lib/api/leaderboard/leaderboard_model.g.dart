// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderboardModelImpl _$$LeaderboardModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaderboardModelImpl(
      type: $enumDecode(_$LeaderboardFieldEnumMap, json['type']),
      players: (json['players'] as List<dynamic>?)
              ?.map(
                  (e) => LeaderboardPlayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LeaderboardModelImplToJson(
        _$LeaderboardModelImpl instance) =>
    <String, dynamic>{
      'type': _$LeaderboardFieldEnumMap[instance.type]!,
      'players': instance.players,
    };

const _$LeaderboardFieldEnumMap = {
  LeaderboardField.batting: 'batting',
  LeaderboardField.bowling: 'bowling',
  LeaderboardField.fielding: 'fielding',
};

_$LeaderboardPlayerImpl _$$LeaderboardPlayerImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaderboardPlayerImpl(
      date: const TimeStampJsonConverter().fromJson(json['date'] as Object),
      id: json['id'] as String,
      runs: (json['runs'] as num?)?.toInt() ?? 0,
      wickets: (json['wickets'] as num?)?.toInt() ?? 0,
      catches: (json['catches'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$LeaderboardPlayerImplToJson(
        _$LeaderboardPlayerImpl instance) =>
    <String, dynamic>{
      'date': const TimeStampJsonConverter().toJson(instance.date),
      'id': instance.id,
      'runs': instance.runs,
      'wickets': instance.wickets,
      'catches': instance.catches,
    };
