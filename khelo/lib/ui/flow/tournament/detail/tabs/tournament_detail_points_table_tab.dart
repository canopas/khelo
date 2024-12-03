import 'package:data/api/team/team_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khelo/components/image_avatar.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/string_extensions.dart';
import 'package:khelo/ui/app_route.dart';
import 'package:style/animations/on_tap_scale.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/empty_screen.dart';

class TournamentDetailPointsTableTab extends ConsumerWidget {
  final List<TournamentTeamStat> teamStats;

  const TournamentDetailPointsTableTab({
    super.key,
    required this.teamStats,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (teamStats.isEmpty) {
      return EmptyScreen(
        title: context.l10n.tournament_detail_points_table_empty_title,
        description:
            context.l10n.tournament_detail_points_table_empty_description,
        isShowButton: false,
      );
    }

    return ListView(
      padding: context.mediaQueryPadding.copyWith(top: 0) +
          EdgeInsets.all(16).copyWith(bottom: 24),
      children: [
        Text(
          context.l10n.tournament_detail_points_table_points_title,
          style: AppTextStyle.header4
              .copyWith(color: context.colorScheme.textPrimary),
        ),
        const SizedBox(height: 16),
        _buildTable(context),
      ],
    );
  }

  Widget _buildTable(BuildContext context) {
    final headers = [
      context.l10n.tournament_detail_points_table_team,
      context.l10n.common_m_title,
      context.l10n.tournament_detail_points_table_wins,
      context.l10n.tournament_detail_points_table_losses,
      context.l10n.tournament_detail_points_table_pts,
      context.l10n.tournament_detail_points_table_nrr,
    ];

    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: DataTable(
            columnSpacing: 8,
            headingRowHeight: 40,
            horizontalMargin: 16,
            dataRowMaxHeight: 64,
            decoration: BoxDecoration(color: context.colorScheme.containerHigh),
            dataRowColor: WidgetStateProperty.all(context.colorScheme.surface),
            columns: headers
                .map((title) => _dataColumn(
                      context,
                      title: title,
                      width: (title == headers.first)
                          ? context.mediaQuerySize.width * 0.4
                          : context.mediaQuerySize.width * 0.07,
                    ))
                .toList(),
            rows: teamStats
                .map(
                  (stat) => DataRow(cells: [
                    _teamProfileDataCell(context, stat.team),
                    _dataCell(context, text: stat.played_matches.toString()),
                    _dataCell(context, text: stat.wins.toString()),
                    _dataCell(context, text: stat.losses.toString()),
                    _dataCell(
                      context,
                      text: stat.points.toString(),
                      textColor: context.colorScheme.textPrimary,
                    ),
                    _dataCell(context, text: stat.nrr.toStringAsFixed(1)),
                  ]),
                )
                .toList()));
  }

  DataCell _teamProfileDataCell(BuildContext context, TeamModel? team) {
    return team == null
        ? const DataCell(SizedBox.shrink())
        : DataCell(OnTapScale(
            onTap: () => AppRoute.teamDetail(teamId: team.id).push(context),
            child: Row(
              children: [
                ImageAvatar(
                  initial: team.name_initial ?? team.name.initials(limit: 1),
                  imageUrl: team.profile_img_url,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Text(
                  team.name_initial ?? team.name.initials(limit: 2),
                  style: AppTextStyle.subtitle2.copyWith(
                    color: context.colorScheme.textPrimary,
                  ),
                )
              ],
            ),
          ));
  }

  DataColumn _dataColumn(
    BuildContext context, {
    required String title,
    required double width,
  }) {
    return DataColumn(
        label: SizedBox(
      width: width,
      child: Text(
        title,
        style: AppTextStyle.body2.copyWith(
          color: context.colorScheme.textPrimary,
        ),
      ),
    ));
  }

  DataCell _dataCell(
    BuildContext context, {
    required String text,
    Color? textColor,
  }) {
    return DataCell(Text(
      text,
      style: AppTextStyle.caption.copyWith(
        color: textColor ?? context.colorScheme.textDisabled,
      ),
    ));
  }
}
