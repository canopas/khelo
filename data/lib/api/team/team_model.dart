// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/api/user/user_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_model.freezed.dart';

part 'team_model.g.dart';

@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    String? id,
    required String name,
    required String name_lowercase,
    String? city,
    String? profile_img_url,
    String? created_by,
    DateTime? created_at,
    @Default([]) List<TeamPlayer> players,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);

  factory TeamModel.fromFireStore(
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      TeamModel.fromJson(snapshot.data()!);
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
    @JsonKey(includeToJson: false, includeFromJson: false) UserModel? user,
  }) = _TeamPlayer;

  factory TeamPlayer.fromJson(Map<String, dynamic> json) =>
      _$TeamPlayerFromJson(json);
}
