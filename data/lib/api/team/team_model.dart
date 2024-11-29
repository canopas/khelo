// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converter/timestamp_json_converter.dart';
import '../../utils/constant/firestore_constant.dart';
import '../user/user_models.dart';

part 'team_model.freezed.dart';

part 'team_model.g.dart';

@freezed
abstract class TeamModel with _$TeamModel {
  @JsonSerializable(explicitToJson: true)
  const factory TeamModel({
    required String id,
    required String name,
    required String name_lowercase,
    String? city,
    String? name_initial,
    String? profile_img_url,
    String? created_by,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(UserModel(id: ''))
    UserModel created_by_user,
    DateTime? created_at,
    @TimeStampJsonConverter() DateTime? created_time,
    @JsonKey(name: FireStoreConst.teamPlayers)
    @Default([])
    List<TeamPlayer> players,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(TeamStat())
    TeamStat stat,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);

  factory TeamModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      TeamModel.fromJson(snapshot.data()!);
}

extension TeamModelExtension on TeamModel {
  bool isAdminOrOwner(String? currentUserId) {
    return created_by == currentUserId ||
        players.any(
          (element) =>
              element.id == currentUserId &&
              element.role == TeamPlayerRole.admin,
        );
  }
}

enum TeamPlayerRole {
  admin,
  player;

  bool get isAdmin => this == TeamPlayerRole.admin;

  bool get isMember => this == TeamPlayerRole.player;
}

@freezed
class TeamPlayer with _$TeamPlayer {
  @JsonSerializable(explicitToJson: true)
  const factory TeamPlayer({
    required String id,
    @Default(TeamPlayerRole.player) TeamPlayerRole role,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(UserModel(id: ''))
    UserModel user,
  }) = _TeamPlayer;

  factory TeamPlayer.fromJson(Map<String, dynamic> json) =>
      _$TeamPlayerFromJson(json);
}

@freezed
class TeamStat with _$TeamStat {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory TeamStat({
    @Default(0) int played,
    @Default(TeamMatchStatus()) TeamMatchStatus status,
    @Default(0) int runs,
    @Default(0) int wickets,
    @Default(0.0) double batting_average,
    @Default(0.0) double bowling_average,
    @Default(0) int highest_runs,
    @Default(0) int lowest_runs,
    @Default(0.0) double run_rate,
  }) = _TeamStat;

  factory TeamStat.fromJson(Map<String, dynamic> json) =>
      _$TeamStatFromJson(json);

  factory TeamStat.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      TeamStat.fromJson(snapshot.data()!);
}

@freezed
class TeamMatchStatus with _$TeamMatchStatus {
  const factory TeamMatchStatus({
    @Default(0) int win,
    @Default(0) int tie,
    @Default(0) int lost,
  }) = _TeamMatchStatus;

  factory TeamMatchStatus.fromJson(Map<String, dynamic> json) =>
      _$TeamMatchStatusFromJson(json);
}

extension TeamMatchStatusExtension on TeamMatchStatus {
  int get matchCount => win + tie + lost;
}
