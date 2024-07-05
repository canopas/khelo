// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inning_model.freezed.dart';

part 'inning_model.g.dart';

@freezed
class InningModel with _$InningModel {
  const factory InningModel({
    String? id,
    required String match_id,
    required String team_id,
    @Default(0) double overs,
    @Default(0) int total_runs,
    @Default(0) int total_wickets,
    InningStatus? innings_status,
  }) = _InningModel;

  factory InningModel.fromJson(Map<String, dynamic> json) =>
      _$InningModelFromJson(json);

  factory InningModel.fromFireStore(
          DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) =>
      InningModel.fromJson(snapshot.data()!);
}

@JsonEnum(valueField: "value")
enum InningStatus {
  yetToStart(1),
  running(2),
  finish(3);

  final int value;

  const InningStatus(this.value);
}
