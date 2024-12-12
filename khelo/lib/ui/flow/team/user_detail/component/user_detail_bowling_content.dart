import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

class UserDetailBowlingContent extends ConsumerWidget {
  final int testMatchesCount;
  final int otherMatchesCount;
  final Bowling? testStats;
  final Bowling? otherStats;

  const UserDetailBowlingContent({
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
          title: context.l10n.common_bowling,
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
          title: context.l10n.user_detail_balls_title,
          subtitle1: testStats?.balls.toString(),
          subtitle2: otherStats?.balls.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_runs_title,
          subtitle1: testStats?.runs_conceded.toString(),
          subtitle2: otherStats?.runs_conceded.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_maidens_title,
          subtitle1: testStats?.maiden.toString(),
          subtitle2: otherStats?.maiden.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_wickets_title,
          subtitle1: testStats?.wicket_taken.toString(),
          subtitle2: otherStats?.wicket_taken.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_eco_title,
          subtitle1: testStats?.economy_rate.toStringAsFixed(1),
          subtitle2: otherStats?.economy_rate.toStringAsFixed(1),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_no_ball_title,
          subtitle1: testStats?.no_balls.toString(),
          subtitle2: otherStats?.no_balls.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_wide_ball_title,
          subtitle1: testStats?.wide_balls.toString(),
          subtitle2: otherStats?.wide_balls.toString(),
        ),
      ],
    );
  }
}

Widget statsDataRow(
  BuildContext context, {
  bool isHeader = false,
  bool showDivider = true,
  required String title,
  required String? subtitle1,
  required String? subtitle2,
}) {
  return Column(
    children: [
      if (showDivider) Divider(color: context.colorScheme.outline),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
                flex: 4,
                child: Text(
                  title,
                  style: isHeader
                      ? AppTextStyle.header4
                          .copyWith(color: context.colorScheme.textPrimary)
                      : AppTextStyle.subtitle3
                          .copyWith(color: context.colorScheme.textSecondary),
                )),
            Expanded(
                child: Text(
              subtitle1 ?? '0',
              textAlign: TextAlign.center,
              style: isHeader
                  ? AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textPrimary)
                  : AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textPrimary),
            )),
            Expanded(
                child: Text(
              subtitle2 ?? '0',
              textAlign: TextAlign.center,
              style: isHeader
                  ? AppTextStyle.subtitle1
                      .copyWith(color: context.colorScheme.textPrimary)
                  : AppTextStyle.subtitle2
                      .copyWith(color: context.colorScheme.textPrimary),
            )),
          ],
        ),
      ),
    ],
  );
}
