// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converter/timestamp_json_converter.dart';
import '../ball_score/ball_score_model.dart';

part 'match_event_model.freezed.dart';
part 'match_event_model.g.dart';

@Freezed()
class MatchEventModel with _$MatchEventModel {
  @JsonSerializable(anyMap: true, explicitToJson: true, includeIfNull: false)
  const factory MatchEventModel({
    required String id,
    required String match_id,
    required String inning_id,
    required EventType type,
    @TimeStampJsonConverter() required DateTime time,
    String? bowler_id,
    String? batsman_id,
    FieldingPositionType? fielding_position,
    @Default(0) double over,
    @Default([]) List<String> ball_ids,
    @Default([]) List<MatchEventWicket> wickets,
    @Default([]) List<MatchEventMilestone> milestone,
  }) = _MatchEventModel;

  factory MatchEventModel.fromJson(Map<String, dynamic> json) =>
      _$MatchEventModelFromJson(json);

  factory MatchEventModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      MatchEventModel.fromJson(snapshot.data()!);
}

@JsonEnum(valueField: "value")
enum EventType {
  hatTrick(1),
  century(2),
  fifty(3),
  wicket(4),
  six(5),
  four(6);

  final int value;

  const EventType(this.value);
}

@freezed
class MatchEventWicket with _$MatchEventWicket {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory MatchEventWicket({
    @TimeStampJsonConverter() required DateTime time,
    required String ball_id,
    required String batsman_id,
    required WicketType wicket_type,
    required double over,
    String? wicket_taker_id,
  }) = _MatchEventWicket;

  factory MatchEventWicket.fromJson(Map<String, dynamic> json) =>
      _$MatchEventWicketFromJson(json);

  factory MatchEventWicket.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      MatchEventWicket.fromJson(snapshot.data()!);
}

@freezed
class MatchEventMilestone with _$MatchEventMilestone {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory MatchEventMilestone({
    @TimeStampJsonConverter() required DateTime time,
    required String ball_id,
    @Default(0.0) double over,
    @Default(0) int runs,
    @Default(0) int ball_faced,
    @Default(0) int fours,
    @Default(0) int sixes,
  }) = _MatchEventMilestone;

  factory MatchEventMilestone.fromJson(Map<String, dynamic> json) =>
      _$MatchEventMilestoneFromJson(json);

  factory MatchEventMilestone.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) =>
      MatchEventMilestone.fromJson(snapshot.data()!);
}