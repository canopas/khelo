// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'inning_model.freezed.dart';

part 'inning_model.g.dart';

@freezed
class InningModel with _$InningModel {
  const factory InningModel({
    String? id,
    required String match_id,
    required String team_id,
    double? overs,
    int? total_runs,
    int? total_wickets,
    InningStatus? innings_status,
  }) = _InningModel;

  factory InningModel.fromJson(Map<String, dynamic> json) =>
      _$InningModelFromJson(json);
}

@JsonEnum(valueField: "value")
enum InningStatus {
  yetToStart(1),
  running(2),
  finish(3);

  final int value;

  const InningStatus(this.value);
}

// first inning --> TOSS WINNER TEAM--
// first team score in whole match,
// first team wicket taken in whole match,
// inning status: if toss winner team is doing what they chose than first inning is running
// inning status: if toss winner team is doing opposite from what they chose than second inning is running
// if match complete then both inning complete
