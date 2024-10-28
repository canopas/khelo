// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converter/timestamp_json_converter.dart';
import '../ball_score/ball_score_model.dart';
import '../match/match_model.dart';
import '../team/team_model.dart';
import '../user/user_models.dart';

part 'tournament_model.freezed.dart';

part 'tournament_model.g.dart';

@freezed
class TournamentModel with _$TournamentModel {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory TournamentModel({
    required String id,
    required String name,
    String? profile_img_url,
    String? banner_img_url,
    required TournamentType type,
    @Default([]) List<TournamentMember> members,
    required String created_by,
    @TimeStampJsonConverter() DateTime? created_at,
    @TimeStampJsonConverter() required DateTime start_date,
    @TimeStampJsonConverter() required DateTime end_date,
    @Default([]) List<String> team_ids,
    @Default([]) List<String> match_ids,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<TeamModel> teams,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<MatchModel> matches,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<PlayerKeyStat> keyStats,
  }) = _TournamentModel;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);

  factory TournamentModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      TournamentModel.fromJson(snapshot.data()!);
}

@freezed
class TournamentMember with _$TournamentMember {
  @JsonSerializable(explicitToJson: true)
  const factory TournamentMember({
    required String id,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(UserModel(id: ''))
    UserModel user,
    @Default(TournamentMemberRole.admin) TournamentMemberRole role,
  }) = _TournamentMember;

  factory TournamentMember.fromJson(Map<String, dynamic> json) =>
      _$TournamentMemberFromJson(json);
}

@JsonEnum(valueField: "value")
enum TournamentType {
  knockOut(1),
  miniRobin(2),
  boxLeague(3),
  doubleOut(4),
  superOver(5),
  bestOf(6),
  gully(7),
  mixed(8),
  other(9);

  final int value;

  const TournamentType(this.value);
}

enum TournamentMemberRole {
  organizer,
  admin;

  bool get isOrganizer => this == TournamentMemberRole.organizer;

  bool get isAdmin => this == TournamentMemberRole.admin;
}

@freezed
class PlayerKeyStat with _$PlayerKeyStat {
  @JsonSerializable(explicitToJson: true)
  const factory PlayerKeyStat({
    required String teamName,
    required UserModel player,
    required UserStat stats,
    KeyStatTag? tag,
    int? value,
  }) = _PlayerKeyStat;
}

enum KeyStatTag {
  mostRuns,
  mostWickets,
  mostFours,
  mostSixes;
}

@freezed
class TeamPoint with _$TeamPoint {
  const factory TeamPoint({
    required TeamModel team,
    required int points,
    required TeamStat stat,
    required int matchCount,
  }) = _TeamPoint;
}

extension PlayerKeyStatListExtensions on List<PlayerKeyStat> {
  List<PlayerKeyStat> getTopKeyStats() {
    final Map<String, PlayerKeyStat> playerMap = {};

    for (final playerStat in this) {
      final battingStats = playerStat.stats.battingStat;
      final bowlingStats = playerStat.stats.bowlingStat;

      if (bowlingStats == null || battingStats == null) continue;

      int highestRuns = 0;
      int highestWickets = 0;
      int highestFours = 0;
      int highestSixes = 0;

      KeyStatTag? assignedTag;
      int highestValue = 0;

      // Check for most runs
      if (battingStats.runScored > highestRuns) {
        assignedTag = KeyStatTag.mostRuns;
        highestRuns = battingStats.runScored;
        highestValue = battingStats.runScored;
      }

      // Check for most wickets
      if (bowlingStats.wicketTaken > highestWickets) {
        assignedTag = KeyStatTag.mostWickets;
        highestWickets = bowlingStats.wicketTaken;
        highestValue = bowlingStats.wicketTaken;
      }

      // Check for most fours
      if (battingStats.fours > highestFours) {
        assignedTag = KeyStatTag.mostFours;
        highestFours = battingStats.fours;
        highestValue = battingStats.fours;
      }

      // Check for most sixes
      if (battingStats.sixes > highestSixes) {
        assignedTag = KeyStatTag.mostSixes;
        highestSixes = battingStats.sixes;
        highestValue = battingStats.sixes;
      }

      if (assignedTag != null && highestValue > 0) {
        if (playerMap.containsKey(playerStat.player.id)) {
          final existingPlayerStat = playerMap[playerStat.player.id]!;

          if (highestValue > (existingPlayerStat.value ?? 0)) {
            playerMap[playerStat.player.id] = existingPlayerStat.copyWith(
              tag: assignedTag,
              value: highestValue,
            );
          }
        } else {
          playerMap[playerStat.player.id] = playerStat.copyWith(
            tag: assignedTag,
            value: highestValue,
          );
        }
      }
    }

    return playerMap.values.toList();
  }
}
