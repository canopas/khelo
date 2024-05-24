import 'dart:async';
import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:data/service/ball_score/ball_score_service.dart';
import 'package:data/storage/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stat_view_model.freezed.dart';

final userStatViewStateProvider =
    StateNotifierProvider<UserStatViewNotifier, UserStatViewState>((ref) {
  final notifier = UserStatViewNotifier(
    ref.read(ballScoreServiceProvider),
    ref.read(currentUserPod)?.id,
  );
  ref.listen(currentUserPod, (previous, next) {
    notifier.setUserId(next?.id);
  });
  return notifier;
});

class UserStatViewNotifier extends StateNotifier<UserStatViewState> {
  final BallScoreService _ballScoreService;
  late StreamSubscription _ballScoreStreamSubscription;

  UserStatViewNotifier(this._ballScoreService, String? userId)
      : super(UserStatViewState(currentUserId: userId)) {
    _getUserRelatedBalls();
  }

  void setUserId(String? userId) {
    state = state.copyWith(currentUserId: userId);
  }

  Future<void> _getUserRelatedBalls() async {
    state = state.copyWith(loading: true);
    try {
      _ballScoreStreamSubscription =
          _ballScoreService.getCurrentUserRelatedBalls().listen((ballScores) {
        final userStat = _calculateUserStats(ballScores);
        state = state.copyWith(userStat: userStat, loading: false, error: null);
      }, onError: (e) {
        state = state.copyWith(error: e, loading: false);
        debugPrint(
            "UserStatViewNotifier: error while getting user related balls -> $e");
      });
    } catch (e) {
      state = state.copyWith(error: e, loading: false);
      debugPrint(
          "UserStatViewNotifier: error while getting user related balls -> $e");
    }
  }

  UserStat _calculateUserStats(List<BallScoreModel> ballList) {
    final runScored = ballList
        .where((element) => element.batsman_id == state.currentUserId)
        .fold(0, (sum, element) => sum + element.runs_scored);
    final (battingAverage, battingStrikeRate, ballFaced) =
        _calculateBatingStats(ballList: ballList, runScored: runScored);

    final (wicketTaken, bowlingAverage, bowlingStrikeRate, economyRate) =
        _calculateBowlingStats(ballList);

    final (catches, runOut, stumping) = _calculateFieldingStats(ballList);

    return UserStat(
      run_scored: runScored,
      batting_average: battingAverage,
      batting_strike_rate: battingStrikeRate,
      ball_faced: ballFaced,
      wicket_taken: wicketTaken,
      bowling_average: bowlingAverage,
      bowling_strike_rate: bowlingStrikeRate,
      economy_rate: economyRate,
      catches: catches,
      run_out: runOut,
      stumping: stumping,
    );
  }

  (double, double, int) _calculateBatingStats({
    required List<BallScoreModel> ballList,
    required int runScored,
  }) {
    final dismissal = ballList
        .where((element) => element.player_out_id == state.currentUserId)
        .length;

    final ballFaced = ballList
        .where((element) =>
            element.batsman_id == state.currentUserId &&
            (element.extras_type == null ||
                element.extras_type == ExtrasType.legBye ||
                element.extras_type == ExtrasType.bye))
        .length;

    final average = dismissal == 0 ? 0.0 : runScored / dismissal;

    final strikeRate = ballFaced == 0 ? 0.0 : (runScored / ballFaced) * 100.0;

    return (average, strikeRate, ballFaced);
  }

  (int, double, double, double) _calculateBowlingStats(
      List<BallScoreModel> ballList) {
    final deliveries =
        ballList.where((element) => element.bowler_id == state.currentUserId);

    final wicketTaken = deliveries
        .where((element) =>
            element.wicket_type != null &&
            (element.wicket_type == WicketType.retired ||
                element.wicket_type == WicketType.retiredHurt ||
                element.wicket_type == WicketType.timedOut))
        .length;

    final bowledBallCount = deliveries
        .where((element) =>
            element.wicket_type != WicketType.retired &&
            element.wicket_type != WicketType.retiredHurt &&
            element.wicket_type != WicketType.timedOut &&
            element.extras_type != ExtrasType.penaltyRun)
        .length;

    final bowledBallCountForEconomyRate = deliveries
        .where((element) =>
            (element.extras_type == null ||
                element.extras_type == ExtrasType.legBye ||
                element.extras_type == ExtrasType.bye) &&
            element.wicket_type != WicketType.retired &&
            element.wicket_type != WicketType.retiredHurt &&
            element.wicket_type != WicketType.timedOut &&
            element.extras_type != ExtrasType.penaltyRun)
        .length;

    final runsConceded = deliveries
        .where((element) => element.extras_type != ExtrasType.penaltyRun)
        .fold(
            0,
            (sum, element) =>
                sum + element.runs_scored + (element.extras_awarded ?? 0));

    final average = wicketTaken == 0 ? 0.0 : runsConceded / wicketTaken;

    final strikeRate = wicketTaken == 0 ? 0.0 : bowledBallCount / wicketTaken;

    final economyRate = bowledBallCountForEconomyRate == 0
        ? 0.0
        : (runsConceded / bowledBallCountForEconomyRate) * 6;

    return (wicketTaken, average, strikeRate, economyRate);
  }

  (int, int, int) _calculateFieldingStats(List<BallScoreModel> ballList) {
    final catches = ballList
        .where((element) =>
            element.wicket_taker_id == state.currentUserId &&
            (element.wicket_type == WicketType.caught ||
                element.wicket_type == WicketType.caughtBehind ||
                element.wicket_type == WicketType.caughtAndBowled))
        .length;

    final runOut = ballList
        .where((element) =>
            element.wicket_taker_id == state.currentUserId &&
            element.wicket_type == WicketType.runOut)
        .length;

    final stumping = ballList
        .where((element) =>
            element.wicket_taker_id == state.currentUserId &&
            element.wicket_type == WicketType.stumped)
        .length;

    return (catches, runOut, stumping);
  }

  _cancelStreamSubscription() {
    _ballScoreStreamSubscription.cancel();
  }

  onResume() {
    _cancelStreamSubscription();
    _getUserRelatedBalls();
  }

  @override
  void dispose() {
    _cancelStreamSubscription();
    super.dispose();
  }
}

@freezed
class UserStatViewState with _$UserStatViewState {
  const factory UserStatViewState({
    Object? error,
    String? currentUserId,
    UserStat? userStat,
    @Default(false) bool loading,
  }) = _UserStatViewState;
}
