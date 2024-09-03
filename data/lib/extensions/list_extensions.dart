import "package:collection/collection.dart";

import '../api/ball_score/ball_score_model.dart';

extension ListExtension<E> on List<E> {
  ///Update the element at any position; it will return the same list if the element is not found.
  List<E> updateWhere({
    required bool Function(E element) where,
    required E Function(E oldElement) updated,
    E Function()? onNotFound,
  }) {
    final newList = toList();
    final int index = newList.indexWhere(where);
    if (index >= 0) {
      newList[index] = updated(newList[index]);
    } else {
      if (onNotFound != null) {
        newList.add(onNotFound());
      }
    }
    return newList;
  }

  /// This converts a list into a list of lists, using the specified size.
  /// For example:
  /// List<int> numbers = List.generate(100, (index) => index + 1);
  /// List<List<int>> result = numbers.chunked(5);
  List<List<E>> chunked(int size) {
    return List.generate((length / size).ceil(), (index) {
      final int start = index * size;
      return sublist(start, start + size < length ? start + size : length);
    });
  }
}

extension BallScoreList on List<BallScoreModel> {
  UserStat calculateUserStats(String currentUserId) {
    final batingStat = calculateBattingStats(currentUserId: currentUserId);

    final bowlingStat = calculateBowlingStats(currentUserId);

    final fieldingStat = calculateFieldingStats(currentUserId);

    return UserStat(
      battingStat: batingStat,
      bowlingStat: bowlingStat,
      fieldingStat: fieldingStat,
    );
  }

  BattingStat calculateBattingStats({
    required String currentUserId,
  }) {
    int runScored = 0;
    int dismissal = 0;
    int ballFaced = 0;
    int fours = 0;
    int sixes = 0;

    final Map<String, List<BallScoreModel>> inningGroup = {};

    for (final element in this) {
      // Runs scored
      if (element.batsman_id == currentUserId) {
        runScored += element.runs_scored;

        // Track boundaries
        if (element.is_four && element.runs_scored == 4) {
          fours++;
        } else if (element.is_six && element.runs_scored == 6) {
          sixes++;
        }

        // Count valid balls faced (excluding no balls, wides, etc.)
        if (element.extras_type == null ||
            element.extras_type == ExtrasType.legBye ||
            element.extras_type == ExtrasType.bye) {
          ballFaced++;
        }
      }

      // Dismissals
      if (element.player_out_id == currentUserId) {
        dismissal++;
      }

      // Group by innings
      if (element.batsman_id == currentUserId ||
          element.non_striker_id == currentUserId ||
          element.player_out_id == currentUserId) {
        inningGroup.putIfAbsent(element.inning_id, () => []).add(element);
      }
    }

    // Calculate averages and strike rate
    final average = dismissal == 0 ? 0.0 : runScored / dismissal;
    final strikeRate = ballFaced == 0 ? 0.0 : (runScored / ballFaced) * 100.0;

    // Calculate ducks, fifties, and hundreds
    int ducks = 0;
    int fifties = 0;
    int hundreds = 0;

    inningGroup.forEach((inningId, balls) {
      int inningRunScored = 0;
      int inningBallFaced = 0;
      bool isDismissed = false;

      for (final ball in balls) {
        if (ball.batsman_id == currentUserId) {
          inningRunScored += ball.runs_scored;
          if (ball.extras_type == null ||
              ball.extras_type == ExtrasType.legBye ||
              ball.extras_type == ExtrasType.bye) {
            inningBallFaced++;
          }
        }

        if (ball.player_out_id == currentUserId &&
            ball.wicket_type != WicketType.retiredHurt) {
          isDismissed = true;
        }
      }

      if (inningRunScored >= 100) {
        hundreds++;
      } else if (inningRunScored >= 50) {
        fifties++;
      }

      if (isDismissed && inningBallFaced >= 0 && inningBallFaced <= 2) {
        ducks++;
      }
    });

    return BattingStat(
      innings: inningGroup.length,
      average: average,
      strikeRate: strikeRate,
      ballFaced: ballFaced,
      runScored: runScored,
      fours: fours,
      sixes: sixes,
      ducks: ducks,
      fifties: fifties,
      hundreds: hundreds,
    );
  }


  BowlingStat calculateBowlingStats(String currentUserId) {
    final deliveries = where((element) => element.bowler_id == currentUserId);

    final wicketTaken = deliveries
        .where(
          (element) =>
              element.wicket_type != null &&
              (element.wicket_type == WicketType.retired ||
                  element.wicket_type == WicketType.retiredHurt ||
                  element.wicket_type == WicketType.timedOut),
        )
        .length;

    final bowledBallCount = deliveries
        .where(
          (element) =>
              element.wicket_type != WicketType.retired &&
              element.wicket_type != WicketType.retiredHurt &&
              element.wicket_type != WicketType.timedOut &&
              element.extras_type != ExtrasType.penaltyRun,
        )
        .length;

    final bowledBallCountForEconomyRate = deliveries
        .where(
          (element) =>
              (element.extras_type == null ||
                  element.extras_type == ExtrasType.legBye ||
                  element.extras_type == ExtrasType.bye) &&
              element.wicket_type != WicketType.retired &&
              element.wicket_type != WicketType.retiredHurt &&
              element.wicket_type != WicketType.timedOut &&
              element.extras_type != ExtrasType.penaltyRun,
        )
        .length;

    final runsConceded = deliveries
        .where((element) => element.extras_type != ExtrasType.penaltyRun)
        .fold(
          0,
          (sum, element) =>
              sum + element.runs_scored + (element.extras_awarded ?? 0),
        );

    final average = wicketTaken == 0 ? 0.0 : runsConceded / wicketTaken;

    final strikeRate = wicketTaken == 0 ? 0.0 : bowledBallCount / wicketTaken;

    final economyRate = bowledBallCountForEconomyRate == 0
        ? 0.0
        : (runsConceded / bowledBallCountForEconomyRate) * 6;

    final wideBallCount = deliveries
        .where((element) => element.extras_type == ExtrasType.wide)
        .length;
    final noBallCount = deliveries
        .where((element) => element.extras_type == ExtrasType.noBall)
        .length;

    final inningGroup = groupBy(deliveries, (ball) => ball.inning_id);
    int maiden = 0;

    inningGroup.forEach((inningId, balls) {
      final overGroup = groupBy(balls, (ball) => ball.over_number);

      overGroup.forEach((overNumber, balls) {
        int runsConcededInOver = 0;
        bool hasExtras = false;

        for (final ball in balls) {
          runsConcededInOver += ball.runs_scored + (ball.extras_awarded ?? 0);
          if (ball.extras_type != null) {
            hasExtras = true;
            break;
          }
        }

        if (runsConcededInOver == 0 && !hasExtras && balls.length == 6) {
          maiden++;
        }
      });
    });

    return BowlingStat(
      innings: inningGroup.length,
      average: average,
      strikeRate: strikeRate,
      wicketTaken: wicketTaken,
      economyRate: economyRate,
      balls: bowledBallCount,
      wideBalls: wideBallCount,
      runsConceded: runsConceded,
      noBalls: noBallCount,
      maiden: maiden,
    );
  }

  FieldingStat calculateFieldingStats(String currentUserId) {
    final catches = where(
      (element) =>
          element.wicket_taker_id == currentUserId &&
          (element.wicket_type == WicketType.caught ||
              element.wicket_type == WicketType.caughtBehind ||
              element.wicket_type == WicketType.caughtAndBowled),
    ).length;

    final runOut = where(
      (element) =>
          element.wicket_taker_id == currentUserId &&
          element.wicket_type == WicketType.runOut,
    ).length;

    final stumping = where(
      (element) =>
          element.wicket_taker_id == currentUserId &&
          element.wicket_type == WicketType.stumped,
    ).length;

    return FieldingStat(
      catches: catches,
      runOut: runOut,
      stumping: stumping,
    );
  }
}
