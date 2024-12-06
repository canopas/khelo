// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'partnership_model.freezed.dart';
part 'partnership_model.g.dart';

@freezed
class PartnershipModel with _$PartnershipModel {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory PartnershipModel({
    required String id,
    required String match_id,
    required String inning_id,
    required List<String> player_ids,
    @Default([]) List<PartnershipPlayer> players,
    @Default(0) int runs,
    @Default(0) int extras,
    @Default(0) int ball_faced,
    @Default(0.0) double start_over,
    @Default(0.0) double end_over,
  }) = _PartnershipModel;

  factory PartnershipModel.fromJson(Map<String, dynamic> json) =>
      _$PartnershipModelFromJson(json);

  factory PartnershipModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) =>
      PartnershipModel.fromJson(snapshot.data()!);
}

@freezed
class PartnershipPlayer with _$PartnershipPlayer {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory PartnershipPlayer({
    required String player_id,
    @Default(0) int runs,
    @Default(0) int ball_faced,
    @Default(0) int fours,
    @Default(0) int sixes,
  }) = _PartnershipPlayer;

  factory PartnershipPlayer.fromJson(Map<String, dynamic> json) =>
      _$PartnershipPlayerFromJson(json);
}