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
    List<UserModel>? players,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);
}

@freezed
class AddTeamRequestModel with _$AddTeamRequestModel {
  const factory AddTeamRequestModel({
    String? id,
    required String name,
    required String name_lowercase,
    String? city,
    String? profile_img_url,
    String? created_by,
    DateTime? created_at,
    List<String>? players,
  }) = _AddTeamRequestModel;

  factory AddTeamRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddTeamRequestModelFromJson(json);

  factory AddTeamRequestModel.fromFireStore(
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      AddTeamRequestModel.fromJson(snapshot.data()!);
}
