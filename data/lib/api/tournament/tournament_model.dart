// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converter/timestamp_json_converter.dart';
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
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(TournamentStatus.upcoming)
    TournamentStatus status,
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
  }) = _TournamentModel;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);

  factory TournamentModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      TournamentModel.fromJson(snapshot.data()!);
}

extension TournamentModelExtensions on TournamentModel {
  TournamentStatus getTournamentStatus(List<MatchModel> matches) {
    if (matches.isEmpty) return TournamentStatus.upcoming;

    final bool isUpcoming = (start_date.isAfter(DateTime.now()) &&
            end_date.isAfter(DateTime.now())) &&
        matches.every((match) => match.match_status == MatchStatus.yetToStart);

    final bool isRunning = start_date.isBefore(DateTime.now()) &&
        end_date.isAfter(DateTime.now()) &&
        matches.any((match) => match.match_status == MatchStatus.running);

    final bool isFinished = end_date.isBefore(DateTime.now()) &&
        matches.every(
          (match) =>
              match.match_status == MatchStatus.finish ||
              match.match_status == MatchStatus.abandoned,
        );

    final bool isInProgress = start_date.isBefore(DateTime.now()) &&
        end_date.isAfter(DateTime.now()) &&
        matches.any(
          (match) =>
              match.match_status == MatchStatus.running ||
              match.match_status == MatchStatus.yetToStart,
        );

    if (isUpcoming) return TournamentStatus.upcoming;
    if (isRunning || isInProgress) return TournamentStatus.running;
    if (isFinished) return TournamentStatus.finish;

    return TournamentStatus.finish;
  }
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
  knockOut(1, minTeamReq: 2),
  miniRobin(2, minTeamReq: 3),
  boxLeague(3, minTeamReq: 4),
  doubleOut(4, minTeamReq: 4),
  bestOfThree(6, minTeamReq: 2),
  custom(7, minTeamReq: 2);

  final int value;
  final int minTeamReq;

  const TournamentType(this.value, {required this.minTeamReq});
}

@JsonEnum(valueField: "value")
enum TournamentStatus {
  upcoming(1),
  running(2),
  finish(3);

  final int value;

  const TournamentStatus(this.value);
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
    required String player_id,
    required String teamName,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(UserModel(id: ''))
    UserModel player,
    @Default(UserStat()) UserStat stats,
    @JsonKey(includeToJson: false, includeFromJson: false) KeyStatTag? tag,
    int? value,
  }) = _PlayerKeyStat;

  factory PlayerKeyStat.fromJson(Map<String, dynamic> json) =>
      _$PlayerKeyStatFromJson(json);

  factory PlayerKeyStat.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      PlayerKeyStat.fromJson(snapshot.data()!);
}

enum KeyStatTag {
  mostRuns,
  mostWickets,
  mostFours,
  mostSixes;
}

@freezed
class TournamentTeamStat with _$TournamentTeamStat {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory TournamentTeamStat({
    required String team_id,
    @JsonKey(includeToJson: false, includeFromJson: false) TeamModel? team,
    @Default(0) int points,
    @Default(0) int wins,
    @Default(0) int losses,
    @Default(0.0) double nrr,
    @Default(0) int played_matches,
  }) = _TournamentTeamStat;

  factory TournamentTeamStat.fromJson(Map<String, dynamic> json) =>
      _$TournamentTeamStatFromJson(json);

  factory TournamentTeamStat.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      TournamentTeamStat.fromJson(snapshot.data()!);
}

extension TournamentTeamStatExtensions on MatchModel {
  TournamentTeamStat getTeamStat(
    String teamId, {
    TournamentTeamStat? currentTeamStat,
  }) {
    int wins = currentTeamStat?.wins ?? 0;
    int losses = currentTeamStat?.losses ?? 0;
    int points = currentTeamStat?.points ?? 0;
    final int playedMatches = currentTeamStat?.played_matches ?? 0;

    final team = teams.firstWhere((team) => team.team.id == teamId);
    final opponent = teams.firstWhere((team) => team.team.id != teamId);

    final teamRuns = team.run;
    final teamOvers = team.over;
    final opponentRuns = opponent.run;
    final opponentOvers = opponent.over;

    if (matchResult?.teamId == teamId) {
      wins++;
      points += 2;
    } else if (matchResult?.winType == WinnerByType.tie) {
      points += 1;
    } else {
      losses++;
    }

    double currentNRR = 0;
    if (teamOvers > 0 && opponentOvers > 0) {
      currentNRR = (teamRuns / teamOvers) - (opponentRuns / opponentOvers);
    }

    double combinedNRR = currentTeamStat?.nrr ?? 0;
    if (playedMatches > 1) {
      combinedNRR =
          ((combinedNRR * (playedMatches - 1)) + currentNRR) / playedMatches;
    } else {
      combinedNRR = currentNRR;
    }

    return TournamentTeamStat(
      team_id: teamId,
      wins: wins,
      losses: losses,
      played_matches: playedMatches + 1,
      points: points,
      nrr: combinedNRR,
    );
  }
}

extension PlayerKeyStatListExtensions on List<PlayerKeyStat> {
  List<PlayerKeyStat> getTopKeyStats() {
    final Map<String, PlayerKeyStat> playerMap = {};

    for (final playerStat in this) {
      final battingStats = playerStat.stats.batting;
      final bowlingStats = playerStat.stats.bowling;

      int highestRuns = 0;
      int highestWickets = 0;
      int highestFours = 0;
      int highestSixes = 0;

      KeyStatTag? assignedTag;
      int highestValue = 0;

      // Check for most runs
      if (battingStats.run_scored > highestRuns) {
        assignedTag = KeyStatTag.mostRuns;
        highestRuns = battingStats.run_scored;
        highestValue = battingStats.run_scored;
      }

      // Check for most wickets
      if (bowlingStats.wicket_taken > highestWickets) {
        assignedTag = KeyStatTag.mostWickets;
        highestWickets = bowlingStats.wicket_taken;
        highestValue = bowlingStats.wicket_taken;
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
