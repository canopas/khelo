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

class _UserStatScreenState extends ConsumerState<UserStatScreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late UserStatViewNotifier notifier;
  bool _wantKeepAlive = true;

  @override
  bool get wantKeepAlive => _wantKeepAlive;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    notifier = ref.read(userStatViewStateProvider.notifier);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      setState(() {
        _wantKeepAlive = false;
      });
    } else if (state == AppLifecycleState.resumed) {
      setState(() {
        _wantKeepAlive = true;
      });
    } else if (state == AppLifecycleState.detached) {
      // deallocate resources
      notifier.dispose();
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Builder(builder: (context) => _body(context));
  }

  Widget _body(BuildContext context) {
    final state = ref.watch(userStatViewStateProvider);

    if (state.loading) return const Center(child: AppProgressIndicator());

    if (state.error != null) {
      return ErrorScreen(
        error: state.error,
        onRetryTap: notifier.onResume,
      );
    }
    if (state.userStat == null) return const SizedBox();

    return ListView(
      padding: const EdgeInsets.all(16) + context.mediaQueryPadding,
      children: [
        if (state.userStat?.battingStat != null) ...[
          _sectionTitle(
              context, context.l10n.my_stat_stats_batting_statics_title),
          _battingStats(context, state.userStat?.battingStat),
        ],
        const SizedBox(height: 40),
        if (state.userStat?.bowlingStat != null) ...[
          _sectionTitle(
              context, context.l10n.my_stat_stats_bowling_statics_title),
          _bowlingStats(context, state.userStat?.bowlingStat),
        ],
        const SizedBox(height: 40),
        if (state.userStat?.fieldingStat != null) ...[
          _sectionTitle(
              context, context.l10n.my_stat_stats_fielding_statics_title),
          _fieldingStats(context, state.userStat?.fieldingStat),
        ],
      ],
    );
  }

  Widget _battingStats(BuildContext context, BattingStat? battingStat) {
    if (battingStat == null) return const SizedBox();

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
            count: battingStat.runScored.toString(),
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _subStatisticView(context,
                    title: context.l10n.common_batting_average_title,
                    count: battingStat.average.toStringAsFixed(2)),
                _subStatisticView(context,
                    title: context.l10n.my_stat_stats_strike_rate_title,
                    count: '${battingStat.strikeRate.toStringAsFixed(2)}%'),
                _subStatisticView(context,
                    title: context.l10n.my_stat_stats_ball_faced_title,
                    count: battingStat.ballFaced.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bowlingStats(BuildContext context, BowlingStat? bowlingStat) {
    if (bowlingStat == null) return const SizedBox();

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
            count: bowlingStat.wicketTaken.toString(),
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _subStatisticView(context,
                    title: context.l10n.common_bowling_average_title,
                    count: bowlingStat.average.toStringAsFixed(2)),
                _subStatisticView(context,
                    title: context.l10n.my_stat_stats_strike_rate_title,
                    count: '${bowlingStat.strikeRate.toStringAsFixed(2)}%'),
                _subStatisticView(context,
                    title: context.l10n.my_stat_stats_economy_rate_title,
                    count: bowlingStat.economyRate.toStringAsFixed(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldingStats(BuildContext context, FieldingStat? fieldingStat) {
    if (fieldingStat == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(16)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _subStatisticView(context,
                title: context.l10n.my_stat_stats_catches_title,
                count: fieldingStat.catches.toString()),
            _subStatisticView(context,
                title: context.l10n.common_run_out_title,
                count: fieldingStat.runOut.toString()),
            _subStatisticView(context,
                title: context.l10n.my_stat_stats_stumping_title,
                count: fieldingStat.stumping.toString()),
          ],
        ),
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
          padding: const EdgeInsets.all(12),
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
              const SizedBox(height: 4),
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
