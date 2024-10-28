import 'package:data/api/match/match_model.dart';
import 'package:data/api/tournament/tournament_model.dart';
import 'package:data/api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo/domain/extensions/context_extensions.dart';
import 'package:khelo/domain/extensions/enum_extensions.dart';
import 'package:style/extensions/context_extensions.dart';
import 'package:style/text/app_text_style.dart';

import '../../../../../components/action_bottom_sheet.dart';
import '../../../../../components/empty_screen.dart';
import '../../../../../components/image_avatar.dart';
import '../components/filter_tab_view.dart';
import '../tournament_detail_view_model.dart';

class TournamentDetailStatsTab extends ConsumerWidget {
  final Function(KeyStatTag) onFiltered;

  const TournamentDetailStatsTab({
    super.key,
    required this.onFiltered,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tournamentDetailStateProvider);

    if (state.tournament!.keyStats.isEmpty && state.filteredStats.isEmpty) {
      return EmptyScreen(
        title: context.l10n.tournament_detail_stats_empty_title,
        description: context.l10n.tournament_detail_stats_empty_description,
        isShowButton: false,
      );
    }

    return ListView(
      padding: context.mediaQueryPadding.copyWith(top: 0) +
          EdgeInsets.all(16).copyWith(bottom: 24),
      children: [
        FilterTabView(
          title: context.l10n.tournament_detail_stats_tab,
          onFilter: () => showFilterOptionSelectionSheet(
            context,
            keyStatFilter: state.statFilter,
            onTap: onFiltered,
          ),
          filterValue: state.statFilter.getString(context),
        ),
        const SizedBox(height: 16),
        if (state.filteredStats.isNotEmpty) ...[
          _playerStatsView(context, state),
        ] else ...[
          SizedBox(
            height: context.mediaQuerySize.height / 2.5,
            child: EmptyScreen(
              title: context.l10n.tournament_detail_stats_empty_filter_title,
              description:
                  context.l10n.tournament_detail_stats_empty_filter_description,
              isShowButton: false,
            ),
          )
        ],
      ],
    );
  }

  Widget _playerStatsView(BuildContext context, TournamentDetailState state) {
    final headers = [
      context.l10n.tournament_detail_stats_player_title,
      context.l10n.common_m_title,
      context.l10n.tournament_detail_stats_avg_title,
      context.l10n.tournament_detail_stats_runs_title,
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: DataTable(
          columnSpacing: 8,
          headingRowHeight: 40,
          horizontalMargin: 16,
          dataRowMaxHeight: 74,
          decoration: BoxDecoration(color: context.colorScheme.containerHigh),
          dataRowColor: WidgetStateProperty.all(context.colorScheme.surface),
          columns: headers
              .map((title) => _dataColumn(
                    context,
                    title: title,
                    width: (title == headers.first)
                        ? context.mediaQuerySize.width * 0.45
                        : context.mediaQuerySize.width * 0.1,
                  ))
              .toList(),
          rows: state.filteredStats
              .map((e) => _dataRow(
                    context,
                    e,
                    state.tournament!.matches,
                  ))
              .toList()),
    );
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

  DataRow _dataRow(
    BuildContext context,
    PlayerKeyStat keyStat,
    List<MatchModel> matches,
  ) {
    final matchCount = matches
        .where((element) => element.players.contains(keyStat.player.id))
        .length;
    final average =
        keyStat.stats.bowlingStat?.average.toStringAsFixed(1) ?? '0.0';
    final runs = keyStat.stats.battingStat?.runScored.toString() ?? '0';

    return DataRow(
      cells: [
        _playerProfileDataCell(context, keyStat.player),
        _dataCell(context, text: matchCount.toString()),
        _dataCell(context, text: average),
        _dataCell(
          context,
          text: runs,
          textColor: context.colorScheme.textPrimary,
        ),
      ],
    );
  }

  DataCell _playerProfileDataCell(BuildContext context, UserModel player) {
    return DataCell(
      Row(
        children: [
          ImageAvatar(
            size: 40,
            initial: player.nameInitial,
            imageUrl: player.profile_img_url,
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  player.name ?? '',
                  style: AppTextStyle.body1.copyWith(
                    color: context.colorScheme.textPrimary,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (player.player_role != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    player.player_role!.getString(context),
                    style: AppTextStyle.caption
                        .copyWith(color: context.colorScheme.textSecondary),
                  )
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataCell _dataCell(BuildContext context,
      {required String text, Color? textColor}) {
    return DataCell(Text(
      text,
      style: AppTextStyle.caption.copyWith(
        color: textColor ?? context.colorScheme.textDisabled,
      ),
    ));
  }

  void showFilterOptionSelectionSheet(
    BuildContext context, {
    required Function(KeyStatTag) onTap,
    KeyStatTag? keyStatFilter,
  }) async {
    return await showActionBottomSheet(
        context: context,
        items: KeyStatTag.values
            .map((option) => BottomSheetAction(
                  title: option.getString(context),
                  enabled: keyStatFilter != option,
                  showCheck: keyStatFilter == option,
                  onTap: () {
                    context.pop();
                    onTap(option);
                  },
                ))
            .toList());
  }
}
