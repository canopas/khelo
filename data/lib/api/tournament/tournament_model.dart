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
    @Default([]) List<TournamentMember> members,
    required String created_by,
    @TimeStampJsonConverter() DateTime? created_at,
    @TimeStampJsonConverter() required DateTime start_date,
    @TimeStampJsonConverter() DateTime? end_date,
    @Default([]) List<String> team_ids,
    @Default([]) List<String> match_ids,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<TeamModel> teams,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<MatchModel> matches,
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
  knockOut(1, minTeamRequirement: 2),
  miniRobin(2, minTeamRequirement: 3),
  boxLeague(3, minTeamRequirement: 4),
  doubleOut(4, minTeamRequirement: 4),
  superOver(5, minTeamRequirement: 2),
  bestOf(6, minTeamRequirement: 2),
  gully(7, minTeamRequirement: 2),
  mixed(8, minTeamRequirement: 2),
  other(9, minTeamRequirement: 2);

  final int value;
  final int minTeamRequirement;

  const TournamentType(this.value, {required this.minTeamRequirement});
}

enum TournamentMemberRole {
  organizer,
  admin;

  bool get isOrganizer => this == TournamentMemberRole.organizer;

  bool get isAdmin => this == TournamentMemberRole.admin;
}
