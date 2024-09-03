// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import '../user/user_models.dart';
import '../../extensions/double_extensions.dart';
import '../../extensions/int_extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ball_score_model.freezed.dart';

part 'ball_score_model.g.dart';

@freezed
class BallScoreModel with _$BallScoreModel {
  const factory BallScoreModel({
    String? id,
    required String inning_id,
    required String match_id,
    required int over_number,
    required int ball_number,
    required String bowler_id,
    required String batsman_id,
    required String non_striker_id,
    required int runs_scored,
    ExtrasType? extras_type,
    int? extras_awarded,
    WicketType? wicket_type,
    FieldingPositionType? fielding_position,
    String? player_out_id,
    String? wicket_taker_id,
    required bool is_four,
    required bool is_six,
    required DateTime time,
  }) = _BallScoreModel;

  factory BallScoreModel.fromJson(Map<String, dynamic> json) =>
      _$BallScoreModelFromJson(json);

  factory BallScoreModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      BallScoreModel.fromJson(snapshot.data()!);
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

@JsonEnum(valueField: "value")
enum FieldingPositionType {
  deepMidWicket(1),
  longOn(2),
  longOff(3),
  deepCover(4),
  deepPoint(5),
  thirdMan(6),
  deepFineLeg(7),
  deepSquareLeg(8);

  final int value;

  const FieldingPositionType(this.value);
}

enum Distance {
  // do not change the order as position calculation depends on distance index
  short(3),
  mid(2),
  afterMid(1.4),
  boundary(1.15);

  final double divisor;

  const Distance(this.divisor);
}

enum Side {
  off(180),
  leg(0);

  final double angle;

  const Side(this.angle);
}

class FieldingPosition {
  FieldingPositionType type;
  double startAngle;
  double endAngle;
  Distance distance;
  bool showOnScreen;

  FieldingPosition(
    this.type, {
    required this.startAngle,
    required this.endAngle,
    this.distance = Distance.boundary,
    this.showOnScreen = true,
  });
}

@freezed
class UserStat with _$UserStat {
  const factory UserStat({
    BattingStat? battingStat,
    BowlingStat? bowlingStat,
    FieldingStat? fieldingStat,
  }) = _UserStat;
}

@freezed
class BattingStat with _$BattingStat {
  const factory BattingStat({
    @Default(0) int innings,
    @Default(0) int runScored,
    @Default(0.0) double average,
    @Default(0.0) double strikeRate,
    @Default(0) int ballFaced,
    @Default(0) int fours,
    @Default(0) int sixes,
    @Default(0) int fifties,
    @Default(0) int hundreds,
    @Default(0) int ducks,
  }) = _BattingStat;
}

@freezed
class BowlingStat with _$BowlingStat {
  const factory BowlingStat({
    @Default(0) int innings,
    @Default(0) int wicketTaken,
    @Default(0) int balls,
    @Default(0) int runsConceded,
    @Default(0) int maiden,
    @Default(0) int noBalls,
    @Default(0) int wideBalls,
    @Default(0.0) double average,
    @Default(0.0) double strikeRate,
    @Default(0.0) double economyRate,
  }) = _BowlingStat;
}

@freezed
class FieldingStat with _$FieldingStat {
  const factory FieldingStat({
    @Default(0) int catches,
    @Default(0) int runOut,
    @Default(0) int stumping,
  }) = _FieldingStat;
}

@freezed
class OverStatModel with _$OverStatModel {
  const factory OverStatModel({
    @Default(0) int run,
    @Default(0) int wicket,
    @Default(0) int extra,
  }) = _OverStatModel;

  factory OverStatModel.fromJson(Map<String, dynamic> json) =>
      _$OverStatModelFromJson(json);
}

@freezed
class TeamRunStat with _$TeamRunStat {
  const factory TeamRunStat({
    @Default("") String teamName,
    @Default(0) int run,
    @Default(0) int wicket,
    @Default(0) double over,
  }) = _TeamRunStat;

  factory TeamRunStat.fromJson(Map<String, dynamic> json) =>
      _$TeamRunStatFromJson(json);
}

@freezed
class OverSummary with _$OverSummary {
  const factory OverSummary({
    @Default('') String inning_id,
    @Default('') String team_id,
    @Default([]) List<BallScoreModel> balls,
    @Default(BowlerSummary()) BowlerSummary bowler,
    @Default(BatsmanSummary()) BatsmanSummary striker,
    @Default(BatsmanSummary()) BatsmanSummary nonStriker,
    @Default([]) List<BatsmanSummary> outPlayers,
    @Default(0) int overNumber,
    @Default(ExtraSummary()) ExtraSummary extrasSummary,
    @Default(0) int totalRuns,
    @Default(0) int totalWickets,
  }) = _OverSummary;
}

@freezed
class BatsmanSummary with _$BatsmanSummary {
  const factory BatsmanSummary({
    @Default(UserModel(id: '')) UserModel player,
    Player? ballBy,
    Player? catchBy,
    WicketType? wicketType,
    double? outAtOver,
    @Default(0) int runs,
    @Default(0) int ballFaced,
    @Default(0) int sixes,
    @Default(0) int fours,
  }) = _BatsmanSummary;
}

@freezed
class BowlerSummary with _$BowlerSummary {
  const factory BowlerSummary({
    @Default(UserModel(id: '')) UserModel player,
    @Default(0) int runsConceded,
    @Default(0) int maiden,
    @Default(0) double overDelivered,
    @Default(0) int wicket,
    @Default(0) int noBalls,
    @Default(0) int wideBalls,
  }) = _BowlerSummary;
}

@freezed
class Player with _$Player {
  const factory Player({
    @Default("") String id,
    @Default("") String name,
  }) = _Player;
}

@freezed
class ExtraSummary with _$ExtraSummary {
  const factory ExtraSummary({
    @Default(0) int bye,
    @Default(0) int legBye,
    @Default(0) int noBall,
    @Default(0) int wideBall,
    @Default(0) int penalty,
  }) = _ExtraSummary;
}

extension BallScoreModelBoolean on BallScoreModel? {
  bool? isLegalDelivery() {
    if (this == null) {
      return null;
    }
    return this!.extras_type != ExtrasType.penaltyRun &&
        this!.extras_type != ExtrasType.noBall &&
        this!.extras_type != ExtrasType.wide &&
        this!.wicket_type != WicketType.timedOut &&
        this!.wicket_type != WicketType.retired &&
        this!.wicket_type != WicketType.retiredHurt;
  }
}

extension OverSummaryMetaData on OverSummary {
  bool get isMaiden =>
      runs == 0 &&
      wickets == 0 &&
      extras == 0 &&
      balls.lastOrNull?.ball_number == 6 &&
      (balls.lastOrNull?.isLegalDelivery() ?? false);

  double get overCount {
    final int totalBalls = ((overNumber - 1) * 6) + legalDeliveriesCount;
    return totalBalls.toOvers();
  }

  int get legalDeliveriesCount =>
      balls.where((ball) => (ball.isLegalDelivery() ?? false)).length;

  int get runs =>
      balls.fold(0, (runCount, element) => runCount += element.runs_scored);

  int get extras => balls.fold(
        0,
        (extraCount, element) => extraCount += (element.extras_awarded ?? 0),
      );

  int get wickets => balls.fold(
        0,
        (wicketCount, element) => wicketCount += (element.wicket_type != null &&
                element.wicket_type != WicketType.retiredHurt
            ? 1
            : 0),
      );

  DateTime get time => balls.lastOrNull?.time ?? DateTime.now();

  BowlerSummary get bowlerStatAtStart {
    final runsInOver = balls
        .where(
          (ball) =>
              ball.extras_type == null ||
              ball.extras_type == ExtrasType.noBall ||
              ball.extras_type == ExtrasType.wide,
        )
        .fold(
          0,
          (runCount, ball) =>
              runCount += (ball.extras_awarded ?? 0) + ball.runs_scored,
        );
    final runsConceded = bowler.runsConceded - runsInOver;
    final maiden = bowler.maiden - (isMaiden ? 1 : 0);
    final wicketsInOver = balls
        .where(
          (element) =>
              element.wicket_type != null &&
              element.wicket_type != WicketType.retired &&
              element.wicket_type != WicketType.retiredHurt &&
              element.wicket_type != WicketType.timedOut,
        )
        .length;
    final wickets = bowler.wicket - wicketsInOver;
    final noBallInOver = balls
        .where((element) => element.extras_type == ExtrasType.noBall)
        .length;
    final noBalls = bowler.noBalls - noBallInOver;
    final wideBallInOver =
        balls.where((element) => element.extras_type == ExtrasType.wide).length;
    final wideBalls = bowler.wideBalls - wideBallInOver;

    final overDelivered = bowler.overDelivered.remove(legalDeliveriesCount);
    return bowler.copyWith(
      wideBalls: wideBalls,
      runsConceded: runsConceded,
      overDelivered: overDelivered,
      noBalls: noBalls,
      maiden: maiden,
      wicket: wickets,
    );
  }

  OverSummary addBall(BallScoreModel ball, {Player? catchBy}) {
    if (ball.over_number != overNumber && ball.inning_id != inning_id) {
      return this;
    }
    final totalRunCount =
        totalRuns + ball.runs_scored + (ball.extras_awarded ?? 0);
    final totalWicketCount = totalWickets +
        (ball.wicket_type != null && ball.wicket_type != WicketType.retiredHurt
            ? 1
            : 0);
    final extraSummaryDetail = extrasSummary.addExtra(ball);

    final ballScores = [...balls, ball].toList();
    ballScores.sort((a, b) => a.time.compareTo(b.time));

    final configuredStriker = striker.addBall(
      ball,
      ballBy: ball.player_out_id == striker.player.id
          ? Player(id: bowler.player.id, name: bowler.player.name ?? "")
          : null,
      catchBy: ball.player_out_id == striker.player.id ? catchBy : null,
    );

    final configuredNonStriker = nonStriker.addBall(
      ball,
      ballBy: ball.player_out_id == nonStriker.player.id
          ? Player(id: bowler.player.id, name: bowler.player.name ?? "")
          : null,
      catchBy: ball.player_out_id == nonStriker.player.id ? catchBy : null,
    );

    final outPlayersList = outPlayers.toList();
    if (ball.player_out_id == configuredStriker.player.id) {
      outPlayersList.add(configuredStriker);
    } else if (ball.player_out_id == configuredNonStriker.player.id) {
      outPlayersList.add(configuredNonStriker);
    }
    return copyWith(
      totalRuns: totalRunCount,
      totalWickets: totalWicketCount,
      extrasSummary: extraSummaryDetail,
      balls: ballScores,
      bowler: bowler.addBall(
        ball,
        isMaidenWithoutTheBall: runs == 0 && wickets == 0 && extras == 0,
      ),
      outPlayers: outPlayersList,
      striker: configuredStriker,
      nonStriker: configuredNonStriker,
    );
  }

  OverSummary? removeBall(BallScoreModel ball) {
    if (ball.over_number != overNumber && ball.inning_id != inning_id) {
      return this;
    }
    final totalRunCount =
        totalRuns - ball.runs_scored - (ball.extras_awarded ?? 0);
    final totalWicketCount = totalWickets -
        (ball.wicket_type != null && ball.wicket_type != WicketType.retiredHurt
            ? 1
            : 0);
    final extraSummaryDetail = extrasSummary.removeExtra(ball);

    final ballScores = balls.toList();
    ballScores.removeWhere((element) => element.id == ball.id);
    ballScores.sort((a, b) => a.time.compareTo(b.time));

    final configuredStriker = striker.removeBall(ball);
    final configuredNonStriker = nonStriker.removeBall(ball);

    final outPlayersList = outPlayers;
    if (ball.player_out_id == configuredStriker.player.id) {
      outPlayersList.removeWhere(
        (element) => element.player.id == configuredStriker.player.id,
      );
    } else if (ball.player_out_id == configuredNonStriker.player.id) {
      outPlayersList.removeWhere(
        (element) => element.player.id == configuredNonStriker.player.id,
      );
    }

    final lastBall = ballScores.lastOrNull;
    if (ballScores.isEmpty) {
      return null;
    }
    return copyWith(
      totalRuns: totalRunCount,
      totalWickets: totalWicketCount,
      extrasSummary: extraSummaryDetail,
      balls: ballScores,
      bowler: bowler.removeBall(ball, isMaidenIncludingBall: isMaiden),
      outPlayers: outPlayersList,
      striker: lastBall?.batsman_id == configuredStriker.player.id
          ? configuredStriker
          : configuredNonStriker,
      nonStriker: lastBall?.non_striker_id == configuredNonStriker.player.id
          ? configuredNonStriker
          : configuredStriker,
    );
  }
}

extension BowlerSummaryMetaData on BowlerSummary {
  double get economy {
    return double.parse((runsConceded / overDelivered).toStringAsFixed(1));
  }

  BowlerSummary addBall(
    BallScoreModel ball, {
    required bool isMaidenWithoutTheBall,
  }) {
    if (ball.bowler_id != player.id) {
      return this;
    }
    final wicketCount = ball.wicket_type != null &&
            ball.wicket_type != WicketType.retired &&
            ball.wicket_type != WicketType.retiredHurt &&
            ball.wicket_type != WicketType.timedOut
        ? wicket + 1
        : wicket;

    final noBallCount =
        ball.extras_type == ExtrasType.noBall ? noBalls + 1 : noBalls;

    final wideBallCount =
        ball.extras_type == ExtrasType.wide ? wideBalls + 1 : wideBalls;

    final overDeliverCount = (ball.isLegalDelivery() ?? false)
        ? overDelivered.add(1)
        : overDelivered;

    final runCount = ball.extras_type == null ||
            ball.extras_type == ExtrasType.noBall ||
            ball.extras_type == ExtrasType.wide
        ? runsConceded + (ball.extras_awarded ?? 0) + ball.runs_scored
        : runsConceded;

    final maidenCount = isMaidenWithoutTheBall &&
            ball.ball_number == 6 &&
            (ball.isLegalDelivery() ?? false) &&
            ball.extras_type == null &&
            ball.wicket_type == null &&
            ball.runs_scored == 0
        ? maiden + 1
        : maiden;

    return copyWith(
      wicket: wicketCount,
      maiden: maidenCount,
      noBalls: noBallCount,
      overDelivered: overDeliverCount,
      runsConceded: runCount,
      wideBalls: wideBallCount,
    );
  }

  BowlerSummary removeBall(
    BallScoreModel ball, {
    required bool isMaidenIncludingBall,
  }) {
    if (ball.bowler_id != player.id) {
      return this;
    }
    final wicketCount = ball.wicket_type != null &&
            ball.wicket_type != WicketType.retired &&
            ball.wicket_type != WicketType.retiredHurt &&
            ball.wicket_type != WicketType.timedOut
        ? wicket - 1
        : wicket;

    final noBallCount =
        ball.extras_type == ExtrasType.noBall ? noBalls - 1 : noBalls;

    final wideBallCount =
        ball.extras_type == ExtrasType.wide ? wideBalls - 1 : wideBalls;

    final overDeliverCount = (ball.isLegalDelivery() ?? false)
        ? overDelivered.remove(1)
        : overDelivered;

    final runCount = ball.extras_type == null ||
            ball.extras_type == ExtrasType.noBall ||
            ball.extras_type == ExtrasType.wide
        ? runsConceded - ((ball.extras_awarded ?? 0) + ball.runs_scored)
        : runsConceded;

    final maidenCount = isMaidenIncludingBall &&
            ball.ball_number == 6 &&
            (ball.isLegalDelivery() ?? false) &&
            ball.extras_type == null &&
            ball.wicket_type == null &&
            ball.runs_scored == 0
        ? maiden - 1
        : maiden;

    return copyWith(
      wicket: wicketCount,
      maiden: maidenCount,
      noBalls: noBallCount,
      overDelivered: overDeliverCount,
      runsConceded: runCount,
      wideBalls: wideBallCount,
    );
  }
}

extension BatsmanSummaryMetaData on BatsmanSummary {
  double get strikeRate {
    return double.parse(((runs / ballFaced) * 100).toStringAsFixed(1));
  }

  BatsmanSummary addBall(
    BallScoreModel ball, {
    Player? ballBy,
    Player? catchBy,
  }) {
    if (ball.batsman_id != player.id && ball.non_striker_id != player.id) {
      return this;
    }
    final ballFacedCount = ball.extras_type != ExtrasType.wide &&
            ball.extras_type != ExtrasType.penaltyRun &&
            ball.batsman_id == player.id
        ? ballFaced + 1
        : ballFaced;
    return copyWith(
      sixes: ball.batsman_id == player.id && ball.is_six ? sixes + 1 : sixes,
      fours: ball.batsman_id == player.id && ball.is_four ? fours + 1 : fours,
      catchBy: catchBy,
      ballBy: ballBy,
      ballFaced: ballFacedCount,
      runs: ball.batsman_id == player.id ? runs + ball.runs_scored : runs,
      outAtOver: ball.wicket_type != null && ball.player_out_id == player.id
          ? double.parse("${ball.over_number - 1}.${ball.ball_number}")
          : outAtOver,
      wicketType: ball.player_out_id == player.id ? ball.wicket_type : null,
    );
  }

  BatsmanSummary removeBall(BallScoreModel ball) {
    if (ball.batsman_id != player.id && ball.non_striker_id != player.id) {
      return this;
    }
    final ballFacedCount = ball.extras_type != ExtrasType.wide &&
            ball.extras_type != ExtrasType.penaltyRun &&
            ball.batsman_id == player.id
        ? ballFaced - 1
        : ballFaced;
    return copyWith(
      sixes: ball.batsman_id == player.id && ball.is_six ? sixes - 1 : sixes,
      fours: ball.batsman_id == player.id && ball.is_four ? fours - 1 : fours,
      catchBy: null,
      ballBy: null,
      ballFaced: ballFacedCount,
      runs: ball.batsman_id == player.id ? runs - ball.runs_scored : runs,
      outAtOver: null,
      wicketType: null,
    );
  }
}

extension ExtraSummaryMetaData on ExtraSummary {
  int get total {
    return bye + legBye + noBall + wideBall + penalty;
  }

  ExtraSummary addExtra(BallScoreModel ball) {
    if (ball.extras_type == null) {
      return this;
    }
    final ExtraSummary extra;
    switch (ball.extras_type!) {
      case ExtrasType.wide:
        extra = copyWith(wideBall: wideBall + (ball.extras_awarded ?? 0));
      case ExtrasType.noBall:
        extra = copyWith(noBall: noBall + (ball.extras_awarded ?? 0));
      case ExtrasType.bye:
        extra = copyWith(bye: bye + (ball.extras_awarded ?? 0));
      case ExtrasType.legBye:
        extra = copyWith(legBye: legBye + (ball.extras_awarded ?? 0));
      case ExtrasType.penaltyRun:
        extra = copyWith(penalty: penalty + (ball.extras_awarded ?? 0));
    }

    return extra;
  }

  ExtraSummary removeExtra(BallScoreModel ball) {
    if (ball.extras_type == null) {
      return this;
    }
    final ExtraSummary extra;
    switch (ball.extras_type!) {
      case ExtrasType.wide:
        extra = copyWith(wideBall: wideBall - (ball.extras_awarded ?? 0));
      case ExtrasType.noBall:
        extra = copyWith(noBall: noBall - (ball.extras_awarded ?? 0));
      case ExtrasType.bye:
        extra = copyWith(bye: bye - (ball.extras_awarded ?? 0));
      case ExtrasType.legBye:
        extra = copyWith(legBye: legBye - (ball.extras_awarded ?? 0));
      case ExtrasType.penaltyRun:
        extra = copyWith(penalty: penalty - (ball.extras_awarded ?? 0));
    }

    return extra;
  }
}
