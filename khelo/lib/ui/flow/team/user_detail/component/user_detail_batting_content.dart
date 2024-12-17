import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/team/user_detail/component/user_detail_bowling_content.dart';

class UserDetailBattingContent extends ConsumerWidget {
  final int testMatchesCount;
  final int otherMatchesCount;
  final Batting? testStats;
  final Batting? otherStats;

  const UserDetailBattingContent({
    super.key,
    this.testMatchesCount = 0,
    this.otherMatchesCount = 0,
    this.testStats,
    this.otherStats,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: [
        statsDataRow(
          context,
          isHeader: true,
          showDivider: false,
          title: context.l10n.common_batting,
          subtitle1: context.l10n.user_detail_test_title,
          subtitle2: context.l10n.common_other_title,
        ),
        const SizedBox(height: 16),
        statsDataRow(
          context,
          showDivider: false,
          title: context.l10n.user_detail_matches_title,
          subtitle1: testMatchesCount.toString(),
          subtitle2: otherMatchesCount.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_innings_title,
          subtitle1: testStats?.innings.toString(),
          subtitle2: otherStats?.innings.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_runs_title,
          subtitle1: testStats?.run_scored.toString(),
          subtitle2: otherStats?.run_scored.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_balls_title,
          subtitle1: testStats?.ball_faced.toString(),
          subtitle2: otherStats?.ball_faced.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_average_title,
          subtitle1: testStats?.average.toStringAsFixed(1),
          subtitle2: otherStats?.average.toStringAsFixed(1),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_strike_rate_title,
          subtitle1: testStats?.strike_rate.toStringAsFixed(1),
          subtitle2: otherStats?.strike_rate.toStringAsFixed(1),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_fours_title,
          subtitle1: testStats?.fours.toString(),
          subtitle2: otherStats?.fours.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_sixes_title,
          subtitle1: testStats?.sixes.toString(),
          subtitle2: otherStats?.sixes.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_ducks_title,
          subtitle1: testStats?.ducks.toString(),
          subtitle2: otherStats?.ducks.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_fifties_title,
          subtitle1: testStats?.fifties.toString(),
          subtitle2: otherStats?.fifties.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_hundreds_title,
          subtitle1: testStats?.hundreds.toString(),
          subtitle2: otherStats?.hundreds.toString(),
        ),
      ],
    );
  }
}
