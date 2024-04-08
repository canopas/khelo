// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ball_score_model.freezed.dart';

part 'ball_score_model.g.dart';

@freezed
class BallScoreModel with _$BallScoreModel {
  const factory BallScoreModel({
    String? id,
    required String inning_id,
    required int over_number,
    required int ball_number,
    required String bowler_id,
    required String batsman_id,
    required String non_striker_id,
    int? runs_scored,
    ExtrasType? extras_type,
    int? extras_awarded,
    WicketType? wicket_type,
    String? player_out_id,
    String? wicket_taker_id,
    required bool is_four,
    required bool is_six,
    required DateTime time,
  }) = _BallScoreModel;

  factory BallScoreModel.fromJson(Map<String, dynamic> json) => _$BallScoreModelFromJson(json);

}

@JsonEnum(valueField: "value")
enum ExtrasType {
  wide(1),
  noBall(2),
  bye(3),
  legBye(4),
  penaltyRun(5);

  final int value;

  const ExtrasType(this.value);
}

@JsonEnum(valueField: "value")
enum WicketType {
  bowled(1),
  caught(2),
  caughtBehind(3),
  caughtAndBowled(4),
  lbw(5),
  stumped(6),
  runOut(7),
  hitWicket(8),
  hitBallTwice(9),
  handledBall(10),
  obstructingField(11),
  timedOut(12),
  retired(13),
  retiredHurt(14);

  final int value;

  const WicketType(this.value);
}
