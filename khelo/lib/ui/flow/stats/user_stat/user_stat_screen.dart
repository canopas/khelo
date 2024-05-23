import 'package:data/api/ball_score/ball_score_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/error_screen.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/stats/user_stat/user_stat_view_model.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/indicator/progress_indicator.dart';
import 'package:style/text/app_text_style.dart';

class UserStatScreen extends ConsumerStatefulWidget {
  const UserStatScreen({super.key});

  @override
  ConsumerState createState() => _UserStatScreenState();
}

class _UserStatScreenState extends ConsumerState<UserStatScreen> {
  late UserStatViewNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(userStatViewStateProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) => _body(context));
  }

  Widget _body(BuildContext context) {
    final state = ref.watch(userStatViewStateProvider);

    if (state.loading) return const AppProgressIndicator();

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onResume,
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16) + context.mediaQueryPadding,
      children: [
        _sectionTitle(
            context, context.l10n.my_stat_stats_batting_statics_title),
        _battingStats(context, state.userStat),
        const SizedBox(height: 40),
        _sectionTitle(
            context, context.l10n.my_stat_stats_bowling_statics_title),
        _bowlingStats(context, state.userStat),
        const SizedBox(height: 40),
        _sectionTitle(
            context, context.l10n.my_stat_stats_fielding_statics_title),
        _fieldingStats(context, state.userStat),
      ],
    );
  }

  Widget _battingStats(BuildContext context, UserStat? userStat) {
    if (userStat == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _mainStatisticView(
            context,
            title: context.l10n.my_stat_stats_run_scored_title,
            count: userStat.run_scored.toString(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _subStatisticView(context,
                  title: context.l10n.my_stat_stats_batting_title,
                  count: userStat.batting_average.toString()),
              _subStatisticView(context,
                  title: context.l10n.my_stat_stats_strike_rate_title,
                  count: '${userStat.batting_strike_rate.toStringAsFixed(2)}%'),
              _subStatisticView(context,
                  title: context.l10n.my_stat_stats_ball_faced_title,
                  count: userStat.ball_faced.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bowlingStats(BuildContext context, UserStat? userStat) {
    if (userStat == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _mainStatisticView(
            context,
            title: context.l10n.common_wicket_taken_title,
            count: userStat.wicket_taken.toString(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _subStatisticView(context,
                  title: context.l10n.my_stat_stats_bowling_title,
                  count: userStat.bowling_average.toString()),
              _subStatisticView(context,
                  title: context.l10n.my_stat_stats_strike_rate_title,
                  count: '${userStat.bowling_strike_rate.toStringAsFixed(2)}%'),
              _subStatisticView(context,
                  title: context.l10n.my_stat_stats_economy_rate_title,
                  count: userStat.economy_rate.toStringAsFixed(2)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fieldingStats(BuildContext context, UserStat? userStat) {
    if (userStat == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _subStatisticView(context,
              title: context.l10n.my_stat_stats_catches_title,
              count: userStat.catches.toString()),
          _subStatisticView(context,
              title: context.l10n.my_stat_stats_run_out_title,
              count: userStat.run_out.toString()),
          _subStatisticView(context,
              title: context.l10n.my_stat_stats_stumping_title,
              count: userStat.stumping.toString()),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) => Text(title,
      style: AppTextStyle.header4
          .copyWith(color: context.colorScheme.textPrimary));

  Widget _mainStatisticView(
    BuildContext context, {
    required String title,
    required String count,
  }) {
    return Container(
        width: context.mediaQuerySize.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: context.colorScheme.containerLow,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: AppTextStyle.subtitle1
                  .copyWith(color: context.colorScheme.textPrimary),
            ),
            Text(
              title,
              style: AppTextStyle.body2
                  .copyWith(color: context.colorScheme.textSecondary),
            ),
          ],
        ));
  }

  Widget _subStatisticView(
    BuildContext context, {
    required String title,
    required String count,
  }) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: context.colorScheme.containerLow,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count,
                style: AppTextStyle.subtitle1
                    .copyWith(color: context.colorScheme.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyle.body2
                    .copyWith(color: context.colorScheme.textSecondary),
              ),
            ],
          )),
    );
  }
}
