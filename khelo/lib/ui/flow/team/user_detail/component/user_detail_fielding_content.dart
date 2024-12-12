import 'package:data/api/user/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/ui/flow/team/user_detail/component/user_detail_bowling_content.dart';

class UserDetailFieldingContent extends ConsumerWidget {
  final int testMatchesCount;
  final int otherMatchesCount;
  final Fielding? testStats;
  final Fielding? otherStats;

  const UserDetailFieldingContent({
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
          title: context.l10n.common_fielding,
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
          title: context.l10n.user_detail_catches_title,
          subtitle1: testStats?.catches.toString(),
          subtitle2: otherStats?.catches.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_run_out_title,
          subtitle1: testStats?.runOut.toString(),
          subtitle2: otherStats?.runOut.toString(),
        ),
        statsDataRow(
          context,
          title: context.l10n.user_detail_stumping_title,
          subtitle1: testStats?.stumping.toString(),
          subtitle2: otherStats?.stumping.toString(),
        ),
      ],
    );
  }
}
