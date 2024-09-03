import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/team/user_detail/component/user_detail_bowling_content.dart';
import 'package:khelo/ui/flow/team/user_detail/user_detail_view_model.dart';

class UserDetailBattingContent extends ConsumerWidget {
  const UserDetailBattingContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(userDetailStateProvider);
    final testStats = state.testStats.battingStat;
    final otherStats = state.otherStats.battingStat;
    return ListView(
      children: [
        statsDataRow(
          context,
          isHeader: true,
          showDivider: false,
          title: context.l10n.user_detail_batting_title,
          subtitle1: context.l10n.user_detail_test_title,
          subtitle2: context.l10n.common_other_title,
        ),
        const SizedBox(height: 16),
        statsDataRow(
          context,
          showDivider: false,
          title: context.l10n.user_detail_matches_title,
          subtitle1: state.testMatchesCount.toString(),
          subtitle2: state.otherMatchesCount.toString(),
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
          subtitle1: testStats?.runScored.toString(),
          subtitle2: otherStats?.runScored.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_balls_title,
          subtitle1: testStats?.ballFaced.toString(),
          subtitle2: otherStats?.ballFaced.toString(),
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
          subtitle1: testStats?.strikeRate.toStringAsFixed(1),
          subtitle2: otherStats?.strikeRate.toStringAsFixed(1),
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
