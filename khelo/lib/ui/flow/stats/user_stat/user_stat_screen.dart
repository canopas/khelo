import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/stats/user_stat/user_stat_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class UserStatScreen extends ConsumerWidget {
  const UserStatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userStatViewStateProvider);
    final notifier = ref.watch(userStatViewStateProvider.notifier);

    if (state.loading) {
      return const AppProgressIndicator();
    }

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: () {
          notifier.cancelStreamSubscription();
          notifier.getUserRelatedBalls();
        },
      );
    }

    return _body(context, state);
  }

  Widget _body(BuildContext context, UserStatViewState state) {
    return ListView(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 50),
      children: [
        _battingStats(context, state),
        _bowlingStats(context, state),
        _fieldingStats(context, state),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: AppTextStyle.header4
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _battingStats(BuildContext context, UserStatViewState state) {
    final totalRuns = _getTotalRunScored(state);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
            context, context.l10n.my_stat_stats_batting_statics_title),
        _runScoredView(context, context.l10n.my_stat_stats_run_scored_title,
            totalRuns.toString()),
        const SizedBox(height: 16),
        _averageAndStrikeRateView(context, state, false),
        const SizedBox(height: 16),
        _ballFacedView(context, state),
      ],
    );
  }

  int _getTotalRunScored(UserStatViewState state) {
    return state.ballList
        .where((element) => element.batsman_id == state.currentUserId)
        .fold(0, (sum, element) => sum + element.runs_scored);
  }

  Widget _runScoredView(BuildContext context, String title, String count) {
    return Center(
      child: Text.rich(
        TextSpan(
            text: count,
            style: AppTextStyle.header1
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              TextSpan(
                text: "\n$title",
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textSecondary),
              )
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _averageAndStrikeRateView(
    BuildContext context,
    UserStatViewState state,
    bool isForBowling,
  ) {
    final (average, rate) = _getAverageAndStrikeRate(state, isForBowling);
    return Row(
      children: [
        Expanded(
            child: _averageCellView(
                context,
                "\n${isForBowling ? context.l10n.my_stat_stats_bowling_title : context.l10n.my_stat_stats_batting_title} ${context.l10n.my_stat_stats_average_title}",
                average.toString())),
        const SizedBox(width: 16),
        Expanded(
            child: _averageCellView(
                context,
                context.l10n.my_stat_stats_strike_rate_title,
                "${rate.toStringAsFixed(2)}%")),
      ],
    );
  }

  (double, double) _getAverageAndStrikeRate(
    UserStatViewState state,
    bool isForBowling,
  ) {
    if (isForBowling) {
      final deliveries = state.ballList
          .where((element) => element.bowler_id == state.currentUserId);

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

      final runsConceded = deliveries
          .where((element) => element.extras_type != ExtrasType.penaltyRun)
          .fold(
              0,
              (sum, element) =>
                  sum + element.runs_scored + (element.extras_awarded ?? 0));

      return (
        _calculateBowlingAverage(runsConceded, wicketTaken),
        _calculateBowlingStrikeRate(bowledBallCount, wicketTaken)
      );
    } else {
      final runScored = state.ballList
          .where((element) => element.batsman_id == state.currentUserId)
          .fold(0, (sum, element) => sum + element.runs_scored);

      final dismissal = state.ballList
          .where((element) => element.player_out_id == state.currentUserId)
          .length;

      final ballFaced = state.ballList
          .where((element) =>
              element.batsman_id == state.currentUserId &&
              (element.extras_type == null ||
                  element.extras_type == ExtrasType.legBye ||
                  element.extras_type == ExtrasType.bye))
          .length;

      return (
        _calculateBattingAverage(runScored, dismissal),
        _calculateBattingStrikeRate(runScored, ballFaced)
      );
    }
  }

  double _calculateBattingAverage(int totalRunsScored, int totalDismissals) {
    if (totalDismissals == 0) {
      return 0.0;
    }
    return totalRunsScored / totalDismissals;
  }

  double _calculateBattingStrikeRate(int totalRunsScored, int totalBallsFaced) {
    if (totalBallsFaced == 0) {
      return 0.0;
    }
    return (totalRunsScored / totalBallsFaced) * 100.0;
  }

  double _calculateBowlingAverage(
      int totalRunsConceded, int totalWicketsTaken) {
    if (totalWicketsTaken == 0) {
      return 0.0;
    }
    return totalRunsConceded / totalWicketsTaken;
  }

  double _calculateBowlingStrikeRate(
      int totalBallsBowled, int totalWicketsTaken) {
    if (totalWicketsTaken == 0) {
      return 0.0;
    }
    return totalBallsBowled / totalWicketsTaken;
  }

  double _calculateEconomyRate(UserStatViewState state) {
    final deliveries = state.ballList
        .where((element) => element.bowler_id == state.currentUserId);

    final bowledBallCount = deliveries
        .where((element) =>
            (element.extras_type == null ||
                element.extras_type == ExtrasType.legBye ||
                element.extras_type == ExtrasType.bye) &&
            element.wicket_type != WicketType.retired &&
            element.wicket_type != WicketType.retiredHurt &&
            element.wicket_type != WicketType.timedOut &&
            element.extras_type != ExtrasType.penaltyRun)
        .length;
    final totalRunsConceded = deliveries
        .where((element) => element.extras_type != ExtrasType.penaltyRun)
        .fold(
            0,
            (sum, element) =>
                sum + element.runs_scored + (element.extras_awarded ?? 0));
    if (bowledBallCount == 0) {
      return 0.0;
    }

    return (totalRunsConceded / bowledBallCount) * 6.0;
  }

  Widget _averageCellView(BuildContext context, String title, String count) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.containerLowOnSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
            text: count,
            style: AppTextStyle.header1
                .copyWith(color: context.colorScheme.textPrimary),
            children: [
              TextSpan(
                text: title,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textSecondary),
              )
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _ballFacedView(BuildContext context, UserStatViewState state) {
    final ballFaced = state.ballList
        .where((element) =>
            element.batsman_id == state.currentUserId &&
            (element.extras_type == null ||
                element.extras_type == ExtrasType.legBye ||
                element.extras_type == ExtrasType.bye))
        .length;
    return Row(
      children: [
        Expanded(
          child: _averageCellView(
            context,
            context.l10n.my_stat_stats_ball_faced_title,
            ballFaced.toString(),
          ),
        ),
      ],
    );
  }

  Widget _bowlingStats(BuildContext context, UserStatViewState state) {
    final wickets = _calculateWicketsTaken(state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
            context, context.l10n.my_stat_stats_bowling_statics_title),
        _runScoredView(context, context.l10n.common_wicket_taken_title,
            wickets.toString()),
        const SizedBox(height: 16),
        _averageAndStrikeRateView(context, state, true),
        const SizedBox(height: 16),
        _economyRate(context, state)
      ],
    );
  }

  int _calculateWicketsTaken(UserStatViewState state) {
    final wickets = state.ballList
        .where((element) =>
            element.bowler_id == state.currentUserId &&
            element.wicket_type != null &&
            (element.wicket_type == WicketType.retired ||
                element.wicket_type == WicketType.retiredHurt ||
                element.wicket_type == WicketType.timedOut))
        .length;

    return wickets;
  }

  Widget _economyRate(BuildContext context, UserStatViewState state) {
    final rate = _calculateEconomyRate(state);
    return Row(
      children: [
        Expanded(
            child: _averageCellView(
                context,
                context.l10n.my_stat_stats_economy_rate_title,
                rate.toStringAsFixed(2)))
      ],
    );
  }

  Widget _fieldingStats(BuildContext context, UserStatViewState state) {
    final catches = _calculateCatches(state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
            context, context.l10n.my_stat_stats_fielding_statics_title),
        _runScoredView(context, context.l10n.my_stat_stats_catches_title,
            catches.toString()),
        const SizedBox(height: 16),
        _runOutAndStumpingView(context, state)
      ],
    );
  }

  int _calculateCatches(UserStatViewState state) {
    final catchCounts = state.ballList
        .where((element) =>
            element.wicket_taker_id == state.currentUserId &&
            (element.wicket_type == WicketType.caught ||
                element.wicket_type == WicketType.caughtBehind ||
                element.wicket_type == WicketType.caughtAndBowled))
        .length;

    return catchCounts;
  }

  Widget _runOutAndStumpingView(BuildContext context, UserStatViewState state) {
    final (runOut, stumping) = _calculateRunOutAndStumpingCount(state);

    return Row(
      children: [
        Expanded(
            child: _averageCellView(
          context,
          context.l10n.my_stat_stats_run_out_title,
          runOut.toString(),
        )),
        const SizedBox(width: 16),
        Expanded(
            child: _averageCellView(
          context,
          context.l10n.my_stat_stats_stumping_title,
          stumping.toString(),
        )),
      ],
    );
  }

  (int, int) _calculateRunOutAndStumpingCount(UserStatViewState state) {
    final wicketTakenBalls = state.ballList
        .where((element) => element.wicket_taker_id == state.currentUserId);

    final runOut = wicketTakenBalls
        .where((element) => element.wicket_type == WicketType.runOut)
        .length;
    final stumping = wicketTakenBalls
        .where((element) => element.wicket_type == WicketType.stumped)
        .length;

    return (runOut, stumping);
  }
}
